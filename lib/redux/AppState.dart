import 'package:mytodo/models/Todo.dart';

class AppState {
  List<Todo> todo;

  AppState({
    required this.todo
  });

  AppState.initialState() : todo = List.unmodifiable(<Todo>[]);
}