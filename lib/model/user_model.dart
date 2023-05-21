class UserModel {
  String? userId;
  String? userName;
  String? email;
  String? password;

  UserModel(this.userId, this.userName, this.email, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': userId,
      'user_name': userName,
      'email': email,
      'password': password
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    userId = map['user_id'];
    userName = map['user_name'];
    email = map['email'];
    password = map['password'];
  }
}
