/// count : 3
/// next : null
/// previous : null
/// results : [{"created":"2024-07-03T11:38:33.353143Z","active":true,"status":"E","is_built":false,"last_built":null,"id":4},{"created":"2024-07-15T06:29:31.805109Z","active":true,"status":"E","is_built":false,"last_built":null,"id":5},{"created":"2024-07-15T06:36:31.618787Z","active":true,"status":"E","is_built":false,"last_built":null,"id":6}]

class ListResponse<T> {
  ListResponse({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  ListResponse.fromJson(dynamic json, T Function(Object json) fromJsonT) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(fromJsonT(v));
      });
    }
  }
  int? count;
  String? next;
  String? previous;
  List<T>? results;
ListResponse copyWith({  int? count,
  dynamic next,
  dynamic previous,
  List<T>? results,
}) => ListResponse(  count: count ?? this.count,
  next: next ?? this.next,
  previous: previous ?? this.previous,
  results: results ?? this.results,
);
  Map<String, dynamic> toJson(Object Function(T? value) toJsonT) {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['next'] = next;
    map['previous'] = previous;
    if (results != null) {
      map['results'] = results?.map((v) => toJsonT(v)).toList();
    }
    return map;
  }

}