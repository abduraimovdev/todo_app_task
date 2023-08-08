import 'package:todo_app/features/domain/entity/todo.dart';

class EventTodo {
  List<TodoModel> allTodos;
  List<TodoModel> todos;
  DateTime current;

  EventTodo({
    required this.allTodos,
    required this.todos,
    required this.current,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventTodo &&
          runtimeType == other.runtimeType &&
          todos == other.todos &&
          current == other.current;

  @override
  int get hashCode => todos.hashCode ^ current.hashCode;

  @override
  String toString() {
    return 'EventTodo{todos: $todos, current: $current}';
  }
}
