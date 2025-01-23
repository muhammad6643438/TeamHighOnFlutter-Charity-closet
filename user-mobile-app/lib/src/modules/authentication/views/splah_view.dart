import 'package:charity_closet/src/core/services/notification_service/notification_service.dart';
import 'package:charity_closet/src/core/utils/app_assets.dart';
import 'package:charity_closet/src/core/widgets/animated_splash.dart';
import 'package:charity_closet/src/modules/authentication/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  NotificationServices notificationServices = NotificationServices();
  void splashInit() async {
    notificationServices.requestNotificationsPermission();
    notificationServices.firebaseInit(context);
    notificationServices.getDeviceToken().then((value) {
      debugPrint('Device Token: $value');
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        splashInit();
      },
    );
  }

  @override
  Widget build(context) {
    final auth = ref.watch(authController);
    return Scaffold(
      body: Center(
        child: AnimatedImage(
          onInit: () async {},
          initialScale: 0.7,
          imagePath: AppAssets.charityLogo,
          onAnimationComplete: auth.onAnimationCompleted, // decisions here
        ),
      ),
    );
  }
}
