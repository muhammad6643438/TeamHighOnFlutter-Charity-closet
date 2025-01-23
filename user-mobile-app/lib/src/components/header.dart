import 'package:charity_closet/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchField extends StatelessWidget {
  final bool? showIcon, isLast;
  final double? width;
  final String? title;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;

  const SearchField({
    super.key,
    this.title,
    this.width,
    this.isLast,
    this.showIcon,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction:
            isLast == true ? TextInputAction.done : TextInputAction.next,
        decoration: InputDecoration(
          hintText: title ?? "Search",
          fillColor: secondaryColor,
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: showIcon == true
              ? InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(defaultPadding * 0.75),
                    margin: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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
