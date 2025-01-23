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
    } else if (isOutCity) {
      return OutCityOrders();
    } else if (isInCity) {
      return InCityOrders();
    } else if (isVessel) {
      return VesselOrders();
    } else if (isDiesel) {
      return DieselScreen();
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
  bool isOutCity = false;
  bool isInCity = false;
  bool isVessel = false;
  bool isDiesel = false;
  bool isRegister = false;

  onDashboard() {
    isDashboard = true;
    isInCity = false;
    isOutCity = false;
    isVessel = false;
    isDiesel = false;
    isRegister = false;
    notifyListeners();
  }

  onOutCity() {
    isOutCity = true;
    isDashboard = false;
    isInCity = false;
    isVessel = false;
    isDiesel = false;
    isRegister = false;
    notifyListeners();
  }

  onInCity() {
    isInCity = true;
    isDashboard = false;
    isOutCity = false;
    isVessel = false;
    isDiesel = false;
    isRegister = false;
    notifyListeners();
  }

  onVessel() {
    isVessel = true;
    isDashboard = false;
    isInCity = false;
    isOutCity = false;
    isDiesel = false;
    isRegister = false;
    notifyListeners();
  }

  onBillings() {
    isDiesel = true;
    isDashboard = false;
    isInCity = false;
    isOutCity = false;
    isVessel = false;
    isRegister = false;
    notifyListeners();
  }

  onProfile() {
    isRegister = true;
    isDashboard = false;
    isInCity = false;
    isOutCity = false;
    isVessel = false;
    isDiesel = false;
    notifyListeners();
  }
}
