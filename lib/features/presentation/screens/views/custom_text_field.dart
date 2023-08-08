import 'package:flutter/material.dart';
import 'package:todo_app/features/core/constants/common.dart';


class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.width = 0.0,
    this.height = 0.0,
    this.line = 1,
  });

  final double width;
  final double height;
  final TextEditingController controller;
  final int line;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if(value == null) return null;
        if(value.isEmpty) {
          return "Please fill in the blank line";
        }else {
          return null;
        }
      },
      controller: controller,
      maxLines: line,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.cF3F4F6,
        constraints: BoxConstraints(minWidth: width, minHeight: height, maxHeight: line > 2 ? double.infinity :  60),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
