class Todos{
  List<Todos>data;

Todos ({this.data});

factory Todos.fromJson(Map<String, dynamic> json) => new Todos(
  data:  new List<Todos>.from(json["data"].map((x) => Todos.fromJson(x))),
);
Map <String, dynamic> toJson() => {
  "data" : new List<dynamic>.from(data.map((x) => x.toJson())),
};
}

class Todo{
  String id;
  String item;
  int createdAt;
  int index;
  bool isComplete;
  String taskId;
  int updateAt;
Todo({this.id, this.item, this.createdAt, this.index, this.isComplete, this.taskId, this.updateAt});

factory Todo.fromJson(Map<String, dynamic> json) => new Todo(
  id: json["id"],
  item: json["item"],
  createdAt: json["createdAt"],
  index: json["index"],
  isComplete: json["isComplete"],
  taskId: json["taskId"],
  updateAt: json["uploadAt"],
);
Map <String, dynamic> toJson() => {
   "id" : id,
   "item" : item,
   "createdAt" : createdAt,
   "index" : index,
   "isComplete" : isComplete,
   "taskId" : taskId,
   "updateAt" : updateAt,
 };
}