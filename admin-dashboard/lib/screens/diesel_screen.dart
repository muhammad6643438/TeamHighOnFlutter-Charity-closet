import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';
import 'dashboard/components/header.dart';

class DieselScreen extends ConsumerWidget {
  @override
  Widget build(context, ref) {
    final Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(title: 'Diesel'),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      // MyFiles(),
                      SizedBox(height: defaultPadding),
                      // RecentFiles(),
                      AppSize(
                        mobile: DieselGridView(
                          crossAxisCount: _size.width < 650 ? 2 : 4,
                          childAspectRatio:
                              _size.width < 650 && _size.width > 350 ? 1.3 : 1,
                        ),
                        tablet: DieselGridView(),
                        desktop: DieselGridView(
                          childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
                        ),
                      ),
                      if (AppSize.isMobile(context))
                        SizedBox(height: defaultPadding),
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
