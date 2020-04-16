import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {this.colour, this.title, this.onPressed, this.size, this.normal});

  final Color colour;
  final String title;
  final Function onPressed;
  final double size;
  final bool normal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical:5),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: normal ? BorderRadius.circular(10.0) : BorderRadius.only(bottomRight: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 50.0,
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: size, fontWeight: FontWeight.bold, fontFamily: 'NunitoSans'),
          ),
        ),
      ),
    );
  }
}


