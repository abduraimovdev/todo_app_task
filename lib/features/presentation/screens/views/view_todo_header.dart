import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/core/constants/common.dart';


class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.backPress,
    required this.editPress,
    required this.name,
    required this.title,
    required this.time,
    required this.location,
  });

  final void Function() backPress;
  final void Function() editPress;
  final String name;
  final String title;
  final String time;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.36,
      decoration: BoxDecoration(
        color: AppColors.c009FEE,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
          top: MediaQuery.sizeOf(context).height * 0.08,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    onPressed: backPress,
                    backgroundColor: AppColors.white,
                    elevation: 0,
                    child: Icon(
                      CupertinoIcons.back,
                      color: AppColors.c000000,
                    ),
                  ),
                  GestureDetector(
                    onTap: editPress,
                    child: Row(
                      children: [
                        SvgIcons.edit.copyWith(
                          width: 20,
                          height: 20,
                        ),
                        Text(
                          "Edit",
                          style: Styles.poppins500.copyWith(
                            color: AppColors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AppSized.sized(context, height: 0.03),
              Text(
                name,
                style: Styles.poppins600.copyWith(
                  color: AppColors.white,
                  fontSize: 30,
                ),
              ),
              AppSized.sized(context, height: 0.01),
              Text(
                title,
                style: Styles.poppins400.copyWith(
                  color: AppColors.white,
                  fontSize: 10,
                ),
              ),
              AppSized.sized(context, height: 0.03),
              Row(
                children: [
                  SvgIcons.roundAccessTimeFilled.copyWith(
                    color: AppColors.white,
                    width: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    time,
                    style: Styles.poppins500.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              AppSized.sized(context, height: 0.02),
              Row(
                children: [
                  SvgIcons.fluentLocationFilled.copyWith(
                    color: AppColors.white,
                    width: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    location,
                    style: Styles.poppins500.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
