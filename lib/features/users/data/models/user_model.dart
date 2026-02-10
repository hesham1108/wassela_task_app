class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? maidenName;
  int? age;
  String? gender;
  String? email;
  String? phone;
  String? username;
  String? birthDate;
  String? image;
  String? bloodGroup;
  double? height;
  double? weight;
  String? eyeColor;
  String? university;
  String? role;
  UserAddress? address;
  UserCompany? company;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.maidenName,
    this.age,
    this.gender,
    this.email,
    this.phone,
    this.username,
    this.birthDate,
    this.image,
    this.bloodGroup,
    this.height,
    this.weight,
    this.eyeColor,
    this.university,
    this.role,
    this.address,
    this.company,
  });

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    maidenName = json['maidenName'];
    age = json['age'];
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
    username = json['username'];
    birthDate = json['birthDate'];
    image = json['image'];
    bloodGroup = json['bloodGroup'];
    height = (json['height'] as num?)?.toDouble();
    weight = (json['weight'] as num?)?.toDouble();
    eyeColor = json['eyeColor'];
    university = json['university'];
    role = json['role'];
    address = json['address'] != null
        ? UserAddress.fromJson(json['address'])
        : null;
    company = json['company'] != null
        ? UserCompany.fromJson(json['company'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['maidenName'] = maidenName;
    data['age'] = age;
    data['gender'] = gender;
    data['email'] = email;
    data['phone'] = phone;
    data['username'] = username;
    data['birthDate'] = birthDate;
    data['image'] = image;
    data['bloodGroup'] = bloodGroup;
    data['height'] = height;
    data['weight'] = weight;
    data['eyeColor'] = eyeColor;
    data['university'] = university;
    data['role'] = role;
    if (address != null) data['address'] = address!.toJson();
    if (company != null) data['company'] = company!.toJson();
    return data;
  }

  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      maidenName: maidenName,
      age: age,
      gender: gender,
      email: email ?? this.email,
      phone: phone,
      username: username,
      birthDate: birthDate,
      image: image,
      bloodGroup: bloodGroup,
      height: height,
      weight: weight,
      eyeColor: eyeColor,
      university: university,
      role: role,
      address: address,
      company: company,
    );
  }
}

class UserAddress {
  String? address;
  String? city;
  String? state;
  String? stateCode;
  String? postalCode;
  String? country;

  UserAddress({
    this.address,
    this.city,
    this.state,
    this.stateCode,
    this.postalCode,
    this.country,
  });

  UserAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    state = json['state'];
    stateCode = json['stateCode'];
    postalCode = json['postalCode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['stateCode'] = stateCode;
    data['postalCode'] = postalCode;
    data['country'] = country;
    return data;
  }
}

class UserCompany {
  String? department;
  String? name;
  String? title;

  UserCompany({this.department, this.name, this.title});

  UserCompany.fromJson(Map<String, dynamic> json) {
    department = json['department'];
    name = json['name'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['department'] = department;
    data['name'] = name;
    data['title'] = title;
    return data;
  }
}
