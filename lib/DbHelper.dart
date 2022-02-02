import 'package:mytodo/models/Todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
class TodoDatabase{
  TodoDatabase._init();
  static final TodoDatabase instance = TodoDatabase._init();

  static Database? _database;

  Future<Database?> get database async{
    if(_database != null){
      return _database;
    }
    _database = await _initDb("Todo");
    return _database;
  }
  Future<Database>  _initDb(String dbName) async{
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, dbName);

    return await openDatabase(path,version: 1,onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    // Database is created, create the table
    await db.execute(
        "CREATE TABLE $table (${todoFields.id} INTEGER PRIMARY KEY, ${todoFields.title} TEXT, ${todoFields.decription} TEXT, ${todoFields.Priority} TEXT,createAt TEXT DEFAULT CURRENT_TIMESTAMP, updateAt TEXT DEFAULT NULL, status TEXT)");

  }
Future<Set<Todo>> insert(Todo newTodo1) async{
  final db = await instance.database;
  final id = await db?.rawQuery("INSERT INTO $table(title,description,priority,updateAt,status) VALUES('${newTodo1.title}','${newTodo1.decription}','${newTodo1.Priority}','no','no')");
 return newTodo1.copy(
   id: 1
 );
}

Future<List<Todo>?> readAll() async{
  final db = await instance.database;
  final result =await db?.query(table,orderBy: "createAt desc" );
  return result?.map((json) => Todo.fromjson(json)).toList();
}
  Future<List<Todo>?> readOne(String priority) async{
    final db = await instance.database;
    final result =await db?.query(table,where: "${todoFields.Priority}='$priority'" );
    return result?.map((json) => Todo.fromjson(json)).toList();
  }
  Future<int?> delete(String id) async{
    final db = await instance.database;
    final result =await db?.delete(table,where: "_id='$id'" );
    return result;
  }
  Future<int?> update(Todo todo) async{
    final db = await instance.database;
    final result =await db?.rawUpdate("UPDATE $table SET title='${todo.title}',description='${todo.decription}',priority='${todo.Priority}',updateAt='${todo.updateAt}' WHERE _id='${todo.id}'");
    return result;
  }
  Future<int?> updateStatus(String id) async{
    final db = await instance.database;
    final result =await db?.rawUpdate("UPDATE $table SET status='done' WHERE _id='$id'");
    return result;
  }
  Future<String> countAll() async{
    final db = await instance.database;
    final result =await db?.rawQuery("SELECT count(_id) FROM $table");
    String res='';
   result?.map((e) => res=e.toString());
    return res;
  }
  Future close() async {
    final db = await instance.database;
    db?.close();
  }
}


