// ignore_for_file: use_build_context_synchronously

import 'package:charity_closet/constants.dart';
import 'package:charity_closet/src/components/custom_button.dart';
import 'package:charity_closet/src/core/services/firebase%20service/firebase_service.dart';
import 'package:charity_closet/src/core/services/notification_service/notification_service.dart';
import 'package:charity_closet/src/core/services/routing%20service/app_routes.dart';
import 'package:charity_closet/src/core/services/routing%20service/routing_service.dart';
import 'package:charity_closet/src/core/utils/app_assets.dart';
import 'package:charity_closet/src/core/utils/app_colors.dart';
import 'package:charity_closet/src/core/utils/app_extensions.dart';
import 'package:charity_closet/src/core/utils/app_insets.dart';
import 'package:charity_closet/src/core/widgets/primary_textfield.dart';
import 'package:charity_closet/src/modules/authentication/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpView extends StatefulHookConsumerWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  NotificationServices notificationServices = NotificationServices();
  void signUpInit() async {
    notificationServices.requestNotificationsPermission();
    notificationServices.firebaseInit(context);
    notificationServices.getDeviceToken().then((value) {
      debugPrint('Device Token: $value');
    });
  }

  @override
  void initState() {
    super.initState();
    signUpInit();
  }

  @override
  Widget build(context) {
    var auth = ref.watch(authController);
    TextEditingController fullName = useTextEditingController();
    TextEditingController email = useTextEditingController();
    TextEditingController phoneNo = useTextEditingController();
    TextEditingController password = useTextEditingController();
    TextEditingController confirmpassword = useTextEditingController();

    FirebaseService firebaseService = FirebaseService();

    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      // backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: AppInsets.only(left: 25, right: 25, top: 30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(
                  AppAssets.charityLogo,
                  // color: Colors.white,
                  height: 200.h,
                  width: 200.h,
                ),
                const Text(
                  "Register Your Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                15.ph,
                PrimaryTextfield(
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  hintText: 'Full Name',
                  controller: fullName,
                  isPrefix: true,
                  prefixWidget: const Icon(Icons.info_outline),
                ),
                12.ph,
                PrimaryTextfield(
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'E-Mail is required';
                    }
                    return null;
                  },
                  hintText: 'E-Mail',
                  controller: email,
                  isPrefix: true,
                  prefixWidget: const Icon(Icons.email_outlined),
                ),
                12.ph,
                PrimaryTextfield(
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Phone No is required';
                    }
                    return null;
                  },
                  hintText: 'Phone No',
                  controller: phoneNo,
                  isPrefix: true,
                  prefixWidget: const Icon(Icons.phone),
                ),
                12.ph,
                PrimaryTextfield(
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  hintText: 'Password',
                  controller: password,
                  isPrefix: true,
                  isObscure: true,
                  isSuffix: true,
                  prefixWidget: const Icon(Icons.password),
                ),
                12.ph,
                PrimaryTextfield(
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Password is required';
                    }
                    if (p0 != password.text) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                  controller: confirmpassword,
                  hintText: 'Confirm Password',
                  isPrefix: true,
                  isObscure: true,
                  isSuffix: true,
                  prefixWidget: const Icon(Icons.password),
                ),
                20.ph,
                CustomButton(
                  isLoading: auth.isLoadingSignUp,
                  title: 'Register Account',
                  onPressed: () async {
                    final fcmToken =
                        await notificationServices.getDeviceToken();
                    if (formKey.currentState!.validate()) {
                      try {
                        auth.changeLoadingSignUp(true);
                        await firebaseService.signUpWithEmail(
                          fullname: fullName.text,
                          email: email.text,
                          phoneNo: phoneNo.text,
                          password: password.text,
                          profileImage:
                              'https://www.gravatar.com/avatar/cf5097eeafc3133fb5f7a54c0963e16e?s=64&d=robohash',
                          fcmToken: fcmToken,
                        );

                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Account created successfully!'),
                          duration: Duration(
                            seconds: 3,
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: AppColors.inactiveGray,
                        ));
                        AppRouterGo.pushReplacement(dashboardScreen);
                      } catch (e) {
                        auth.changeLoadingSignUp(false);
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
                // SizedBox(
                //   width: double.infinity,
                //   height: 50.h,
                //   child: ElevatedButton(

                //     child: const Text(
                //       "Register Account",
                //     ),
                //   ),
                // ),
                6.ph,
                TextButton(
                    onPressed: () => AppRouterGo.back(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        6.pw,
                        const Text(
                          'Sign In',
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
