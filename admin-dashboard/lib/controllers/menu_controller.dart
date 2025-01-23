import 'package:admin/screens/dashboard_screen.dart';
import 'package:admin/screens/diesel_screen.dart';
import 'package:admin/screens/in_city_orders.dart';
import 'package:admin/screens/out_city_orders.dart';
import 'package:admin/screens/register_user_screen.dart';
import 'package:admin/screens/vessel_orders.dart';
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
    } else if (isNotifications) {
      return Notifications();
    } else if (isBrand) {
      return Brand();
    } else if (isNgo) {
      return Ngo();
    } else {
      return DashboardScreen();
    }
  }

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  bool isDashboard = true;
  bool isNotifications = false;
  bool isBrand = false;
  bool isNgo = false;
  bool isDiesel = false;
  bool isRegister = false;

  onDashboard() {
    isDashboard = true;
    isBrand = false;
    isNotifications = false;
    isNgo = false;
    isDiesel = false;
    isRegister = false;
    notifyListeners();
  }

  onNotifications() {
    isNotifications = true;
    isDashboard = false;
    isBrand = false;
    isNgo = false;
    isDiesel = false;
    isRegister = false;
    notifyListeners();
  }

  onBrand() {
    isBrand = true;
    isDashboard = false;
    isNotifications = false;
    isNgo = false;
    isDiesel = false;
    isRegister = false;
    notifyListeners();
  }

  onNgo() {
    isNgo = true;
    isDashboard = false;
    isBrand = false;
    isNotifications = false;
    isDiesel = false;
    isRegister = false;
    notifyListeners();
  }

  onBillings() {
    isDiesel = true;
    isDashboard = false;
    isBrand = false;
    isNotifications = false;
    isNgo = false;
    isRegister = false;
    notifyListeners();
  }

  onProfile() {
    isRegister = true;
    isDashboard = false;
    isBrand = false;
    isNotifications = false;
    isNgo = false;
    isDiesel = false;
    notifyListeners();
  }
}
