import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/bloc/todo_bloc.dart';
import 'package:todo_app/features/bloc/todo_event.dart';
import 'package:todo_app/features/common/services/service_locator.dart';
import 'package:todo_app/features/core/constants/app_route.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<TodoBloc>()..add(const LoadingEvent()),
      child: MaterialApp(
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.light,
        initialRoute: AppRoute.initialRoute,
        routes: AppRoute.routes,
      ),
    );
  }
}
