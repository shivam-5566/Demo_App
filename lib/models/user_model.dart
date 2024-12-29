
class UserModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;
  String? localImagePath;

  UserModel(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.avatar,
      this.localImagePath});

   UserModel.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      email= json['email'];
      firstName= json['first_name'];
      lastName= json['last_name'];
      avatar= json['avatar'];
      localImagePath = json['localImagePath'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'avatar': avatar,
      'localImagePath': localImagePath,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      avatar: map['avatar'],
      localImagePath: map['localImagePath'],
    );
  }
}
