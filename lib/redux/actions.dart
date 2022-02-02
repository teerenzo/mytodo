import 'package:mytodo/models/Todo.dart';

class updateTodoAction{
  final Todo updateTodo;
  updateTodoAction(this.updateTodo);
}

class AddItemAction{
  final Todo todo;
  AddItemAction(this.todo);

  get id => todo.id;
}

class RemoveItem{
  final id;
  RemoveItem(this.id);
}

