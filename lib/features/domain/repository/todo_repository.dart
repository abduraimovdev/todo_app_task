import 'package:todo_app/features/domain/entity/todo.dart';

abstract interface class TodoRepository {

  const TodoRepository();

  Future<List<TodoModel>> getAllData();
  Future<List<TodoModel>> getFilteredData(DateTime time);
  Future<TodoModel?> getData(int id);
  Future<bool> createData(TodoModel todoModel);
  Future<bool> updateData(int id, TodoModel todoModel);
  Future<bool> deleteData(int id);

}