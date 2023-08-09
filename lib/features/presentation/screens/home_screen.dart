
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/bloc/todo_bloc.dart';
import 'package:todo_app/features/bloc/todo_event.dart';
import 'package:todo_app/features/bloc/todo_state.dart';
import 'package:todo_app/features/common/services/service_locator.dart';
import 'package:todo_app/features/core/constants/app_route.dart';
import 'package:todo_app/features/core/constants/common.dart';
import 'package:todo_app/features/presentation/screens/views/calendar/calendar_widget.dart';
import 'package:todo_app/features/presentation/screens/views/calendar_bottom.dart';
import 'package:todo_app/features/presentation/screens/views/home_screen_app_bar.dart';
import 'package:todo_app/features/presentation/screens/views/todo_tile.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeScreenAppBar(),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: BlocBuilder<TodoBloc, HomeState>(
              builder: (context, state) {
                return Calendar(
                  todos: state.todoModel.allTodos,
                );
              },
            ),
          ),
          CalendarBottom(
            addEvent: () async{
              await AppRoute.pushAddEvent(context);
              locator.get<TodoBloc>().add(const LoadingEvent());
            },
          ),
          AppSized.sized(context, height: 0.02),
          Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: BlocConsumer<TodoBloc, HomeState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return ListView.separated(
                      primary: false,
                      itemBuilder: (context, index) {
                        final todo = state.todoModel.todos[index];
                        final Color color = Colors.primaries[todo.priorityColor];
                        return GestureDetector(
                          onTap: () async{
                            await AppRoute.pushDetailsEvent(context, todo);
                            locator.get<TodoBloc>().add(const LoadingEvent());
                          },
                          child: TodoTile(
                            eventName: todo.eventName,
                            eventTitle: todo.eventTitle,
                            color: color.withOpacity(0.8),
                            eventTime: "17:00 - 18:30",
                            eventLocation: "Stamford Bridge",
                            textColor: color,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                      itemCount: state.todoModel.todos.length,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
