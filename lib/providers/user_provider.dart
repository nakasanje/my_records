import 'package:flutter/widgets.dart';

import '../auth/auth_methods.dart';
import '../auth/user.dart';

class UserProvider with ChangeNotifier {
  UserModel _user = UserModel(
    email: "",
    uid: "",
    photoUrl: "",
    username: "",
    role: "",
  );
  final AuthMethods _authMethods = AuthMethods();

  UserModel get getUser => _user;

  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUserDetails();
    _user = user;

    notifyListeners();
  }
}
