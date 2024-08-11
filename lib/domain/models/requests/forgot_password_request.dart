/// username : "saad.zgm@gmail.com"
/// code : "12243"
/// new_password : "12345678"

class ForgotPasswordRequest {
  ForgotPasswordRequest({
      this.username, 
      this.code, 
      this.newPassword,});

  ForgotPasswordRequest.fromJson(dynamic json) {
    username = json['username'];
    code = json['code'];
    newPassword = json['new_password'];
  }
  String? username;
  String? code;
  String? newPassword;
ForgotPasswordRequest copyWith({  String? username,
  String? code,
  String? newPassword,
}) => ForgotPasswordRequest(  username: username ?? this.username,
  code: code ?? this.code,
  newPassword: newPassword ?? this.newPassword,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['code'] = code;
    map['new_password'] = newPassword;
    return map;
  }

}