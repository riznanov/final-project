class Checks{
  List<Checks>data;

Checks ({this.data});

factory Checks.fromJson(Map<String, dynamic> json) => new Checks(
  data:  new List<Checks>.from(json["data"].map((x) => Checks.fromJson(x))),
);
Map <String, dynamic> toJson() => {
  "data" : new List<dynamic>.from(data.map((x) => x.toJson())),
};
}

class Check{
  String id;
  String item;
  int createdAt;
  int index;
  bool isComplete;
  String categoriId;
  int updateAt;
Check({this.id, this.item, this.createdAt, this.index, this.isComplete, this.categoriId, this.updateAt});

factory Check.fromJson(Map<String, dynamic> json) => new Check(
  id: json["id"],
  item: json["item"],
  createdAt: json["createdAt"],
  index: json["index"],
  isComplete: json["isComplete"],
  categoriId: json["categoriId"],
  updateAt: json["uploadAt"],
);
Map <String, dynamic> toJson() => {
   "id" : id,
   "item" : item,
   "createdAt" : createdAt,
   "index" : index,
   "isComplete" : isComplete,
   "categoriId" : categoriId,
   "updateAt" : updateAt,
 };
}