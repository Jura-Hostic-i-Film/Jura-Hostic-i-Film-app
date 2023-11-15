import 'Role.dart';

class User {
  String email;
  String username;
  String firstName;
  String lastName;
  int id;
  List<Role> roles;

  User({
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json["email"] as String,
      username: json["username"] as String,
      firstName: json["firstName"] as String,
      lastName: json["lastName"] as String,
      id: json["id"] as int,
      roles: (json["roles"] as List).map<Role>((json) => Role.fromJson(json)).toList(),
    );
  }
}