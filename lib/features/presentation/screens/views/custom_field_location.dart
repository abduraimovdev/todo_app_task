import 'package:flutter/material.dart';
import 'package:todo_app/features/common/services/location_service.dart';
import 'package:todo_app/features/core/constants/common.dart';

class CustomFieldLocation extends StatelessWidget {
  const CustomFieldLocation({
    super.key,
    required this.controller,
    this.onPressed,
  });

  final void Function()? onPressed;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (text) {
        if(text == null) return "This is Location Empty";
        if(text.isEmpty && text.length < 3) {
          return "This is Location Empty";
        }else {
          return null;
        }
      },
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.cF3F4F6,
        constraints: const BoxConstraints(maxHeight:  60),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixIcon: GestureDetector(
          onTap: () async{
            final currentLocation = await GeoLocationService().currentLocation();
            if(currentLocation != null) {
              controller.text = currentLocation;
            }
            if(onPressed != null) {
              onPressed!();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: SvgIcons.fluentLocationFilled.copyWith(
              color: AppColors.c009FEE,
            ),
          ),
        ),
      ),
    );
  }
}
