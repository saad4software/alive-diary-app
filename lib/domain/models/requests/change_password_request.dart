/// password : "admin1"
/// new_password : "admin"

class ChangePasswordRequest {
  ChangePasswordRequest({
      this.password, 
      this.newPassword,});

  ChangePasswordRequest.fromJson(dynamic json) {
    password = json['password'];
    newPassword = json['new_password'];
  }
  String? password;
  String? newPassword;
ChangePasswordRequest copyWith({  String? password,
  String? newPassword,
}) => ChangePasswordRequest(  password: password ?? this.password,
  newPassword: newPassword ?? this.newPassword,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['password'] = password;
    map['new_password'] = newPassword;
    return map;
  }

}