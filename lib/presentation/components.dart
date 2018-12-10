import 'package:crystal/presentation/theme.dart';
import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final Color color;
  final Color fontColor;
  final String text;
  final Function onPressed;
  final Color borderColor;
  final bool isGradient;
  final double padding;

  BigButton({Key key, this.color, this.fontColor, this.text, this.onPressed, this.borderColor, this.isGradient = false, this.padding});

  @override
  Widget build(BuildContext context) {

    var decoration;
    if (isGradient) {
      decoration = BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 1.0],
          colors: [Burnt.gradientYellow, Burnt.gradientPink],
        ));
    }
    if (borderColor != null) {
      decoration = BoxDecoration(
        border: new Border.all(color: borderColor)
      );
    }

    return Container(
      padding: EdgeInsets.all(padding ?? 10.0),
      child: FlatButton(
              child: Container(
                  color: color,
                  decoration: decoration,
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(text, style: TextStyle(fontSize: Burnt.buttonFontSize, color: fontColor)),
                    ],
                  ),
          ),
          onPressed: onPressed),
    );
  }
}
