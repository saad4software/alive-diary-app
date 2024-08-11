/// refresh : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY5OTI5NTY1MywiaWF0IjoxNjk4ODYzNjUzLCJqdGkiOiIxYmJmNjUxN2RmYTA0YTY1YmQ2NjdhZDViZDRkMDkyMSIsInVzZXJfaWQiOjF9.ZWwoOcXu6Q4Toi9xjUhZCGWinRoqCZwBb4wYZgPmoMg"

class RefreshCodeRequest {
  RefreshCodeRequest({
      this.refresh,});

  RefreshCodeRequest.fromJson(dynamic json) {
    refresh = json['refresh'];
  }
  String? refresh;
RefreshCodeRequest copyWith({  String? refresh,
}) => RefreshCodeRequest(  refresh: refresh ?? this.refresh,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['refresh'] = refresh;
    return map;
  }

}