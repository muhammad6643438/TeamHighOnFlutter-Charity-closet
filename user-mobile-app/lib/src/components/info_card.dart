import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoCard extends StatelessWidget {
  final String? title, unit, value;
  final Color? color;
  final VoidCallback? onTap;

  const InfoCard({
    super.key,
    this.color,
    this.title,
    this.unit,
    this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 100.h,
          minHeight: 100.h,
        ),
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          color: color ?? Colors.grey,
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  value ?? "12400",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  " ${unit ?? "PKR"}",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Text(
              title ?? "Total Sales",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
