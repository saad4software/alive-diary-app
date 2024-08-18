import 'package:equatable/equatable.dart';

/// created : "2024-07-15T06:29:31.805109Z"
/// active : true
/// first_name : "Saad"
/// last_name : "Kent"
/// status : "E"
/// is_built : false
/// last_built : ""
/// id : 5

class MemoryModel extends Equatable {
  MemoryModel({
      this.created, 
      this.active, 
      this.firstName, 
      this.lastName, 
      this.status, 
      this.isBuilt, 
      this.lastBuilt, 
      this.isMemory,
      this.title,
      this.id,});

  MemoryModel.fromJson(dynamic json) {
    created = json['created'];
    active = json['active'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    status = json['status'];
    isBuilt = json['is_built'];
    isMemory = json['is_memory'];
    title = json['title'];
    lastBuilt = json['last_built'];
    id = json['id'];
  }
  String? created;
  bool? active;
  String? firstName;
  String? lastName;
  String? status;
  bool? isBuilt;
  bool? isMemory;
  String? title;
  String? lastBuilt;
  int? id;
  MemoryModel copyWith({  String? created,
  bool? active,
  String? firstName,
  String? lastName,
  String? status,
  bool? isBuilt,
  String? lastBuilt,
  int? id,
}) => MemoryModel(  created: created ?? this.created,
  active: active ?? this.active,
  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  status: status ?? this.status,
  isBuilt: isBuilt ?? this.isBuilt,
  lastBuilt: lastBuilt ?? this.lastBuilt,
  id: id ?? this.id,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['created'] = created;
    map['active'] = active;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['status'] = status;
    map['is_built'] = isBuilt;
    map['last_built'] = lastBuilt;
    map['is_memory'] = isMemory;
    map['title'] = title;
    map['id'] = id;
    return map;
  }

  @override
  List<Object?> get props => [id];

}