/// first_name : "Saad"
/// last_name : "kent"
/// username : "saad.zgm@gmail.com"
/// country_code : null
/// expiration_date : "2024-08-01T07:21:34.516379Z"
/// hobbies : null
/// job : null
/// bio : null
/// role : "C"

class UserModel {
  UserModel({
      this.firstName, 
      this.lastName, 
      this.username, 
      this.countryCode, 
      this.expirationDate, 
      this.hobbies, 
      this.job, 
      this.bio, 
      this.role,});

  UserModel.fromJson(dynamic json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    countryCode = json['country_code'];
    expirationDate = json['expiration_date'];
    hobbies = json['hobbies'];
    job = json['job'];
    bio = json['bio'];
    role = json['role'];
  }
  String? firstName;
  String? lastName;
  String? username;
  String? countryCode;
  String? expirationDate;
  String? hobbies;
  String? job;
  String? bio;
  String? role;
UserModel copyWith({  String? firstName,
  String? lastName,
  String? username,
  String? countryCode,
  String? expirationDate,
  String? hobbies,
  String? job,
  String? bio,
  String? role,
}) => UserModel(  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  username: username ?? this.username,
  countryCode: countryCode ?? this.countryCode,
  expirationDate: expirationDate ?? this.expirationDate,
  hobbies: hobbies ?? this.hobbies,
  job: job ?? this.job,
  bio: bio ?? this.bio,
  role: role ?? this.role,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['username'] = username;
    map['country_code'] = countryCode;
    map['expiration_date'] = expirationDate;
    map['hobbies'] = hobbies;
    map['job'] = job;
    map['bio'] = bio;
    map['role'] = role;
    return map;
  }

}