import 'package:admin/controllers/menu_controller.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/side_menu.dart';

class MainScreen extends ConsumerWidget {
  @override
  Widget build(context, ref) {
    var menu = ref.watch(menuViewModel);
    return Scaffold(
      key: menu.scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (AppSize.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: menu.currentScreen,
            ),
          ],
        ),
      ),
    );
  }
}
