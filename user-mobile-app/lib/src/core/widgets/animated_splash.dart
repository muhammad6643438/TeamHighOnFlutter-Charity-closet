import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:undefeated_mobile/src/core/utils/app_colors.dart';
// import 'package:undefeated_mobile/src/core/utils/app_extensions.dart';

class AnimatedImage extends StatefulWidget {
  final String imagePath;
  final double initialScale;
  final int duration;
  final VoidCallback onInit, onAnimationComplete;

  const AnimatedImage({
    super.key,
    this.duration = 2,
    required this.onInit,
    this.initialScale = 1,
    required this.imagePath,
    required this.onAnimationComplete,
  });

  @override
  State<AnimatedImage> createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    widget.onInit();
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );
    _scaleAnimation = Tween<double>(
      begin: widget.initialScale,
      end: widget.initialScale * 2.25,
    ).animate(_animationController)
      ..addListener(() => setState(() {}));
    _animationController.forward().then((value) {
      if (_animationController.isCompleted) {
        widget.onAnimationComplete();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            widget.imagePath,
            // color: Colors.white,
            height: 140.sp,
            width: 140.sp,
            fit: BoxFit.contain,
          ),
          // 11.ph,
          // Text(
          //   'Undefeated',
          //   style: TextStyle(
          //       color: AppColors.pink,
          //       fontWeight: FontWeight.w900,
          //       fontSize: 30.sp),
          // ),
        ],
      ),
    );
  }
}
