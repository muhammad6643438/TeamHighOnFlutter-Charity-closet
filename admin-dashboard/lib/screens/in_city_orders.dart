import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';
import 'dashboard/components/header.dart';

class Brand extends ConsumerWidget {
  @override
  Widget build(context, ref) {
    final Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(title: 'In City Orders'),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      SizedBox(height: defaultPadding),
                      AppSize(
                        mobile: InCityOrdersGridView(
                          crossAxisCount: _size.width < 650 ? 2 : 4,
                          childAspectRatio:
                              _size.width < 650 && _size.width > 350 ? 1.3 : 1,
                        ),
                        tablet: InCityOrdersGridView(),
                        desktop: InCityOrdersGridView(
                          childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
                        ),
                      ),
                      SizedBox(height: defaultPadding),
                      RecentFiles(),
                      // if (Responsive.isMobile(context)) StorageDetails(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
