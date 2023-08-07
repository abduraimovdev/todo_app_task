import 'package:flutter/material.dart';
import 'package:todo_app/features/bloc/todo_bloc.dart';
import 'package:todo_app/features/bloc/todo_event.dart';
import 'package:todo_app/features/common/services/service_locator.dart';
import 'package:todo_app/features/core/constants/app_route.dart';
import 'package:todo_app/features/domain/entity/todo.dart';
import 'package:todo_app/features/presentation/screens/views/custom_button.dart';
import 'package:todo_app/features/presentation/screens/views/view_todo_body.dart';
import 'package:todo_app/features/presentation/screens/views/view_todo_header.dart';
import 'package:todo_app/features/core/constants/common.dart';


class DetailsEventScreen extends StatelessWidget {
  final TodoModel todoModel;
  static const String id = "details_event";

  const DetailsEventScreen({super.key, required this.todoModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            backPress: () => backButton(context),
            editPress: () => editButton(context),
            name: todoModel.eventName,
            title: todoModel.eventTitle,
            time: "17:00 - 18:30",
            location: todoModel.eventLocation,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.sizeOf(context).height * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ViewTodoBody(
                    reminder: "${todoModel.remainder} minutes befor",
                    description: todoModel.eventDescription,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                      onPressed: () =>  deleteButton(context),
                      width: MediaQuery.sizeOf(context).width * 0.85,
                      height: MediaQuery.sizeOf(context).height * 0.06,
                      backgroundColor: AppColors.cFEE8E9,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgIcons.fluentDeleteFilled,
                          Text(
                            "Delete Event",
                            style: Styles.poppins600.copyWith(
                              fontSize: 16,
                              color: AppColors.c292929,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void backButton(BuildContext context) {
    Navigator.pop(context);
  }
  void editButton(BuildContext context) {
    AppRoute.pushEditEvent(context, todoModel);
  }
  void deleteButton(BuildContext context) {
    locator.get<TodoBloc>().add(DeleteTodoEvent(id: todoModel.id));
    Navigator.pop(context);
  }


}
