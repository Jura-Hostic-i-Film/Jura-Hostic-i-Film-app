import 'package:jura_hostic_i_film_app/DTOs/LoginDTO.dart';

class RegisterDTO {
  String email;
  String username;
  String firstName;
  String lastName;
  String password;

  RegisterDTO({
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.password,
  });

  LoginDTO toLoginDTO() {
    return LoginDTO(
      username,
      password,
    );
  }
}