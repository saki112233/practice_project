import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent(
      {Key? key, required this.image, required this.title, required this.text})
      : super(key: key);
  final String image, title, text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Image.asset(
          image,
          height: 300,
          width: 300,
        ),
        Text(text),
        Text(title),
        Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
