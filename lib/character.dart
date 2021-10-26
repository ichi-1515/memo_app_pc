import 'package:flutter/material.dart';
import 'main.dart';
import 'color.dart';
import 'food.dart';
import 'name.dart';

class CharacterState extends State<Character> {
  bool _comment = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Character'),
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
          ),
        ),

        // 中身
        child: Center(
          child: Container(
            width: 360,
            child: Column(
              children: [
                // ColorChangeBtn
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonTheme(
                        minWidth: 60,
                        height: 60,
                        child: RaisedButton(
                          color: Colors.grey,
                          shape: const CircleBorder(),
                          onPressed: () {
                            pushWithReloadByReturnColor(context);
                          },
                          child: Icon(
                            Icons.format_color_fill,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // FoodBtn
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonTheme(
                        minWidth: 60,
                        height: 60,
                        child: RaisedButton(
                          color: Colors.grey,
                          shape: const CircleBorder(),
                          onPressed: () {
                            pushWithReloadByReturnFood(context);
                          },
                          child: Icon(
                            Icons.set_meal_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // FoodLv
                Padding(
                  padding: const EdgeInsets.only(top: 55, right: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ButtonTheme(
                          minWidth: 30,
                          height: 30,
                          child: RaisedButton(
                            color: Colors.grey,
                            shape: const CircleBorder(),
                            onPressed: () {
                              pushWithReloadByReturnName(context);
                            },
                            child: Icon(
                              Icons.drive_file_rename_outline,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '$petName Lv ',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$lv",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // CatImg
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: AnimatedOpacity(
                    opacity: _comment ? 0.0 : 1.0,
                    duration: Duration(milliseconds: 200),
                    child: SizedBox(
                      width: 300,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            top: 10, right: 30, bottom: 10, left: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Text(
                          'にゃ~',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    commentChange();
                  },
                  child: Center(
                    child: Image.asset(
                      'images/cat_$color.GIF',
                      height: 250,
                      width: 250,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  void pushWithReloadByReturnColor(BuildContext context) async {
    final result = await Navigator.push(
      context,
      new MaterialPageRoute<bool>(
        builder: (BuildContext context) => Color(),
      ),
    );

    if (result) {
      setState(() {});
    }
  }

  void pushWithReloadByReturnFood(BuildContext context) async {
    final result = await Navigator.push(
      context,
      new MaterialPageRoute<bool>(
        builder: (BuildContext context) => Food(),
      ),
    );

    if (result) {
      setState(() {});
    }
  }

  void pushWithReloadByReturnName(BuildContext context) async {
    final result = await Navigator.push(
      context,
      new MaterialPageRoute<bool>(
        builder: (BuildContext context) => Name(),
      ),
    );

    if (result) {
      setState(() {});
    }
  }
}

class Character extends StatefulWidget {
  @override
  CharacterState createState() => CharacterState();
}
