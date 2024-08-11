/// username : "saad.zgm@gmail.com"
/// password : "12345678"

class LoginRequest {
  LoginRequest({
      this.username, 
      this.password,});

  LoginRequest.fromJson(dynamic json) {
    username = json['username'];
    password = json['password'];
  }
  String? username;
  String? password;
LoginRequest copyWith({  String? username,
  String? password,
}) => LoginRequest(  username: username ?? this.username,
  password: password ?? this.password,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;
    return map;
  }

}