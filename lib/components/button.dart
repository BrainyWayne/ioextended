import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? color;
  const CustomButton({Key? key, required this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
        decoration: BoxDecoration(
            color: color ?? Colors.green,
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }
}
