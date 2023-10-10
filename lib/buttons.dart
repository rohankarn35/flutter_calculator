import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String buttonText;
  final  onTap;
  const MyButtons(
      {super.key, required this.color, required this.textColor, required this.buttonText, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                
                color: color,
                boxShadow: [
                 BoxShadow(
        color: Colors.grey, // Color of the shadow
        spreadRadius: 10, // Spread radius of the shadow
        blurRadius: 9, // Blur radius of the shadow
        // offset: Offset(0, 3), // Offset of the shadow (x, y)
      ),
              ]),
              // color: color,
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(color: textColor),
                ),
              ),
            )),
      ),
    );
  }
}
