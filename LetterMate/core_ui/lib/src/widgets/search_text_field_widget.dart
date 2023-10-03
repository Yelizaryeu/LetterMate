import 'package:flutter/material.dart';

class AppSearchTextFieldWidget extends StatelessWidget {
  final String? hint;
  final Function(String text) onSearch;
  final TextEditingController controller;

  const AppSearchTextFieldWidget({
    Key? key,
    this.hint,
    required this.onSearch,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: key,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: () => onSearch(controller.text),
          child: const Icon(Icons.search),
        ),
        border: const OutlineInputBorder(),
        hintText: hint,
      ),
    );
  }
}
