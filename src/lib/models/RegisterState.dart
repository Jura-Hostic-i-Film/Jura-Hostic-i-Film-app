import '../DTOs/RegisterDTO.dart';
import '../models/Role.dart';

class RegisterState {
  String email = '';
  String emailError = '';
  String username = '';
  String usernameError = '';
  String firstName = '';
  String firstNameError = '';
  String lastName = '';
  String lastNameError = '';
  String password = '';
  String passwordVerify = '';
  String passwordError = '';
  List<Role> roles = [];

  RegisterState();

  RegisterDTO toRegisterDTO() {
    return RegisterDTO(
      email,
      username,
      firstName,
      lastName,
      password,
      roles,
    );
  }
}