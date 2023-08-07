import 'package:flutter/material.dart';
import 'package:todo_app/features/core/constants/common.dart';


class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget{
  final DateTime time;
  const HomeScreenAppBar({
    super.key, required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      title: Column(
        children: [
          Text(
            "${time.weekday}",
            style: Styles.poppins600.copyWith(
              color: AppColors.c292929,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${time.day} ${time.month} ${time.year}",
                style: Styles.poppins400.copyWith(
                  color: AppColors.c292929,
                  fontSize: 10,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                color: AppColors.c000000,
                size: 15,
              ),
            ],
          ),
        ],
      ),
      actions: [
        SvgIcons.notification,
        AppSized.sized(context, width: 0.1)
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 70);
}