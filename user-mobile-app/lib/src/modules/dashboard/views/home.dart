// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:charity_closet/constants.dart';
import 'package:charity_closet/src/components/appointment_card.dart';
import 'package:charity_closet/src/components/custom_button.dart';
import 'package:charity_closet/src/components/info_card.dart';
import 'package:charity_closet/src/core/services/routing%20service/app_routes.dart';
import 'package:charity_closet/src/core/services/routing%20service/routing_service.dart';
import 'package:charity_closet/src/core/utils/app_assets.dart';
import 'package:charity_closet/src/core/utils/app_colors.dart';
import 'package:charity_closet/src/core/utils/app_extensions.dart';
import 'package:charity_closet/src/core/widgets/primary_textfield.dart';
import 'package:charity_closet/src/modules/authentication/controllers/auth_controller.dart';
import 'package:charity_closet/src/modules/authentication/views/login_view.dart';
import 'package:charity_closet/src/modules/dashboard/controllers/dashboad_controller.dart';
import 'package:charity_closet/src/modules/dashboard/views/donate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GeneralPhysicianHomePage extends ConsumerWidget {
  const GeneralPhysicianHomePage({super.key});

  @override
  Widget build(context, ref) {
    final auth = ref.watch(authController);
    auth.fetchUser();
    return Scaffold(
      body: Center(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Consumer(
              builder: (_, ref, child) {
                return ListView(
                  children: [
                    20.ph,
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10.sp),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome back,",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                (auth.userModel?.fullname ?? "")
                                    .capitalizeEachWord,
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryGreen,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () async {
                              AppRouterGo.pushRemoveUntil(loginScreen);
                              const FlutterSecureStorage().deleteAll();
                            },
                            icon: const Icon(Icons.logout),
                          ),
                        ],
                      ),
                    ),
                    10.ph,
                    Row(
                      children: [
                        Expanded(
                          child: InfoCard(
                            color: AppColors.errorRed.withOpacity(0.15),
                            title: 'Donations',
                            value: '5',
                            unit: 'Items',
                          ),
                        ),
                        10.pw,
                        Expanded(
                          child: InfoCard(
                            color: Colors.greenAccent.withOpacity(0.3),
                            title: 'Disposals',
                            value: '5',
                            unit: 'Items',
                          ),
                        ),
                      ],
                    ),
                    10.ph,
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return DonationBottomSheet();
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.sp),
                        decoration: BoxDecoration(
                          color: AppColors.peachBg,
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Donate Now",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                SizedBox.square(
                                  dimension: 40.sp,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://w7.pngwing.com/pngs/388/659/png-transparent-charity-icon.png',
                                  ),
                                ),
                              ],
                            ),
                            10.ph,
                            const Text(
                              "Who is it that would loan Allah a goodly loan so He may multiply it for him many times over? And it is Allah who withholds and grants abundance, and to Him you will be returned.",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    10.ph,
                    InkWell(
                      onTap: () {
                        AppRouterGo.push(complaintScreen);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.sp),
                        decoration: BoxDecoration(
                          color: AppColors.peachBg,
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Facing any issues?",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                SizedBox.square(
                                  dimension: 30.sp,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://cdn-icons-png.flaticon.com/512/9375/9375541.png',
                                  ),
                                ),
                              ],
                            ),
                            10.ph,
                            const Text(
                              "Complaints, Suggestions, Feedback all are welcome. We are here to help you.",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    10.ph,
                    Text(
                      "My Donations/ Disposals",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    10.ph,
                    // const Divider(color: Colors.grey),
                    ListView.separated(
                      itemCount: 1,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, i) {
                        return AppointmentCard(
                          onTap: () {
                            //  AppRouter.push(const AppointmentDetails());
                          },
                          title: (auth.userModel?.fullname ?? "")
                              .capitalizeEachWord,
                          desc: '2024-06-25',
                        );
                      },
                      separatorBuilder: (_, i) => 6.ph,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    super.key,
    this.color = primaryColor,
    required this.percentage,
  });

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
