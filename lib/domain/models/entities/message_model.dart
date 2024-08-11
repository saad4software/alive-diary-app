/// created : "2024-07-02T19:18:15.939621Z"
/// active : true
/// text : "No worries at all!  I completely understand.  It sounds like you have a lot going on.  Take care of yourself and I'll look forward to seeing you next time.  😊 \n"
/// is_user : false
/// conversation : 7
/// id : 40

class MessageModel {
  MessageModel({
      this.created, 
      this.active, 
      this.text, 
      this.isUser, 
      this.conversation, 
      this.id,});

  MessageModel.fromJson(dynamic json) {
    created = json['created'];
    active = json['active'];
    text = json['text'];
    isUser = json['is_user'];
    conversation = json['conversation'];
    id = json['id'];
  }
  String? created;
  bool? active;
  String? text;
  bool? isUser;
  int? conversation;
  int? id;
MessageModel copyWith({  String? created,
  bool? active,
  String? text,
  bool? isUser,
  int? conversation,
  int? id,
}) => MessageModel(  created: created ?? this.created,
  active: active ?? this.active,
  text: text ?? this.text,
  isUser: isUser ?? this.isUser,
  conversation: conversation ?? this.conversation,
  id: id ?? this.id,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['created'] = created;
    map['active'] = active;
    map['text'] = text;
    map['is_user'] = isUser;
    map['conversation'] = conversation;
    map['id'] = id;
    return map;
  }

}