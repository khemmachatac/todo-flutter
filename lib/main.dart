import 'package:MyTodo/src/bloc/todo_cubit.dart';
import 'package:MyTodo/src/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoCubit(
        TodoState(
          items: [
            Todo(
              id: 1,
              subject: "TODO1",
            ),
            Todo(
              id: 2,
              subject: "TODO2",
            )
          ],
        ),
      ),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
