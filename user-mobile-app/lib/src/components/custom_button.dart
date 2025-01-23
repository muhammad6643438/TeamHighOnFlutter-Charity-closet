import 'package:charity_closet/constants.dart';
import 'package:charity_closet/src/core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final double? width;
  final VoidCallback? onPressed;
  final bool isLoading;

  const CustomButton({
    super.key,
    this.title,
    this.width,
    this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: CupertinoButton(
        color: AppColors.primaryGreen,
        onPressed: onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: AppColors.primaryWhite,
                ),
              )
            : Text(title ?? 'Login'),
      ),
    );
  }
}
