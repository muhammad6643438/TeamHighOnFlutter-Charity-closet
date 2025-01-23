import 'package:charity_closet/src/core/utils/app_extensions.dart';
import 'package:charity_closet/src/core/utils/app_insets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProgramCard extends HookConsumerWidget {
  final String image;
  final String title;
  final String description;
  final bool isActive;
  final void Function(bool)? onChanged;

  const ProgramCard({
    super.key,
    this.onChanged,
    required this.image,
    required this.title,
    required this.description,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 20.h,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.grey.shade200,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: Image.asset(
                image,
                height: 150.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            8.ph,
            Padding(
              padding: AppInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Switch(
                    value: isActive,
                    onChanged: onChanged,
                  ),
                ],
              ),
            ),
            Padding(
              padding: AppInsets.symmetric(horizontal: 16),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            8.ph,
          ],
        ),
      ),
    );
  }
}
