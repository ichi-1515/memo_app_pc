import 'package:flutter/material.dart';

class ColorState extends State<Color> {
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
                            'images/cat_1.GIF',
                            height: 250,
                            width: 250,
                          ),
                        ),
                        onTap: (){
                          // 色変更
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
                            'images/cat_2.GIF',
                            height: 250,
                            width: 250,
                          ),
                        ),
                        onTap: (){
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
                      // キャラ3
                      GestureDetector(
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
                        onTap: (){
                          // 色変更
                        },
                      ),
                      // キャラ4
                      GestureDetector(
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
                        onTap: (){
                          // 色変更
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Color extends StatefulWidget {
  @override
  ColorState createState() => ColorState();
}
