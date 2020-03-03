import 'package:flutter/material.dart';

class proFrancioText extends StatelessWidget {
  const proFrancioText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            "pro",
            style: TextStyle(fontSize: 40),
          ),
          Text(
            "Franco",
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold, fontSize: 40),
          ),
        ],
      ),
    );
  }
}