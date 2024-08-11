/// first_name : "Saad"
/// last_name : "kent"
/// username : "saad.zgm@gmail.com"
/// password1 : "12345678"
/// password2 : "12345678"

class RegisterRequest {
  RegisterRequest({
      this.firstName, 
      this.lastName, 
      this.username, 
      this.password1, 
      this.password2,
  });

  RegisterRequest.fromJson(dynamic json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    password1 = json['password1'];
    password2 = json['password2'];
  }
  String? firstName;
  String? lastName;
  String? username;
  String? password1;
  String? password2;
RegisterRequest copyWith({  String? firstName,
  String? lastName,
  String? username,
  String? password1,
  String? password2,
}) => RegisterRequest(  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  username: username ?? this.username,
  password1: password1 ?? this.password1,
  password2: password2 ?? this.password2,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['username'] = username;
    map['password1'] = password1;
    map['password2'] = password2;
    return map;
  }

}