import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? disabled;
  final double? width;

  const AppTextField({
    required this.controller,
    required this.hintText,
    super.key,
    this.width,
    this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.elementColor,
        borderRadius: BorderRadius.circular(4),
      ),
      height: 40,
      width: width,
      child: TextField(
        enabled: disabled != null ? !disabled! : null,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        controller: controller,
      ),
    );
  }
}
