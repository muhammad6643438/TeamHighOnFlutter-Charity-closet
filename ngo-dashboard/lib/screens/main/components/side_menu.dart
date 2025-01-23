import 'package:admin/controllers/menu_controller.dart';
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
            child: Image.asset("assets/images/logo.png"),
          ),
          _DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            selected: menu.isDashboard,
            onTap: menu.onDashboard,
          ),
          _DrawerListTile(
            title: "In City Orders",
            svgSrc: "assets/icons/menu_doc.svg",
            selected: menu.isInCity,
            onTap: menu.onInCity,
          ),
          _DrawerListTile(
            title: "Out City Orders",
            svgSrc: "assets/icons/menu_doc.svg",
            selected: menu.isOutCity,
            onTap: menu.onOutCity,
          ),
          _DrawerListTile(
            title: "Vessel Orders",
            svgSrc: "assets/icons/menu_doc.svg",
            selected: menu.isVessel,
            onTap: menu.onVessel,
          ),
          _DrawerListTile(
            title: "Diesel",
            svgSrc: "assets/icons/menu_doc.svg",
            selected: menu.isDiesel,
            onTap: menu.onBillings,
          ),
          _DrawerListTile(
            title: "Register Client",
            svgSrc: "assets/icons/menu_profile.svg",
            selected: menu.isRegister,
            onTap: menu.onProfile,
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
    required this.svgSrc,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: selected ? Colors.white : Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.white : Colors.white54,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
