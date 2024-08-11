/// status : "error"
/// code : 400
/// data : null
/// message : "invalid_credentials\n\r"

class ErrorResponse {
  ErrorResponse({
      this.status, 
      this.code, 
      this.data, 
      this.message,});

  ErrorResponse.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    data = json['data'];
    message = json['message'];
  }
  String? status;
  num? code;
  dynamic data;
  String? message;
ErrorResponse copyWith({  String? status,
  num? code,
  dynamic data,
  String? message,
}) => ErrorResponse(  status: status ?? this.status,
  code: code ?? this.code,
  data: data ?? this.data,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['code'] = code;
    map['data'] = data;
    map['message'] = message;
    return map;
  }

}