import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String text1;
  final String text2;
  final double fontSize;

  const CustomRichText({
    Key? key,
    required this.text1,
    required this.text2,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text1,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.grey,
        ),
        children: [
          TextSpan(
            text: text2,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
