import 'package:flutter/material.dart';
import 'package:todo_app/features/domain/entity/todo.dart';
import 'package:todo_app/features/presentation/screens/add_event_screen.dart';
import 'package:todo_app/features/presentation/screens/edit_event_screen.dart';
import 'package:todo_app/features/presentation/screens/home_screen.dart';
import 'package:todo_app/features/presentation/screens/details_event_screen.dart';

sealed class AppRoute {
  static String get initialRoute => HomeScreen.id;
  static Map<String, Widget Function(BuildContext)> routes = {
    HomeScreen.id: (context) => const HomeScreen(),
  };

  // Push Page
  static void pushHome(BuildContext context) {
    Navigator.pushNamed(context, HomeScreen.id);
  }

  static Future<T?> pushAddEvent<T extends Object?>(
      BuildContext context, DateTime time) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddEventScreen(selectedDate: time),
        ));
  }

  static Future<T?> pushEditEvent<T extends Object?>(
      BuildContext context,
      TodoModel todoModel,
      ) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditEventScreen(
          todoModel: todoModel,
        ),
      ),
    );
  }

  static Future<T?> pushDetailsEvent<T extends Object?>(
    BuildContext context,
    TodoModel todoModel,
  ) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsEventScreen(
          todoModel: todoModel,
        ),
      ),
    );
  }

  // Replacement Page
  static void repHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomeScreen.id);
  }



  // Remove Until To Home
  static void removeToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      HomeScreen.id,
      (route) => false,
    );
  }
}
