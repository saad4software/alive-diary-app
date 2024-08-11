
import 'package:alive_diary/domain/models/entities/user_model.dart';

/// refresh : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcyMDQzNzA5MCwiaWF0IjoxNzIwMDA1MDkwLCJqdGkiOiIyMTY0NmUzMGUxYTQ0MTZiOGM3OTYyNGRhYTM3YWM3NyIsInVzZXJfaWQiOjJ9.hauv_9D6ur1jkDe5kl_5GG1h-VLrBDJmML6v_WQTnfs"
/// access : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwMDMzODkwLCJpYXQiOjE3MjAwMDUwOTAsImp0aSI6ImIxODU5MDlkNDcyZjQwOWVhOWQwMDAxMzdjMDY1MWMwIiwidXNlcl9pZCI6Mn0.MetlUezY_o1IIff0yE6ej0G8zI7FB1ZTW07hs6QBjFA"
/// user : {"first_name":"Saad","last_name":"kent","username":"saad.zgm@gmail.com","country_code":null,"expiration_date":"2024-08-01T07:21:34.516379Z","hobbies":null,"job":null,"bio":null,"role":"C"}
/// role : "C"
/// notifications : 0

class LoginModel {
  LoginModel({
      this.refresh, 
      this.access, 
      this.user, 
      this.role, 
      this.notifications,});

  LoginModel.fromJson(dynamic json) {
    refresh = json['refresh'];
    access = json['access'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    role = json['role'];
    notifications = json['notifications'];
  }
  String? refresh;
  String? access;
  UserModel? user;
  String? role;
  num? notifications;
LoginModel copyWith({  String? refresh,
  String? access,
  UserModel? user,
  String? role,
  num? notifications,
}) => LoginModel(  refresh: refresh ?? this.refresh,
  access: access ?? this.access,
  user: user ?? this.user,
  role: role ?? this.role,
  notifications: notifications ?? this.notifications,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['refresh'] = refresh;
    map['access'] = access;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['role'] = role;
    map['notifications'] = notifications;
    return map;
  }

}