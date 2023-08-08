import 'package:todo_app/features/domain/entity/todo.dart';

/// Event
sealed class HomeEvent {
  const HomeEvent();
}

class LoadingEvent extends HomeEvent {
  const LoadingEvent();
}

class LoadedEvent extends HomeEvent {
  const LoadedEvent();
}

class ErrorEvent extends HomeEvent {
  const ErrorEvent();
}

class ChangeDateEvent extends HomeEvent {
  final DateTime selectedDate;
  const ChangeDateEvent(this.selectedDate);
}

class CreateTodoEvent extends HomeEvent {
  final TodoModel todoModel;

  const CreateTodoEvent({
    required this.todoModel,
  });
}

class DeleteTodoEvent extends HomeEvent {
  final int id;

  const DeleteTodoEvent({required this.id});
}

class UpdateTodoEvent extends HomeEvent {
  final TodoModel todoModel;

  const UpdateTodoEvent({
    required this.todoModel,
  });
}
