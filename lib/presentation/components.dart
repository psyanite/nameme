import 'package:crystal/presentation/theme.dart';
import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final Color color;
  final Color fontColor;
  final String text;
  final Function onPressed;

  BigButton({Key key, this.color, this.fontColor, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: FlatButton(
        color: color,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(text, style: TextStyle(fontSize: Burnt.buttonFontSize, color: fontColor))),
          ],
        ),
        onPressed: onPressed),
    );
  }
}
