import 'package:flutter/material.dart';

class SimpleTypingIndicatorWidget extends StatelessWidget {
  const SimpleTypingIndicatorWidget({
    super.key,
    required this.user,
    this.color,
    this.padding = const EdgeInsets.only(bottom: 90.0),
    this.alignment = Alignment.bottomCenter,
    this.size = 50.0,
  });

  final String user;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final Alignment alignment;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      alignment: alignment,
      child: Text("${user} writing..."),
    );
  }


}