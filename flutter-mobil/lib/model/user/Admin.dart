import 'User.dart';

class Admin extends User {
  Admin({required int id,
    required int roleId,
    required String name,
    required String lastname,
    required String username,
    String token = "",
    String password = ""})
      : super(
      id: id,
      roleId: roleId,
      name: name,
      lastname: lastname,
      username: username,
      token: token,
      password: password
  ) {
    id = id;
    roleId = roleId;
    name = name;
    lastname = lastname;
    username = username;
    password = password;
    token = token;
  }

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
        id: json["id"] as int,
        roleId: json["roleId"] as int,
        name: json["name"] as String,
        lastname: json['lastname'] as String,
        username: json["username"] as String,
        // password: json["password"] as String
    );
  }

  // factory Admin.fromJsonForLogin(Map<String, dynamic> json) {
  //   Admin admin = Admin.fromJson(json);
  //   User user=User.fromJsonForLogin(json);
  //   admin.token = user.token;
  //   return admin;
  // }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roleId': roleId,
      'name': name,
      'lastname': lastname,
      'username': username,
      'password': password,
      'token': token,
    };
  }

  String toString() {
    return "Admin{" +
        "id=$id" +
        ", roleId=$roleId" +
        ", name='$name'" +
        ", lastname='$lastname'" +
        ", username='$username'" +
        ", password='$password'" +
        ", token='$token'" +
        '}';
  }
}
