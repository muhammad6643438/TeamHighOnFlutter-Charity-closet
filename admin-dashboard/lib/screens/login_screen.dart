// ignore_for_file: non_constant_identifier_names

import 'package:admin/controllers/auth_controller.dart';
import 'package:admin/core/app_router.dart';
import 'package:admin/core/app_validators.dart';
import 'package:admin/core/services/firebase_service.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/custom_button.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/widgets/glassmorphed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';
import 'dashboard/components/header.dart';

class LoginScreen extends ConsumerWidget {
  @override
  Widget build(context, ref) {
    AuthViewModel auth = ref.watch(authViewModel);
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppSize.isMobile(context)
                  ? LoginForm(
                      auth: auth,
                      context: context,
                      width: _size.width,
                    )
                  : LoginForm(
                      auth: auth,
                      context: context,
                      width: _size.width / 3,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget LoginForm({
  required AuthViewModel auth,
  context,
  double? width,
}) {
  final formKey = GlobalKey<FormState>();
  return Container(
    alignment: Alignment.center,
    width: width ?? double.infinity,
    child: GlassMorphedContainer(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox.square(
                dimension: 200,
                child: Image.asset("assets/icons/charity-closet.png"),
              ),
              // SizedBox(height: defaultPadding),
              Text("Login", style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: defaultPadding),
              SearchField(
                title: 'Email',
                validator: AppValidator.validateEmail,
                controller: auth.email,
              ),
              SizedBox(height: defaultPadding),
              SearchField(
                title: 'Password',
                validator: AppValidator.validatePassword,
                controller: auth.password,
                obscureText: true,
              ),
              SizedBox(height: defaultPadding),
              CustomButton(
                loading: auth.isLoading,
                title: 'Login',
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      auth.updateLoading(true);
                      FirebaseService firebaseService = FirebaseService();
                      // await firebaseService.loginWithEmail(
                      //     auth.email.text, auth.password.text,context);
                      User? user = await firebaseService.loginWithEmail(
                        auth.email.text,
                        auth.password.text,
                        context, // Pass context here
                      );
                      if (user != null) {
                        NavigationService.pushReplacement(
                            context, MainScreen());
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('${e.toString}'),
                        duration: Duration(
                          seconds: 3,
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.grey,
                      ));
                    } finally {
                      auth.updateLoading(false);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
