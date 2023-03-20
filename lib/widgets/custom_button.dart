import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final String text;
  const CustomButton(
      {super.key, this.color = const Color(0xffff5529), required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 15, left: 20.0, right: 30.0, top: 10.0),
      child: Container(
        height: 45.0,
        width: Get.width / 1.8,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(40.0)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontFamily: 'Roboto', color: Colors.white),
          ),
        ),
      ),
    );
  }
}
