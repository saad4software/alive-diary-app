/// status : "success"
/// code : 200
/// data : {}
/// message : null

class GenericResponse<T> {
  GenericResponse({
      this.status, 
      this.code,
      this.data, 
      this.message,});

  GenericResponse.fromJson(dynamic json, T Function(Object json) fromJsonT) {
    status = json['status'];
    code = json['code'];
    data = fromJsonT(json['data']);
    message = json['message'];
  }
  String? status;
  num? code;

  T? data;

  String? message;
GenericResponse copyWith({  String? status,
  num? code,
  dynamic data,
  dynamic message,
}) => GenericResponse(  status: status ?? this.status,
  code: code ?? this.code,
  data: data ?? this.data,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson(Object Function(T? value) toJsonT) {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['code'] = code;
    map['data'] = toJsonT(data);
    map['message'] = message;
    return map;
  }


}