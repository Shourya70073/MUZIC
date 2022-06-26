import 'package:flutter/material.dart';

class Cardd extends StatelessWidget {
  var height;
  var width;
  var child;
  var padding;

  // ignore: prefer_equal_for_default_values
  Cardd({@required height: 50.0, @required width: 50.0, child: null, padd: 8.0}) {
    this.height = height;
    this.width = width;
    this.child = child;
    this.padding = padd;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      padding: EdgeInsets.all(padding),
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                blurRadius: 15.0,
                spreadRadius: 1.0,
                offset: Offset(4.0, 4.0),
                color: Colors.grey.shade500),
            BoxShadow(
                blurRadius: 15.0,
                spreadRadius: 1.0,
                offset: Offset(-4.0, -4.0),
                color: Colors.white)
          ]),
    );
  }
}
