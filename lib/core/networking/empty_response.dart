class EmptyResponse {
  List<Errors>? errors;
  String? message;

  EmptyResponse({this.errors, this.message});

  EmptyResponse.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(Errors.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;

    return data;
  }
}

class Errors {
  int? code;
  String? source;
  String? message;

  Errors({this.code, this.source, this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    source = json['source'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['source'] = source;
    data['message'] = message;
    return data;
  }
}
