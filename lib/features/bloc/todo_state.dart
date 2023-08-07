import 'package:todo_app/features/domain/entity/todo.dart';

/// State
sealed class HomeState {
  final List<TodoModel>? todoModel;
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

  const ErrorState({super.todoModel,required this.message});
}