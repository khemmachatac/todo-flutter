import 'package:MyTodo/src/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoState {
  List<Todo> items;
  List<int> checkedIds;

  TodoState({
    this.items = const [],
    this.checkedIds = const [],
  });

  TodoState copy() {
    return TodoState(
      items: items,
      checkedIds: checkedIds,
    );
  }
}

class TodoCubit extends Cubit<TodoState> {
  TodoCubit(TodoState state) : super(state);

  void addTodo(String value) {
    if (value.isEmpty) return;

    emit(
      state.copy()
        ..items = [
          ...state.items,
          Todo(
            id: DateTime.now().microsecondsSinceEpoch,
            subject: value,
          )
        ],
    );
  }

  void removeTodo(int id) {
    final newState = state.copy();
    newState.items = state.items.where((item) => item.id != id).toList();
    newState.checkedIds = state.checkedIds.where((item) => item != id).toList();

    emit(newState);
  }

  void checkTodo(int id) {
    if (state.checkedIds.contains(id)) {
      emit(state.copy()
        ..checkedIds =
            state.checkedIds.where((element) => element != id).toList());
    } else {
      emit(state.copy()
        ..checkedIds = [
          ...state.checkedIds,
          id,
        ]);
    }
  }
}
