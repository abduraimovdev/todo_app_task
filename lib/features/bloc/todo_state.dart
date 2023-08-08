import 'package:todo_app/features/bloc/event_todo.dart';

/// State
sealed class HomeState {
  final EventTodo todoModel;
  const HomeState({required this.todoModel});
}

class LoadingState extends HomeState {
  const LoadingState({required super.todoModel});
}

class LoadedState extends HomeState {

  const LoadedState({required super.todoModel});
}

class ErrorState extends HomeState {
  final String message;

  const ErrorState({required super.todoModel,required this.message});
}