/// username : "saad.zgm@gmail.com"

class SendCodeRequest {
  SendCodeRequest({
      this.username,});

  SendCodeRequest.fromJson(dynamic json) {
    username = json['username'];
  }
  String? username;
SendCodeRequest copyWith({  String? username,
}) => SendCodeRequest(  username: username ?? this.username,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    return map;
  }

}