import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSize {
  static double screenWidth = ScreenUtil().screenWidth;
  static double screenHeight = ScreenUtil().screenHeight;

  static bool get isMobile => screenWidth < 800.0;

  static bool get isTablet => screenWidth >= 800.0 && screenWidth < 1200.0;

  static bool get isDesktop => screenWidth >= 1200.0;

  static double maxWidth = double.infinity;
  static double appBarElevation = 20.sp;
  static double widgetElevation = 10.sp;
  static double containerWidth = 50.w;
  static double containerHeight = 55.w;
  static double cardWidth = 42.w;
  static double cardHeight = 42.w;
  static double imageWidth = 45.sp;
  static double imageHeight = 45.sp;
  static double imageScale = 0.8;
  static double tapPadding = 10.sp;
  static double paddingAll = 20.sp;
  static double paddingLeft = 15.sp;
  static double paddingRight = 15.sp;
  static double paddingTop = 15.sp;
  static double paddingBottom = 15.sp;
  static double dividerThickness = 10.sp;
  static double headSize = isMobile ? 18.sp : 14.sp;
  static double buttonTextSize = isMobile ? 18.sp : 12.sp;
  static double textSize = isMobile ? 15.sp : 12.sp;
  static double middleSize = isMobile ? 18.sp : 10.sp;
  static double iconSize = isMobile ? 20.sp : 16.sp;
  static double buttonBorder = 12.sp;
  static double fieldBorder = 12.sp;
  static double borderRadius = isMobile ? 15.sp : 8.sp;
  static double logoHeight = 50.sp;
  static double logoWidth = 50.sp;
  static double buttonHeight = isMobile ? 36.sp : 24.sp;
  static double buttonWidth = isMobile ? 36.sp : 24.sp;
}
