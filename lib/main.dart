import 'package:flutter/material.dart';
import 'package:todo_app/app.dart';
import 'package:todo_app/features/common/services/service_locator.dart';
import 'package:todo_app/features/data/local_data_source/local_data_source.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await LocalDataSourceImpl.init();
  runApp(const TodoApp());
}
