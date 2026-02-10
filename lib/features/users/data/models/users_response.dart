import 'package:wassela_task_app/features/users/data/models/user_model.dart';

class UsersResponse {
  List<UserModel>? users;
  int? total;
  int? skip;
  int? limit;

  UsersResponse({this.users, this.total, this.skip, this.limit});

  UsersResponse.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <UserModel>[];
      json['users'].forEach((v) {
        users!.add(UserModel.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['skip'] = skip;
    data['limit'] = limit;
    return data;
  }
}
