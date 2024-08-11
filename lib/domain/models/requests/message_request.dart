/// text : "sorry, I have an appointment and need to go, see you later"
/// conversation : 7

class MessageRequest {
  MessageRequest({
      this.text, 
      this.conversation,});

  MessageRequest.fromJson(dynamic json) {
    text = json['text'];
    conversation = json['conversation'];
  }
  String? text;
  num? conversation;
MessageRequest copyWith({  String? text,
  num? conversation,
}) => MessageRequest(  text: text ?? this.text,
  conversation: conversation ?? this.conversation,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = text;
    map['conversation'] = conversation;
    return map;
  }

}