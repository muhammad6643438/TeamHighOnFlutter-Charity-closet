import 'package:admin/core/app_logger.dart';
import 'package:admin/core/app_prompts.dart';
import 'package:admin/models/controller_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerUserViewModel = ChangeNotifierProvider<RegisterUserController>(
  (ref) => RegisterUserController(),
);

class RegisterUserController extends ChangeNotifier {
  late BuildContext context;
  bool isRegister = true;
  int _count = 0;

  TextEditingController name = TextEditingController();
  TextEditingController cnic = TextEditingController();
  TextEditingController phone = TextEditingController();
  List<Controllers> vehiclesNo = [];
  void get createUserAccount => _createUserAccount();
  int get count => _count;
  void get add => _addVehicleCount();
  void get remove => _reduceVehicleCount();

  init(BuildContext context) {
    this.context = context;
  }

  void _addVehicleCount() {
    _count++;
    appPrint(_count);
    notifyListeners();
  }

  void _reduceVehicleCount() {
    if (_count == 0) return;
    _count--;
    appPrint(_count);
    notifyListeners();
  }

  void _createUserAccount() {
    if (name.text.isNotEmpty && cnic.text.isNotEmpty && phone.text.isNotEmpty) {
      appPrint("Name: ${name.text}");
      appPrint("CNIC: ${cnic.text}");
      appPrint("Phone: ${phone.text}");
      _confirmCreateUserAccount();
    } else {
      Prompts.showSnackBar(
        context,
        "Please fill all fields",
      );
    }
  }

  void _confirmCreateUserAccount() {
    // NavigationService.push(
    //   context,
    //   const AddVehiclesScreen(),
    // );
  }
}
