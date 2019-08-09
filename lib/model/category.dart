class Categories {
  List<Categories>data;

Categories ({this.data});

factory Categories.fromJson(Map<String, dynamic> json) => new Categories(
  data:  new List<Categories>.from(json["data"].map((x) => Categories.fromJson(x))),
);

Map <String, dynamic> toJson() => {
  "data" : new List<dynamic>.from(data.map((x) => x.toJson())),
};
}

class Categori {
  String id;
  String title;
  int createdAt;
  int index;
  String userId;
  String uploadAt;

Categori({this.id, this.title, this.createdAt, this.index, this.userId, this.uploadAt});

factory Categori.fromJson(Map<String, dynamic> json) => new Categori(
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

