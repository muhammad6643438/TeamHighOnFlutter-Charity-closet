// ignore_for_file: unrelated_type_equality_checks

import 'package:charity_closet/src/core/utils/app_colors.dart';
import 'package:charity_closet/src/core/utils/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String? title, desc, by;
  final DateTime? date;
  final bool? isAdmin;
  final VoidCallback? onTap;

  const AppointmentCard({
    super.key,
    this.title,
    this.desc,
    this.date,
    this.by,
    this.isAdmin = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          left: AppSize.paddingLeft / 8,
          right: AppSize.paddingRight / 8,
        ),
        padding: EdgeInsets.only(
          left: AppSize.paddingLeft,
          right: AppSize.paddingRight,
          top: AppSize.paddingTop,
          bottom: AppSize.paddingBottom,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.base,
          boxShadow: [
            BoxShadow(
              color: AppColors.dividerColor.withOpacity(0.3),
              offset: const Offset(0.0, 2.0),
              blurRadius: 6.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // _topBar(isAdmin, onDelete),
                Text(
                  title ?? "Title",
                  // alignment: Alignment.centerLeft,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppSize.paddingTop / 2),
                Text(
                  desc ?? "Description",
                  // alignment: Alignment.centerLeft,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.subtitle,
                  ),
                ),
                // SizedBox(height: AppSize.paddingTop),
                // const Divider(height: 1, color: AppColors.dividerColor),
                // 8.ph,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     PrimaryButton(
                //       text: "Details",
                //       onTap: () {},
                //       borderRadius: 30,
                //       width: AppSize.screenWidth / 8,
                //     ),
                //     4.pw,
                //     PrimaryButton(
                //       text: "Join",
                //       onTap: () {},
                //       borderRadius: 30,
                //       width: AppSize.screenWidth / 8,
                //     ),
                //   ],
                // ),
              ],
            ),
            // const Icon(CupertinoIcons.forward, color: AppColors.subtitle),
          ],
        ),
      ),
    );
  }

  // _topBar(bool? isAdmin, VoidCallback? onDelete) {
  //   if (isAdmin == true) {
  //     return Row(
  //       children: [
  //         Expanded(
  //           child: CustomText(
  //             title ?? "Title",
  //             alignment: Alignment.centerLeft,
  //             textStyle: AppTextStyles.middleBlackBoldTextStyle,
  //           ),
  //         ),
  //         IconButton(
  //           onPressed: onDelete,
  //           color: AppColors.errorRed,
  //           icon: const Icon(CupertinoIcons.delete),
  //         ),
  //       ],
  //     );
  //   } else {
  //     return CustomText(
  //       title ?? "Title",
  //       alignment: Alignment.centerLeft,
  //       textStyle: AppTextStyles.middleBlackBoldTextStyle,
  //     );
  //   }
  // }
}
