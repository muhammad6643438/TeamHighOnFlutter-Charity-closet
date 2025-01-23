import 'package:admin/constants.dart';
import 'package:flutter/cupertino.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final double? width;
  final VoidCallback? onPressed;

  const CustomButton({
    Key? key,
    this.title,
    this.width,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: CupertinoButton(
        child: Text(title ?? 'Login'),
        color: primaryColor,
        onPressed: onPressed,
      ),
    );
  }
}
