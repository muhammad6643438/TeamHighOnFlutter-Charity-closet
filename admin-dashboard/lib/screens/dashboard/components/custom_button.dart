import 'package:admin/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final double? width;
  final bool loading;
  final VoidCallback? onPressed;

  const CustomButton({
    Key? key,
    this.title,
    this.width,
    this.loading = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: CupertinoButton(
        child: !loading
            ? Text(title ?? 'Login')
            : SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(),
              ),
        color: primaryColor,
        onPressed: onPressed,
      ),
    );
  }
}
