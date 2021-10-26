import 'package:flutter/material.dart';
import 'main.dart';

class FoodState extends State<Food> {
  MemoListState memoListState = MemoListState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food'),
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context, true),
        ),
      ),
      // 背景画像
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg_1.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.srcOver),
          ),
        ),

        //中身
        child: Center(
          child: Container(
            width: 360,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                ),
                GestureDetector(
                  child: Image.asset(
                    'images/cat_$color.GIF',
                    height: 200,
                    width: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                ),
                Text(
                  " エサをあげますか？",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 45),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.set_meal_outlined,
                      color: Colors.white,
                      size: 60,
                    ),
                    Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 60,
                    ),
                    Text(
                      '$lvFood',
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        // 1個
                        oneFood();
                      },
                      color: Colors.grey,
                      child: Text(
                        '1個',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        // 全部
                        allFood();
                      },
                      color: Colors.grey,
                      child: Text(
                        '全部',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  color: Colors.redAccent,
                  child: Text(
                    'もどる',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ダイアログ(エサなし)
  void _dialogNotFood() {
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
                title: Text('エサがありません'),
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

  // ダイアログ(LvUp)
  void _dialogLvUp() {
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
                title: Text('レベルがあがりました！'),
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

  // エサ1個あげる
  void oneFood() {
    if (lvFood > 0) {
      setState(() {
        lvFood--;
        memoListState.setLvFood();
        lvUpOneFood();
        _dialogLvUp();
      });
    } else {
      _dialogNotFood();
    }
  }

  // エサ全部あげる
  void allFood() {
    if (lvFood > 0) {
      setState(() {
        lvUpAllFood();
        lvFood = 0;
        memoListState.setLvFood();
        _dialogLvUp();
      });
    } else {
      _dialogNotFood();
    }
  }

  // LvUpOneFood
  void lvUpOneFood() {
    if (lv < 10) {
      setState(() {
        lv++;
      });
    } else if ((lv >= 10) && (lv < 20)) {
      setState(() {
        lvGauge++;
      });
      if (lvGauge == 2) {
        setState(() {
          lv++;
          lvGauge = 0;
        });
      }
    } else if (lv >= 20) {
      setState(() {
        lvGauge++;
      });
      if (lvGauge == 5) {
        setState(() {
          lv++;
          lvGauge = 0;
        });
      }
    }
    memoListState.setLv();
    memoListState.setLvGauge();
  }

  // LvUpAllFood
  void lvUpAllFood() {
    for (var i = 0; i < lvFood; i++) {
      if (lv < 10) {
        setState(() {
          lv++;
        });
      } else if ((lv >= 10) && (lv < 20)) {
        setState(() {
          lvGauge++;
        });
        if (lvGauge == 2) {
          setState(() {
            lv++;
            lvGauge = 0;
          });
        }
      } else if (lv >= 20) {
        setState(() {
          lvGauge++;
        });
        if (lvGauge == 5) {
          setState(() {
            lv++;
            lvGauge = 0;
          });
        }
      }
    }
    memoListState.setLv();
    memoListState.setLvGauge();
  }
}

class Food extends StatefulWidget {
  @override
  FoodState createState() => FoodState();
}
