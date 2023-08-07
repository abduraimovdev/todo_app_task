
import 'package:get_it/get_it.dart';
import 'package:todo_app/features/bloc/todo_bloc.dart';
import 'package:todo_app/features/data/local_data_source/local_data_source.dart';
import 'package:todo_app/features/data/repository/todo_repository_impl.dart';
import 'package:todo_app/features/domain/repository/todo_repository.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<LocalDataSource>(const LocalDataSourceImpl());
  locator.registerSingleton<TodoRepository>(TodoRepositoryImpl(dataSource: locator()));
  locator.registerSingleton<TodoBloc>(TodoBloc(repository: locator()));
}