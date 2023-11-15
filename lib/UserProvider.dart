import 'package:flutter/cupertino.dart';
import '../models/User.dart';

class UserProvider extends ChangeNotifier {
  User? currentUser;

  UserProvider(this.currentUser);
}