import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/bloc/event_todo.dart';
import 'package:todo_app/features/bloc/todo_event.dart';
import 'package:todo_app/features/bloc/todo_state.dart';
import 'package:todo_app/features/domain/entity/todo.dart';
import 'package:todo_app/features/domain/repository/todo_repository.dart';

/// Bloc
class TodoBloc extends Bloc<HomeEvent, HomeState> {
  final TodoRepository repository;

  TodoBloc({required this.repository})
      : super(
          LoadingState(
            todoModel: EventTodo(
              todos: [],
              current: DateTime.now(),
              allTodos: [],
            ),
          ),
        ) {
    on<HomeEvent>(
      (event, emit) => switch (event) {
        LoadingEvent e => _loading(e, emit),
        LoadedEvent _ => () {},
        ErrorEvent _ => () {},
        CreateTodoEvent e => _create(e, emit),
        DeleteTodoEvent e => _delete(e, emit),
        UpdateTodoEvent e => _update(e, emit),
        ChangeDateEvent e => _changeDate(e, emit),
      },
    );
  }

  void _loading(LoadingEvent event, Emitter<HomeState> emit) async {
    emit(LoadingState(todoModel: state.todoModel));

    try {
      List<TodoModel> response = await repository.getAllData();
      List<TodoModel> filteredData = await repository.getFilteredData(
        state.todoModel.current,
      );
      emit(LoadedState(
        todoModel: EventTodo(
          todos: filteredData,
          current: state.todoModel.current,
          allTodos: response,
        ),
      ));
    } catch (e) {
      emit(ErrorState(message: "$e", todoModel: state.todoModel));
    }
  }

  void _create(CreateTodoEvent event, Emitter<HomeState> emit) async {
    try {
      await repository.createData(event.todoModel);
    } catch (e) {
      emit(ErrorState(message: "$e", todoModel: state.todoModel));
    }
  }

  void _delete(DeleteTodoEvent event, Emitter<HomeState> emit) async {
    try {
      await repository.deleteData(event.id);
    } catch (e) {
      emit(ErrorState(message: "$e", todoModel: state.todoModel));
    }
  }

  void _update(UpdateTodoEvent event, Emitter<HomeState> emit) async {
    try {
      await repository.updateData(event.todoModel.id, event.todoModel);
    } catch (e) {
      emit(ErrorState(message: "$e", todoModel: state.todoModel));
    }
  }

  void _changeDate(ChangeDateEvent event, Emitter<HomeState> emit) async {
    final List<TodoModel> filteredData = await repository.getFilteredData(
      event.selectedDate,
    );

    emit(LoadedState(
      todoModel: EventTodo(
        todos: filteredData,
        current: event.selectedDate,
        allTodos: state.todoModel.allTodos,
      ),
    ));
  }
}
