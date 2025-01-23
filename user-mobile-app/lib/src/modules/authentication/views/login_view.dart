// ignore_for_file: use_build_context_synchronously

import 'package:charity_closet/constants.dart';
import 'package:charity_closet/src/components/custom_button.dart';
import 'package:charity_closet/src/core/services/firebase%20service/firebase_service.dart';
import 'package:charity_closet/src/core/services/routing%20service/app_routes.dart';
import 'package:charity_closet/src/core/services/routing%20service/routing_service.dart';
import 'package:charity_closet/src/core/utils/app_colors.dart';
import 'package:charity_closet/src/core/utils/app_extensions.dart';
import 'package:charity_closet/src/core/utils/app_insets.dart';
import 'package:charity_closet/src/core/widgets/primary_textfield.dart';
import 'package:charity_closet/src/modules/authentication/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(context, ref) {
    var auth = ref.watch(authController);
    TextEditingController email = useTextEditingController();
    TextEditingController password = useTextEditingController();

    FirebaseService firebaseService = FirebaseService();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      // backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: AppInsets.only(left: 25, right: 25, top: 100),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/png/charityLogo.png',
                  height: 200.h,
                  width: 200.h,
                ),
                const Text(
                  "Login To Your Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                15.ph,
                PrimaryTextfield(
                  validator: (value) {
                    Pattern pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-z\-0-9]+\.)+[a-z]{2,}))$';
                    RegExp regex = RegExp(pattern.toString());

                    var matches = !regex.hasMatch(value ?? "");

                    if (matches) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                  hintText: 'E-Mail',
                  isPrefix: true,
                  prefixWidget: const Icon(Icons.email_outlined),
                  controller: email,
                ),
                12.ph,
                PrimaryTextfield(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  hintText: 'Password',
                  controller: password,
                  isPrefix: true,
                  isObscure: true,
                  isSuffix: true,
                  prefixWidget: const Icon(Icons.lock_outline_rounded),
                ),
                6.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          side: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                          checkColor: Colors.white,
                          activeColor: AppColors.primaryGreen,
                          value: auth.isRemembered,
                          onChanged: (value) => auth.updateRemembered(value),
                        ),
                        const Text(
                          "Remember Me",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () => AppRouterGo.push(forgotPasswordScreen),
                      child: const Text(
                        "Forgot Password",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                20.ph,
                CustomButton(
                  isLoading: auth.isLoading,
                  title: 'Sign In',
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      auth.changeLoading(true);
                      try {
                        auth.userModel = await firebaseService.loginWithEmail(
                          email.text,
                          password.text,
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                              const SnackBar(
                                content: Text('Account login successfully!'),
                                duration: Duration(
                                  seconds: 1,
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: AppColors.inactiveGray,
                              ),
                            )
                            .closed
                            .then((reason) {
                          AppRouterGo.pushReplacement(dashboardScreen);
                        });
                      } catch (e) {
                        auth.changeLoading(false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Something Went Wrong!'),
                            duration: Duration(
                              seconds: 1,
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: AppColors.inactiveGray,
                          ),
                        );
                      }
                    }
                  },
                ),
                6.ph,
                TextButton(
                    onPressed: () => AppRouterGo.push(signUpScreen),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don’t have an account?',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        6.pw,
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: primaryColor,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
