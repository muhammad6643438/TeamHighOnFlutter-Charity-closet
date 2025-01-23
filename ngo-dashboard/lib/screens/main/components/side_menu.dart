// ignore_for_file: deprecated_member_use

import 'package:admin/controllers/menu_controller.dart';
import 'package:admin/core/app_router.dart';
import 'package:admin/screens/login_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(context, ref) {
    var menu = ref.watch(menuViewModel);
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/icons/charity-closet.png"),
          ),
          // _DrawerListTile(
          //   title: "Dashboard",
          //   icon: Icons.dashboard,
          //   selected: menu.isDashboard,
          //   onTap: menu.onDashboard,
          // ),
          // _DrawerListTile(
          //   title: "Dashboard",
          //   icon: CupertinoIcons.home,
          //   selected: menu.isNgo,
          //   onTap: menu.onNgo,
          // ),
          // _DrawerListTile(
          //   title: "Brand",
          //   icon: CupertinoIcons.bitcoin,
          //   selected: menu.isBrand,
          //   onTap: menu.onBrand,
          // ),
          // _DrawerListTile(
          //   title: "Complaints",
          //   icon: CupertinoIcons.tag,
          //   selected: menu.isComplaint,
          //   onTap: menu.onComplaints,
          // ),
          // _DrawerListTile(
          //   title: "Users",
          //   icon: CupertinoIcons.person_2,
          //   selected: menu.isUsers,
          //   onTap: menu.onUsers,
          // ),
          _DrawerListTile(
            title: "Donations",
            icon: Icons.card_giftcard,
            selected: menu.isDonations,
            onTap: menu.onDonations,
          ),
          // SizedBox(
          //   height: 300,
          // ),
          // _DrawerListTile(
          //   title: "Logout",
          //   icon: Icons.logout,
          //   selected: menu.isDonations,
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => MainScreen(),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}

class _DrawerListTile extends StatelessWidget {
  const _DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.icon,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        color: selected ? Colors.white : Colors.white54,
        size: 16,
      ),
      title: Text(
        " " + title,
        style: TextStyle(
          color: selected ? Colors.white : Colors.white54,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
