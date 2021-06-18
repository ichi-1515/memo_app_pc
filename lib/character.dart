import 'package:flutter/material.dart';

class Character extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Character'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'images/cat_b.GIF',
                height: 250,
                width: 250,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
