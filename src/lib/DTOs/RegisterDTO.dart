import 'package:jura_hostic_i_film_app/DTOs/LoginDTO.dart';

import '../models/Role.dart';

class RegisterDTO {
  String email;
  String username;
  String firstName;
  String lastName;
  String password;
  List<Role> roles;

  RegisterDTO(
      this.email,
      this.username,
      this.firstName,
      this.lastName,
      this.password,
      this.roles,
  );

  LoginDTO toLoginDTO() {
    return LoginDTO(
      username,
      password,
    );
  }
}