import 'package:flutter/material.dart';
import 'main.dart';

class NameState extends State<Name> {
  MemoListState memoListState = MemoListState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NameChange'),
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context, true),
        ),
      ),
      //中身
      body: Center(
        child: Container(
          width: 360,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                TextField(
                  enabled: true,
                  // 入力数
                  maxLength: 10,
                  maxLengthEnforced: false,
                  style: TextStyle(color: Colors.black),
                  obscureText: false,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.pets),
                    hintText: 'ペットのなまえ',
                    labelText: 'なまえ *',
                  ),
                  onChanged: (value) {
                    memoListState.setName();
                    petName = value;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Name extends StatefulWidget {
  @override
  NameState createState() => NameState();
}
