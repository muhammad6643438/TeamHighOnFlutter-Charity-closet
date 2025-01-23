import 'package:admin/controllers/menu_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          _DrawerListTile(
            title: "Dashboard",
            icon: Icons.dashboard,
            selected: menu.isDashboard,
            onTap: menu.onDashboard,
          ),
          _DrawerListTile(
            title: "NGOs",
            icon: CupertinoIcons.home,
            selected: menu.isNgo,
            onTap: menu.onNgo,
          ),
          _DrawerListTile(
            title: "Brand",
            icon: CupertinoIcons.tag_fill,
            selected: menu.isBrand,
            onTap: menu.onBrand,
          ),
          _DrawerListTile(
            title: "Notifications",
            icon: CupertinoIcons.bell_fill,
            selected: menu.isNotifications,
            onTap: menu.onNotifications,
          ),
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
