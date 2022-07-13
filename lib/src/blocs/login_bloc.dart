import 'dart:async';

import 'package:authen_app/src/validators/validation.dart';

class LoginBloc {
  StreamController _userController = new StreamController();
  StreamController _passController = new StreamController();

  Stream get userStream => _userController.stream;
  Stream get passStream => _passController.stream;

  bool isValidInfo(String username, String pass) {
    if (!Validation.isValidUser(username)) {
      _userController.sink.addError('Tài khoản không hợp lệ');
      return false;
    }
     _userController.sink.add('OK');

    if (!Validation.isValidPass(pass)) {
      _passController.sink.addError('Mật khẩu phải trên 6 ký tự');
      return false;
    }

    _passController.sink.add('OK');
    return true;
  }

  void dispose() {
    _userController.close();
    _passController.close();
  }
}
