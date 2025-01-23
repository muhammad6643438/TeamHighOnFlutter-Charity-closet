import 'package:charity_closet/src/components/custom_button.dart';
import 'package:charity_closet/src/core/services/firebase%20service/firebase_service.dart';
import 'package:charity_closet/src/core/utils/app_colors.dart';
import 'package:charity_closet/src/core/utils/app_extensions.dart';
import 'package:charity_closet/src/core/utils/app_insets.dart';
import 'package:charity_closet/src/core/widgets/primary_textfield.dart';
import 'package:charity_closet/src/modules/authentication/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgotPasswordView extends HookConsumerWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(context, ref) {
    var auth = ref.watch(authController);

    TextEditingController email = useTextEditingController();

    FirebaseService firebaseService = FirebaseService();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
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
                  "Forgot Password",
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
                CustomButton(
                  isLoading: auth.isLoading,
                  title: 'Reset Password',
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      auth.changeLoading(true);
                      try {
                        firebaseService
                            .sendPasswordResetEmail(email.text, context)
                            .then(
                              (value) => auth.changeLoading(false),
                            );
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
