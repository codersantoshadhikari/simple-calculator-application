import 'package:flutter/material.dart';

// creating Stateless Widget for buttons

class MyButton extends StatelessWidget {
  // declaring variables

  // ignore: prefer_typing_uninitialized_variables
  final color;

  // ignore: prefer_typing_uninitialized_variables
  final textColor;

  final String buttonText;

  // ignore: prefer_typing_uninitialized_variables
  final buttontapped;

  //Constructor

  const MyButton(
      {super.key,
      this.color,
      this.textColor,
      required this.buttonText,
      this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(0.2),
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(25),

          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
