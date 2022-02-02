
import 'package:mytodo/DbHelper.dart';
import 'package:mytodo/models/Todo.dart';
import 'package:mytodo/redux/AppState.dart';
import 'package:mytodo/redux/actions.dart';

AppState updateTodoReducer(AppState state, dynamic action){
  return AppState(todo: itemReducer(state.todo,action));
}

 itemReducer(List<Todo> todo, action) async {
  if(action is AddItemAction){
    await TodoDatabase.instance.insert(Todo(id: action.todo.id, title: action.todo.title, decription: action.todo.decription, Priority: action.todo.Priority, createdAt: action.todo.createdAt, updateAt: action.todo.updateAt, status: action.todo.status));
    todo = (await TodoDatabase.instance.readAll())!;
    return []..add(todo);
  }
  if(action is RemoveItem){
  await TodoDatabase.instance.delete(action.id);
  todo =(await TodoDatabase.instance.readAll())!;
    return []..add(todo);
  }

  return todo;

}

// AppState deleteTodo(AppState state, dynamic action){
//
// }