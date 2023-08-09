import 'package:flutter/material.dart';
import 'package:todo_app/features/bloc/todo_bloc.dart';
import 'package:todo_app/features/bloc/todo_event.dart';
import 'package:todo_app/features/common/services/service_locator.dart';
import 'package:todo_app/features/core/constants/common.dart';
import 'package:todo_app/features/domain/entity/todo.dart';
import 'package:todo_app/features/presentation/screens/views/custom_button.dart';
import 'package:todo_app/features/presentation/screens/views/custom_drop_button.dart';
import 'package:todo_app/features/presentation/screens/views/custom_field_location.dart';
import 'package:todo_app/features/presentation/screens/views/custom_field_time.dart';
import 'package:todo_app/features/presentation/screens/views/custom_text_field.dart';
import 'package:todo_app/features/presentation/screens/views/input_hint_text.dart';

class AddEventScreen extends StatefulWidget {
  static const String id = "add_event";

  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final TextEditingController eventNameController = TextEditingController();

  final TextEditingController eventTitleController = TextEditingController();


  final TextEditingController eventLocationController = TextEditingController();

  int priorityColorController = 0;

  final TextEditingController timeController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormFieldState>();

  void addEvent() {
      final currentDate = locator.get<TodoBloc>().state.todoModel.current;
      final TodoModel model = TodoModel(
        id: 01,
        eventName: eventNameController.text.trim(),
        eventDescription: descriptionController.text.trim(),
        eventLocation: eventLocationController.text.trim(),
        priorityColor: priorityColorController,
        time: EventTime(
            currentDate.add(const Duration(hours: 10, minutes: 15)),
            currentDate.add(const Duration(hours: 11, minutes: 50))),
        remainder: 15,
        eventTitle: eventTitleController.text.trim(),
      );

      locator.get<TodoBloc>().add(CreateTodoEvent(todoModel: model));
      Navigator.pop(context, ["done"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.grey500,
            size: 35,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.88,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 13,
                  right: 13,
                  top: 10,
                  bottom: MediaQuery.sizeOf(context).height * 0.01,
                ),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // -- Name
                      const InputHintText(
                        label: "Event name",
                      ),
                      AppSized.sized(context, height: 0.005),
                      CustomTextField(
                        controller: eventNameController,
                      ),

                      AppSized.sized(context, height: 0.02),

                      // -- Subtitle
                      const InputHintText(
                        label: "Event title",
                      ),
                      AppSized.sized(context, height: 0.005),
                      CustomTextField(
                        controller: eventTitleController,
                      ),

                      AppSized.sized(context, height: 0.02),

                      // -- Description
                      const InputHintText(
                        label: "Event description",
                      ),
                      AppSized.sized(context, height: 0.005),
                      CustomTextField(
                        line: 4,
                        controller: descriptionController,
                      ),

                      AppSized.sized(context, height: 0.02),

                      // -- Location
                      const InputHintText(
                        label: "Event location",
                      ),
                      AppSized.sized(context, height: 0.005),
                      CustomFieldLocation(
                        controller: eventLocationController,
                      ),

                      AppSized.sized(context, height: 0.02),

                      // -- Color
                      const InputHintText(
                        label: "Priority color",
                      ),
                      AppSized.sized(context, height: 0.01),

                      CustomDropButton(
                        colors: [for (int i = 0; i <= 17; i++) i],
                        onChange: (color) {
                          priorityColorController = color;
                        },
                      ),

                      AppSized.sized(context, height: 0.02),

                      // -- Time
                      const InputHintText(
                        label: "Event time",
                      ),
                      AppSized.sized(context, height: 0.01),
                      CustomFieldDateTime(
                        controller: timeController,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                width: MediaQuery.sizeOf(context).width * 0.95,
                height: MediaQuery.sizeOf(context).height * 0.06,
                onPressed: addEvent,
                child: Text(
                  "Add",
                  style: Styles.poppins400.copyWith(
                    fontSize: 16,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
