import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {

  final buttonColor;
  final String buttonText;
  final textColor;
  final double textSize;
  final buttonPressed;

  const CalcButton({Key key, this.buttonColor, this.buttonText, this.textColor, this.textSize, this.buttonPressed}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ElevatedButton(
            onPressed: buttonPressed,
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                buttonColor
              ),
              elevation: MaterialStateProperty.all<double>(
                0.0,
              ),

            ),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: textSize,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
      ),
    );
  }
}