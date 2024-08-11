/// created : "2024-07-02T07:50:57.371853Z"
/// active : true
/// id : 2

class ConversationModel {
  ConversationModel({
      this.created, 
      this.active, 
      this.id,});

  ConversationModel.fromJson(dynamic json) {
    created = json['created'];
    active = json['active'];
    id = json['id'];
  }
  String? created;
  bool? active;
  num? id;
ConversationModel copyWith({  String? created,
  bool? active,
  num? id,
}) => ConversationModel(  created: created ?? this.created,
  active: active ?? this.active,
  id: id ?? this.id,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['created'] = created;
    map['active'] = active;
    map['id'] = id;
    return map;
  }

}