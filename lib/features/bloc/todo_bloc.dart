import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/bloc/todo_event.dart';
import 'package:todo_app/features/bloc/todo_state.dart';
import 'package:todo_app/features/domain/entity/todo.dart';
import 'package:todo_app/features/domain/repository/todo_repository.dart';

/// Bloc
class TodoBloc extends Bloc<HomeEvent, HomeState> {
  final TodoRepository repository;

  TodoBloc({required this.repository})
      : super(const LoadingState(todoModel: [])) {
    on<HomeEvent>(
      (event, emit) => switch (event) {
        LoadingEvent e => _loading(e, emit),
        LoadedEvent _ => () {},
        ErrorEvent _ => () {},
        CreateTodoEvent e => _create(e, emit),
        DeleteTodoEvent e => _delete(e, emit),
        UpdateTodoEvent e => _update(e, emit),
      },
    );
  }

  void _loading(LoadingEvent event, Emitter<HomeState> emit) async {
    print("Started ... ");

    emit(LoadingState(todoModel: state.todoModel));

    try {
      List<TodoModel> response = await repository.getAllData();
      print(response);

      emit(LoadedState(todoModel: response));
    } catch (e) {
      emit(ErrorState(message: "$e"));
    }
  }

  void _create(CreateTodoEvent event, Emitter<HomeState> emit) async {
    try {
      await repository.createData(event.todoModel);
    } catch (e) {
      emit(ErrorState(message: "$e"));
    }
  }

  void _delete(DeleteTodoEvent event, Emitter<HomeState> emit) async {
    try {
      await repository.deleteData(event.id);
    } catch (e) {
      emit(ErrorState(message: "$e"));
    }
  }

  void _update(UpdateTodoEvent event, Emitter<HomeState> emit) async {
    try {
      await repository.updateData(event.todoModel.id, event.todoModel);
    } catch (e) {
      emit(ErrorState(message: "$e"));
    }
  }
}
