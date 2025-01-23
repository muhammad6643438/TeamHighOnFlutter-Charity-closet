import 'package:charity_closet/src/core/services/routing%20service/app_routes.dart';
import 'package:charity_closet/src/modules/authentication/views/forgot_password_view.dart';
import 'package:charity_closet/src/modules/authentication/views/login_view.dart';
import 'package:charity_closet/src/modules/authentication/views/sign_up.dart';
import 'package:charity_closet/src/modules/authentication/views/splah_view.dart';
import 'package:charity_closet/src/modules/dashboard/views/complaint_view.dart';
import 'package:charity_closet/src/modules/dashboard/views/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouterGo {
  static BuildContext get context =>
      appRouter.routerDelegate.navigatorKey.currentContext!;
  static final appRouter = GoRouter(
    routes: [
      GoRoute(
        path: splashScreen,
        builder: (context, state) {
          return const SplashView();
        },
      ),
      GoRoute(
        path: loginScreen,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: forgotPasswordScreen,
        builder: (context, state) {
          return const ForgotPasswordView();
        },
      ),
      GoRoute(
        path: signUpScreen,
        builder: (context, state) {
          return const SignUpView();
        },
      ),
      GoRoute(
        path: dashboardScreen,
        builder: (context, state) {
          return const GeneralPhysicianHomePage();
        },
      ),
      GoRoute(
        path: donateScreen,
        builder: (context, state) {
          return const GeneralPhysicianHomePage();
        },
      ),
      GoRoute(
        path: complaintScreen,
        builder: (context, state) {
          return const ComplaintView();
        },
      ),
    ],
  );
  static void back() {
    if (context.canPop()) {
      context.pop();
    }
  }

  static push(
    location, {
    Map<String, dynamic>? extra,
    Future<void> Function()? onThen,
  }) {
    context.push(location, extra: extra).then(
      (value) {
        onThen?.call();
      },
    );
  }

  static pushRemoveUntil(location) {
    context.go(location);
  }

  static pushReplacement(location) {
    context.replace(location);
  }
}
