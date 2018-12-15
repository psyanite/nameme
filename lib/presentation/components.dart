import 'dart:async';

import 'package:crystal/presentation/theme.dart';
import 'package:flutter/material.dart';

class BigButton extends StatefulWidget {
  final Color color;
  final Color fontColor;
  final String text;
  final Function onPressed;
  final Color borderColor;
  final bool isGradient;
  final double padding;
  final bool isSpinnable;

  BigButton(
      {Key key,
      this.color,
      this.fontColor,
      this.text,
      this.onPressed,
      this.borderColor,
      this.isGradient = false,
      this.padding,
      this.isSpinnable = false});

  @override
  _BigButtonState createState() => new _BigButtonState();
}

class _BigButtonState extends State<BigButton> {
  Widget _content;

  @override
  void initState() {
    super.initState();
    _content = _text();
  }

  @override
  Widget build(BuildContext context) {
    var decoration;
    if (widget.isGradient) {
      decoration = BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0, 1.0],
        colors: [Burnt.gradientYellow, Burnt.gradientPink],
      ));
    }
    if (widget.borderColor != null) {
      decoration = BoxDecoration(border: new Border.all(color: widget.borderColor));
    }

    return Container(
      padding: EdgeInsets.all(widget.padding ?? 10.0),
      child: FlatButton(
        child: Container(
          height: this.widget.borderColor != null ? 40.0 : 42.0,
          color: widget.color,
          decoration: decoration,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_content],
          ),
        ),
        onPressed: _onPressed,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
    );
  }

  Widget _text() {
    return Text(widget.text, style: TextStyle(fontSize: 20.0, color: widget.fontColor, fontWeight: Burnt.fontBold));
  }

  Widget _spinner() {
    return new SizedBox(width: 16.0, height: 16.0, child: CircularProgressIndicator(strokeWidth: 2.0, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));
  }

  void _onPressed() {
    widget.onPressed();
    if (widget.isSpinnable) {
      setState(() => _content = _spinner());
      Timer(Duration(seconds: 3), () => setState(() => _content = _text()));
    }
  }
}
