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
int loginDay;

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
    this._getLoginDay();
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
                      title: Text("????????????????????????"),
                      content: Text("????????????$loginDay??????"),
                      actions: <Widget>[
                        // ???????????????
                        FlatButton(
                          child: Text("??????????????????"),
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
                child: Text('??????~'),
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

  // ???????????????????????????
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

  // ?????????????????????
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

  // ????????????????????????
  void _getCharacter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      color = prefs.getInt('characterCount') ?? 1;
    });
  }

  // ??????????????????
  void setCharacter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('characterCount', color);
  }

  // ??????????????????????????????????????????
  void _getTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      beforeTime = prefs.getInt('BeforeTime') ?? 1;
    });
  }

  // ????????????????????????????????????
  void setTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('BeforeTime', beforeTime);
  }

  // ????????????????????????????????????
  void comparisonTime() {
    if ((int.parse(nowTime) > beforeTime)) {
      beforeTime = int.parse(nowTime);
      setTime();
      lvFood++;
      setLvFood();
      loginDay++;
      setLoginDay();
      Navigator.pop(context);
      _dialogGetFood();
    } else {
      beforeTime = int.parse(nowTime);
      setTime();
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("????????????????????????"),
            content: Text("????????????????????????????????????"),
            actions: <Widget>[
              // ???????????????
              FlatButton(
                child: Text("??????"),
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
              ),
            ],
          );
        },
      );
    }
  }

  // ??????????????????
  void _getLvFood() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lvFood = prefs.getInt('LvFood') ?? 0;
    });
  }

  // ????????????
  void setLvFood() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('LvFood', lvFood);
  }

  // Lv????????????
  void _getLv() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lv = prefs.getInt('Lv') ?? 0;
    });
  }

  // Lv??????
  void setLv() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('Lv', lv);
  }

  // LvGauge????????????
  void _getLvGauge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lvGauge = prefs.getInt('LvGauge') ?? 0;
    });
  }

  // LvGauge??????
  void setLvGauge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('LvGauge', lvGauge);
  }

  // Name????????????
  void _getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      petName = prefs.getString('PetName') ?? '????????????';
    });
  }

  // Name??????
  void setName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('PetName', petName);
  }

  // Login????????????
  void _getLoginDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loginDay = prefs.getInt('LoginDay') ?? 1;
    });
  }

  // Login??????
  void setLoginDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('LoginDay', loginDay);
  }

  // ???????????????(???????????????)
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
                title: Text('???????????????????????????'),
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
