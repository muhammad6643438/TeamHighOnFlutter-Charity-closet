import 'package:admin/screens/brands.dart';
import 'package:admin/screens/complaints.dart';
import 'package:admin/screens/donations.dart';
import 'package:admin/screens/out_city_orders.dart';
import 'package:admin/screens/register_user_screen.dart';
import 'package:admin/screens/ngos.dart';
import 'package:admin/screens/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final menuViewModel = ChangeNotifierProvider<MenuAppController>(
  (ref) => MenuAppController(),
);

class MenuAppController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget get currentScreen => _currentScreen();

  _currentScreen() {
    if (isRegister) {
      return RegisterUserScreen();
    } else if (isComplaint) {
      return Complaints();
    } else if (isBrand) {
      return Brands();
    } else if (isNgo) {
      return Ngo();
    } else if (isUsers) {
      return Users();
    } else if (isDonations) {
      return Donations();
    } else {
      return Ngo();
    }
  }

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  bool isDashboard = false;
  bool isComplaint = false;
  bool isBrand = false;
  bool isNgo = true;
  bool isUsers = false;
  bool isRegister = false;
  bool isDonations = false;

  onDashboard() {
    isDashboard = true;
    isDonations = false;
    isBrand = false;
    isComplaint = false;
    isNgo = false;
    isUsers = false;
    isRegister = false;
    notifyListeners();
  }

  onComplaints() {
    isComplaint = true;
    isDonations = false;
    isDashboard = false;
    isBrand = false;
    isNgo = false;
    isUsers = false;
    isRegister = false;
    notifyListeners();
  }

  onDonations() {
    isDonations = true;
    isComplaint = false;
    isDashboard = false;
    isBrand = false;
    isNgo = false;
    isUsers = false;
    isRegister = false;
    notifyListeners();
  }

  onBrand() {
    isBrand = true;
    isDonations = false;
    isDashboard = false;
    isComplaint = false;
    isNgo = false;
    isUsers = false;
    isRegister = false;
    notifyListeners();
  }

  onNgo() {
    isNgo = true;
    isDonations = false;
    isDashboard = false;
    isBrand = false;
    isComplaint = false;
    isUsers = false;
    isRegister = false;
    notifyListeners();
  }

  onUsers() {
    isUsers = true;
    isDonations = false;
    isDashboard = false;
    isBrand = false;
    isComplaint = false;
    isNgo = false;
    isRegister = false;
    notifyListeners();
  }

  onBillings() {
    isUsers = true;
    isDonations = false;
    isDashboard = false;
    isBrand = false;
    isComplaint = false;
    isNgo = false;
    isRegister = false;
    notifyListeners();
  }

  onProfile() {
    isRegister = true;
    isDonations = false;
    isDashboard = false;
    isBrand = false;
    isComplaint = false;
    isNgo = false;
    isUsers = false;
    notifyListeners();
  }
}
