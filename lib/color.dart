import 'package:flutter/material.dart';
import 'main.dart';

class ColorState extends State<Color> {

  MemoListState memoListState = MemoListState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color'),
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

        // 中身
        child: Center(
          child: Container(
            width: 360,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // キャラ1
                      GestureDetector(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            'images/cat_1a.PNG',
                            height: 250,
                            width: 250,
                          ),
                        ),
                        onTap: () {
                          // 色変更
                          colorChange1();
                        },
                      ),
                      // キャラ2
                      GestureDetector(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            'images/cat_2a.PNG',
                            height: 250,
                            width: 250,
                          ),
                        ),
                        onTap: () {
                          // 色変更
                          colorChange2();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // キャラ3
                      if (lv > 1) GestureDetector(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            'images/cat_3a.PNG',
                            height: 250,
                            width: 250,
                          ),
                        ),
                        onTap: () {
                          // 色変更
                          colorChange3();
                        },
                      ),
                      if (lv < 1) GestureDetector(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            'images/hatena.PNG',
                            height: 250,
                            width: 250,
                          ),
                        ),
                        onTap: () {
                          // 色変更
                        },
                      ),
                      // キャラ4
                      if (lv > 4) GestureDetector(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            'images/cat_4a.PNG',
                            height: 250,
                            width: 250,
                          ),
                        ),
                        onTap: () {
                          // 色変更
                          colorChange4();
                        },
                      ),
                      if (lv < 4) GestureDetector(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            'images/hatena.PNG',
                            height: 250,
                            width: 250,
                          ),
                        ),
                        onTap: () {
                          // 色変更
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // キャラ5
                      if (lv > 7) GestureDetector(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            'images/cat_5a.PNG',
                            height: 250,
                            width: 250,
                          ),
                        ),
                        onTap: () {
                          // 色変更
                          colorChange5();
                        },
                      ),
                      if (lv < 7) GestureDetector(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            'images/hatena.PNG',
                            height: 250,
                            width: 250,
                          ),
                        ),
                        onTap: () {
                          // 色変更
                        },
                      ),
                      // キャラ6
                      if (lv > 14) GestureDetector(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            'images/cat_6a.PNG',
                            height: 250,
                            width: 250,
                          ),
                        ),
                        onTap: () {
                          // 色変更
                          colorChange4();
                        },
                      ),
                      if (lv < 14) GestureDetector(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            'images/hatena.PNG',
                            height: 250,
                            width: 250,
                          ),
                        ),
                        onTap: () {
                          // 色変更
                        },
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    characterChange();
                  },
                  color: Colors.grey,
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                // キャラ
                GestureDetector(
                  child: Image.asset(
                    'images/cat_$colorSub.GIF',
                    height: 100,
                    width: 100,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int colorSub = color;

  void colorChange1() {
    setState(() {
      colorSub = 1;
    });
  }

  void colorChange2() {
    setState(() {
      colorSub = 2;
    });
  }

  void colorChange3() {
    setState(() {
      colorSub = 3;
    });
  }

  void colorChange4() {
    setState(() {
      colorSub = 4;
    });
  }

  void colorChange5() {
    setState(() {
      colorSub = 5;
    });
  }

  void colorChange6() {
    setState(() {
      colorSub = 6;
    });
  }

  void characterChange() {
    color = colorSub;
    memoListState.setCharacter();
    Navigator.pop(context, true);
  }
}

class Color extends StatefulWidget {
  @override
  ColorState createState() => ColorState();
}
