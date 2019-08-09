import 'dart:convert';

class Tasks {
  List<Tasks>data;

Tasks ({this.data});

factory Tasks.fromJson(Map<String, dynamic> json) => new Tasks(
  data:  new List<Tasks>.from(json["data"].map((x) => Tasks.fromJson(x))),
);

Map <String, dynamic> toJson() => {
  "data" : new List<dynamic>.from(data.map((x) => x.toJson())),
};
}

class Task {
  String id;
  String title;
  int createdAt;
  int index;
  String userId;
  String uploadAt;

  Task({this.id, this.title, this.createdAt, this.index, this.userId, this.uploadAt});

  factory Task.fromJson(Map<String, dynamic> json) => new Task(
  id: json["id"],
  title: json["title"],
  createdAt: json["created_at"],
  index: json["index"],
  userId: json["userId"],
  uploadAt: json["uploadAt"],
);
 Map <String, dynamic> toJson() => {
   "id" : id,
   "title" : title,
   "createdAt" : createdAt,
   "index" : index,
   "userId" : userId,
   "uploadAt" : uploadAt,
 };

}

List<Task> taskFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Task>.from(data.map((item) => Task.fromJson(item)));
}

String taskToJson(Task data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
