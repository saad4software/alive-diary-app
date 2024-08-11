/// username : "saad.zgm@gmail.com"
/// code : "198334"

class ActivateAccountRequest {
  ActivateAccountRequest({
      this.username, 
      this.code,});

  ActivateAccountRequest.fromJson(dynamic json) {
    username = json['username'];
    code = json['code'];
  }
  String? username;
  String? code;
ActivateAccountRequest copyWith({  String? username,
  String? code,
}) => ActivateAccountRequest(  username: username ?? this.username,
  code: code ?? this.code,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['code'] = code;
    return map;
  }

}