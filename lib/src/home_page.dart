import 'package:MyTodo/src/bloc/todo_cubit.dart';
import 'package:MyTodo/src/result_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();

  TodoCubit get _todoCubit => context.read<TodoCubit>();

  void _onPressDone(String value) {
    _todoCubit.addTodo(value);
    controller.text = "";
  }

  void _onPressRemove(int id) {
    _todoCubit.removeTodo(id);
  }

  void _onChecked(int id) {
    _todoCubit.checkTodo(id);
  }

  void _onPressNext() {
    final route = MaterialPageRoute(builder: (_) => ResultPage());
    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      body: Center(
        child: BlocBuilder<TodoCubit, TodoState>(
          builder: (context, state) {
            return ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFF00FFFF),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Text(
                        state.checkedIds.length.toString(),
                        style: textStyle.copyWith(fontSize: 40),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 64,
                  ),
                  child: TextFormField(
                    controller: controller,
                    style: textStyle,
                    onFieldSubmitted: _onPressDone,
                  ),
                ),
                ...state.items.map((item) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: state.checkedIds.contains(item.id),
                        onChanged: (_) {
                          _onChecked(item.id);
                        },
                      ),
                      Text(
                        item.subject,
                        style: textStyle,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.pink,
                        ),
                        onPressed: () {
                          _onPressRemove(item.id);
                        },
                      ),
                    ],
                  );
                }),
                SizedBox(height: 16),
                Center(
                  child: FlatButton(
                    color: Colors.lightGreen,
                    onPressed: _onPressNext,
                    child: Text(
                      "Next",
                      style: textStyle,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class Todo {
  final int id;
  final String subject;

  Todo({
    this.id,
    this.subject,
  });
}
