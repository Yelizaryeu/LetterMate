import 'package:flutter/material.dart';

class AppTextFieldWidget extends StatelessWidget {
  final String? hint;
  final Function(String text)? onChange;
  final TextEditingController? controller;

  const AppTextFieldWidget({
    Key? key,
    this.hint,
    this.onChange,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
      ),
    );
  }
}
