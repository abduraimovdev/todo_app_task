import 'package:flutter/material.dart';
import 'package:todo_app/features/core/constants/common.dart';


class ViewTodoBody extends StatelessWidget {

  const ViewTodoBody({
    super.key, required this.reminder, required this.description,
  });

  final String reminder;
  final String description;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
        top: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -- Reminder
          Text(
            "Reminder",
            style: Styles.poppins600.copyWith(
              fontSize: 20,
              color: AppColors.c000000,
            ),
          ),

          AppSized.sized(context, height: 0.02),

          // Reminder
          Text(
            reminder,
            style: Styles.poppins500.copyWith(
              fontSize: 20,
              color: AppColors.c7C7B7B,
            ),
          ),

          AppSized.sized(context, height: 0.03),

          // -- Description
          Text(
            "Description",
            style: Styles.poppins600.copyWith(
              fontSize: 20,
              color: AppColors.c000000,
            ),
          ),

          AppSized.sized(context, height: 0.02),

          // Description
          SingleChildScrollView(
            child: Text(
              description,
              style: Styles.poppins500.copyWith(
                fontSize: 12,
                color: AppColors.c999,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
