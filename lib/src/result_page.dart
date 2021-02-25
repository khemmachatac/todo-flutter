import 'package:MyTodo/src/bloc/todo_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xFF00FFFF),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              context.select((TodoCubit value) =>
                  value.state.checkedIds.length.toString()),
              style: textStyle.copyWith(fontSize: 40),
            ),
          ),
        ),
      ),
    );
  }
}
