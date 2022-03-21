import 'package:flutter/material.dart';

class CustomManagerContainer extends StatelessWidget {
  final Widget child;
  CustomManagerContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(7),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.amber,
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 4,
              offset: Offset(2, 6), // Shadow position
            ),
          ],
        ),
        child: child);
  }
}