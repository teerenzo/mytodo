final String table = "todo";

class todoFields{
  static final String id="_id";
  static final String title="title";
  static final String decription="description";
  static final String Priority="priority";
  static final String createdAt="createAt";
  static final String updateAt="updateAt";
  static final String status="status";
}

class Todo {
  late final int id;
late final String title;
late final String decription;
late final String Priority;
late final String createdAt;
late final String updateAt;

  late final String status;

Todo({required this.id,required this.title,required this.decription,required this.Priority,required this.createdAt,required this.updateAt,required this.status});

static Todo fromjson(Map<String , Object?> json) => Todo(
  id: json[todoFields.id] as int,
    title: json[todoFields.title] as String,
    decription: json[todoFields.decription] as String,
    Priority: json[todoFields.Priority] as String,
  createdAt: json[todoFields.createdAt] as String,
     updateAt: json[todoFields.updateAt] as dynamic,
    status: json[todoFields.status] as dynamic);

   Set<Todo> copy({
    int? id,
    String? title,
    String? decription,
    String? Priority,
     String? createdAt,
     String? updateAt,
     String? status

  })=>{
    Todo(
      id:id ?? this.id,
      title:title ?? this.title,
      decription:decription ?? this.decription,
      Priority: Priority ?? this.Priority,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      status: status ?? this.status

    )
  };

Map<String, Object?> toJson() => {
  todoFields.id:id,
  todoFields.title:title,
todoFields.decription:decription,
  todoFields.Priority:Priority,
  todoFields.createdAt:createdAt,
  todoFields.updateAt:updateAt
};
}