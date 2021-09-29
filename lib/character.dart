import 'package:flutter/material.dart';
import 'main.dart';
import 'color.dart';
import 'food.dart';

class CharacterState extends State<Character> {
  bool _comment = true;
  int lv = 0;

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
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'なまえLv ',
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
                  padding: const EdgeInsets.only(top: 20),
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
}

class Character extends StatefulWidget {
  @override
  CharacterState createState() => CharacterState();
}
