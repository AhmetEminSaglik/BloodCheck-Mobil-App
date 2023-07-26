import 'User.dart';

class UserFactory {
  static User createUser(Map<String, dynamic> json) {
    return User.fromJson(json);
  }
}
