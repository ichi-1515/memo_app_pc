import 'package:flutter/material.dart';

class CharacterState extends State<Character> {
  bool _comment = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Character'),
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
                          onPressed: () {},
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
                          onPressed: () {},
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
                        'なまえ Lv',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '20',
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
                      'images/cat_b.GIF',
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
}

class Character extends StatefulWidget {
  @override
  CharacterState createState() => CharacterState();
}
