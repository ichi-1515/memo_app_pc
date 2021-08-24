import 'package:flutter/material.dart';
import 'main.dart';

class FoodState extends State<Food> {
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
                      "10",
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
                  onPressed: () {},
                  color: Colors.redAccent,
                  child: Text(
                    'キャンセル',
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
}

class Food extends StatefulWidget {
  @override
  FoodState createState() => FoodState();
}
