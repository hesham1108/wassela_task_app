class UpdateUserBody {
  String? firstName;
  String? lastName;
  String? email;

  UpdateUserBody({this.firstName, this.lastName, this.email});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (firstName != null) data['firstName'] = firstName;
    if (lastName != null) data['lastName'] = lastName;
    if (email != null) data['email'] = email;
    return data;
  }
}
