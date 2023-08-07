import 'package:flutter/material.dart';
import 'package:todo_app/features/core/constants/common.dart';


class InputHintText extends StatelessWidget {
  const InputHintText({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.gray900,
        letterSpacing: 0.25,
      ),
    );
  }
}