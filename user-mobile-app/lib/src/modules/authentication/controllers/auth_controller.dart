import 'dart:convert';

import 'package:charity_closet/src/core/services/routing%20service/app_routes.dart';
import 'package:charity_closet/src/core/services/routing%20service/routing_service.dart';
import 'package:charity_closet/src/core/utils/buffers.dart';
import 'package:charity_closet/src/modules/authentication/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authController = ChangeNotifierProvider.autoDispose(
  (ref) => AuthController(),
);

class AuthController extends ChangeNotifier with Buffers {
  AuthController() {
    fetchUser();
  }

  bool? isRemembered = true;
  bool card1 = false;
  bool card2 = false;
  bool card3 = false;
  bool isLoading = false;
  bool isLoadingSignUp = false;

  void changeLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void changeLoadingSignUp(bool value) {
    isLoadingSignUp = value;
    notifyListeners();
  }

  UserModel? userModel;

  void updateCard1(bool value) {
    card1 = value;
    notifyListeners();
  }

  void updateCard2(bool value) {
    card2 = value;
    notifyListeners();
  }

  void updateCard3(bool value) {
    card3 = value;
    notifyListeners();
  }

  void updateRemembered(bool? value) {
    isRemembered = value;
    notifyListeners();
  }

  Future<void> onAnimationCompleted() async {
    print("[UserModel]: $userModel");
    if (userModel != null) {
      AppRouterGo.pushReplacement(dashboardScreen);
    } else {
      AppRouterGo.pushReplacement(loginScreen);
    }
  }

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  void fetchUser() async {
    try {
      var data = await _secureStorage.read(key: 'user');
        print(data);
      if (data != null) {
        userModel = UserModel.fromJson(jsonDecode(data));
      }
    } catch (e) {
      print("Error fetching user: $e");
    }
  }
}
