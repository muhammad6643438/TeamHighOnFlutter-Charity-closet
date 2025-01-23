import 'package:admin/constants.dart';
import 'package:admin/controllers/menu_controller.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends ConsumerWidget {
  final String? title;

  const Header({
    this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(context, ref) {
    var menu = ref.watch(menuViewModel);
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!AppSize.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: menu.controlMenu,
          ),
        if (!AppSize.isMobile(context))
          Text(
            title ?? "Dashboard",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        // if (!AppSize.isMobile(context))
        //   Spacer(flex: AppSize.isDesktop(context) ? 2 : 1),
        // Expanded(child: OrderTextField(showIcon: true)),
        // MyDropdownMenu(),
      ],
    );
  }
}

class MyDropdownMenu extends StatefulWidget {
  @override
  _MyDropdownMenuState createState() => _MyDropdownMenuState();
}

class _MyDropdownMenuState extends State<MyDropdownMenu> {
  // Define a list of items for the dropdown menu
  static List<String> _items = ['Muhammad Imran', 'Hamza Sadiq', 'Usman Ali'];

  // Define a variable to keep track of the selected item
  static String _selectedItem = _items.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        // Set border radius here
        color: Color(0xFF2A2D3E),
      ),
      child: Center(
        child: DropdownButton<String>(
          value: _selectedItem,
          dropdownColor: Color(0xFF2A2D3E),
          underline: SizedBox.shrink(),
          style: TextStyle(color: Colors.white),
          onChanged: (newValue) {
            setState(() {
              _selectedItem = newValue!;
            });
          },
          items: _items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final VoidCallback? onTap;

  const ProfileCard({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: defaultPadding),
        padding: EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/images/profile_pic.png",
              height: 38,
            ),
            if (!AppSize.isMobile(context))
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: Text("Angelina Jolie"),
              ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  final bool? showIcon, isLast;
  final double? width;
  final String? title;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final bool obscureText;

  const SearchField({
    Key? key,
    this.title,
    this.width,
    this.isLast,
    this.showIcon,
    this.validator,
    this.controller,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction:
            isLast == true ? TextInputAction.done : TextInputAction.next,
        decoration: InputDecoration(
          hintText: title ?? "Search",
          fillColor: secondaryColor,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: showIcon == true
              ? InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(defaultPadding * 0.75),
                    margin:
                        EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: SvgPicture.asset("assets/icons/Search.svg"),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class OrderTextField extends StatelessWidget {
  final bool? showIcon;
  final String? title;
  final TextEditingController? controller;

  const OrderTextField({
    Key? key,
    this.title,
    this.showIcon,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return SearchField(
      controller: controller,
      title: title,
      width: w / 5,
    );
  }
}
