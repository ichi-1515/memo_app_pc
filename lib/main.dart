import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import "package:intl/intl.dart";

import 'add/edit.dart';
import 'character.dart';
import 'color.dart';
import 'food.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memo App',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MemoList(),
    );
  }
}

int color;
int beforeTime;
int lvFood;
int lv;
int lvGauge;
String petName;

class MemoListState extends State<MemoList> {
  var _memoList = new List<String>();
  var _currentIndex = -1;
  bool _loading = true;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  bool _comment = true;
  var nowTime = DateFormat('yyyyMMdd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    this.loadMemoList();
    this._getCharacter();
    this._getTime();
    this._getLvFood();
    this._getLv();
    this._getLvGauge();
    this._getName();
  }

  @override
  Widget build(BuildContext context) {
    final title = "Home";
    if (_loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Padding(
                padding: EdgeInsets.only(top: 45),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
            ),
            ListTile(
              leading: Icon(Icons.pets),
              title: Text(
                'Character',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {
                pushWithReloadByReturnCharacter(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.format_color_fill),
              title: Text(
                'Color',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {
                pushWithReloadByReturnColor(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.set_meal_outlined),
              title: Text(
                'Food',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {
                // Update the state of the app.
                pushWithReloadByReturnFood(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.check_box_outlined),
              title: Text(
                'Login',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text("ログインボーナス"),
                      content: Text("ログイン〇日目"),
                      actions: <Widget>[
                        // ボタン領域
                        FlatButton(
                          child: Text("エサをもらう"),
                          onPressed: () => comparisonTime(),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          LimitedBox(
            maxHeight: 565,
            child: _buildList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: _comment ? 0.0 : 1.0,
                duration: Duration(milliseconds: 200),
                child: Text('にゃ~'),
              ),
              GestureDetector(
                onTap: () {
                  commentChange();
                },
                child: Image.asset(
                  'images/cat_$color.GIF',
                  height: 100,
                  width: 100,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: _addMemo,
        tooltip: 'New Memo',
        child: Icon(Icons.add),
      ),
    );
  }

  void loadMemoList() {
    SharedPreferences.getInstance().then((prefs) {
      const key = "memo-list";
      if (prefs.containsKey(key)) {
        _memoList = prefs.getStringList(key);
      }
      setState(() {
        _loading = false;
      });
    });
  }

  void _addMemo() {
    setState(() {
      _memoList.add("");
      _currentIndex = _memoList.length - 1;
      storeMemoList();
      Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new Edit(_memoList[_currentIndex], _onChanged);
        },
      ));
    });
  }

  void _onChanged(String text) {
    setState(() {
      _memoList[_currentIndex] = text;
      storeMemoList();
    });
  }

  void storeMemoList() async {
    final prefs = await SharedPreferences.getInstance();
    const key = "memo-list";
    final success = await prefs.setStringList(key, _memoList);
    if (!success) {
      debugPrint("Failed to store value");
    }
  }

  Widget _buildList() {
    final itemCount = _memoList.length == 0 ? 0 : _memoList.length * 2 - 1;
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: itemCount,
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) return Divider(height: 2);
        final index = (i / 2).floor();
        final memo = _memoList[index];
        return _buildWrappedRow(memo, index);
      },
    );
  }

  Widget _buildWrappedRow(String content, int index) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: Key(content),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          _memoList.removeAt(index);
          storeMemoList();
        });
      },
      child: _buildRow(content, index),
    );
  }

  Widget _buildRow(String content, int index) {
    return ListTile(
      title: Text(
        content,
        style: _biggerFont,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        _currentIndex = index;
        Navigator.of(context)
            .push(MaterialPageRoute<void>(builder: (BuildContext context) {
          return new Edit(_memoList[_currentIndex], _onChanged);
        }));
      },
    );
  }

  // コメント表示非表示
  void commentChange() {
    if (_comment == true) {
      setState(() {
        _comment = false;
      });
    } else {
      setState(() {
        _comment = true;
      });
    }
  }

  // キャラ色引継ぎ
  void pushWithReloadByReturnColor(BuildContext context) async {
    final result = await Navigator.push(
      // [*3]
      context,
      new MaterialPageRoute<bool>(
        // [*4]
        builder: (BuildContext context) => Color(),
      ),
    );

    if (result) {
      // [*5]
      setState(() {});
    }
  }

  void pushWithReloadByReturnCharacter(BuildContext context) async {
    final result = await Navigator.push(
      // [*3]
      context,
      new MaterialPageRoute<bool>(
        // [*4]
        builder: (BuildContext context) => Character(),
      ),
    );

    if (result) {
      // [*5]
      setState(() {});
    }
  }

  void pushWithReloadByReturnFood(BuildContext context) async {
    final result = await Navigator.push(
      // [*3]
      context,
      new MaterialPageRoute<bool>(
        // [*4]
        builder: (BuildContext context) => Food(),
      ),
    );

    if (result) {
      // [*5]
      setState(() {});
    }
  }

  // キャラ色読み込み
  void _getCharacter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      color = prefs.getInt('characterCount') ?? 1;
    });
  }

  // キャラ色保存
  void setCharacter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('characterCount', color);
  }

  // ログインボーナス時間読み込み
  void _getTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      beforeTime = prefs.getInt('BeforeTime') ?? 1;
    });
  }

  // ログインボーナス時間保存
  void setTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('BeforeTime', beforeTime);
  }

  // ログインボーナス時間比較
  void comparisonTime() {
    if ((int.parse(nowTime) > beforeTime)) {
      beforeTime = int.parse(nowTime);
      setTime();
      lvFood++;
      setLvFood();
      Navigator.pop(context);
      _dialogGetFood();
    } else {
      beforeTime = int.parse(nowTime);
      setTime();
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("ログインボーナス"),
            content: Text("今日は既にもらっています"),
            actions: <Widget>[
              // ボタン領域
              FlatButton(
                child: Text("戻る"),
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
              ),
            ],
          );
        },
      );
    }
  }

  // エサ読み込み
  void _getLvFood() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lvFood = prefs.getInt('LvFood') ?? 0;
    });
  }

  // エサ保存
  void setLvFood() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('LvFood', lvFood);
  }

  // Lv読み込み
  void _getLv() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lv = prefs.getInt('Lv') ?? 0;
    });
  }

  // Lv保存
  void setLv() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('Lv', lv);
  }

  // LvGauge読み込み
  void _getLvGauge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lvGauge = prefs.getInt('LvGauge') ?? 0;
    });
  }

  // LvGauge保存
  void setLvGauge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('LvGauge', lvGauge);
  }

  // Name読み込み
  void _getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      petName = prefs.getString('PetName') ?? 'めもすけ';
    });
  }

  // Name保存
  void setName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('PetName', petName);
  }

  // ダイアログ(エサゲット)
  void _dialogGetFood() {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                title: Text('エサをもらいました'),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }
}

class MemoList extends StatefulWidget {
  @override
  MemoListState createState() => MemoListState();
}
