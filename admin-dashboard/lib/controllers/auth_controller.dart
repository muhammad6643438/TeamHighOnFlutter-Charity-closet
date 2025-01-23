import 'package:admin/core/app_logger.dart';
import 'package:admin/core/app_prompts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModel = ChangeNotifierProvider<AuthViewModel>(
  (ref) => AuthViewModel(),
);

class AuthViewModel extends ChangeNotifier {
  late BuildContext context;

  void init(BuildContext context) {
    this.context = context;
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool get isPasswordVisible => _isPasswordVisible;

  bool _isPasswordVisible = true;

  void togglePassword() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void login() {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      appPrint("Email: ${email.text}");
      appPrint("Password: ${password.text}");
      _confirmLogin();
    } else {
      Prompts.showSnackBar(context, "Email or Password is empty");
    }
  }

  void _confirmLogin() {
    // NavigationService.pushReplacement(
    //   context,
    //   const CreateUserAccount(),
    // );
  }
}
