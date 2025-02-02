import 'User.dart';

class Doctor extends User {
  late String _specialization;
  late String _graduate;

  Doctor(
      {required int id,
      required int roleId,
      required String username,
      String password = "",
      String token = "",
      String name = "",
      String lastname = "",
      String specialization = "",
      String graduate = ""})
      : super(
            id: id,
            roleId: roleId,
            name: name,
            lastname: lastname,
            username: username,
            password: password,
            token: token) {
    this._specialization = specialization;
    this._graduate = graduate;
  }

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json["id"] as int,
      roleId: json["roleId"] as int,
      name: json["name"] as String,
      lastname: json["lastname"] as String,
      username: json["username"] as String,
      // password: json["password"] as String,
      specialization: json["specialization"] as String,
      graduate: json["graduate"] as String,
    );
  }

  // factory Doctor.fromJsonForLogin(Map<String, dynamic> json) {
  //   Doctor doctor = Doctor.fromJson(json);
  //   User user=User.fromJsonForLogin(json);
  //   doctor.token = user.token;
  //   return doctor;
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
      'specialization': _specialization,
      'graduate': _graduate,
    };
  }

  String toString() {
    return "Doctor{" +
        "id=$id" +
        ", roleId=$roleId" +
        ", name=$name" +
        ", lastname=$lastname" +
        ", username=$username" +
        ", password=$password" +
        ", token=$token" +
        ", specialization=$_specialization" +
        ", graduate=$_graduate" +
        '}';
  }

  String get graduate => _graduate;

  String get specialization => _specialization;
}
