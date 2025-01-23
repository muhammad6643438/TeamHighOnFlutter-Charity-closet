import 'dart:async';
import 'package:charity_closet/constants.dart';
import 'package:charity_closet/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class PrimaryTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLength;
  bool isObscure;
  final bool isPrefix;
  final bool isSuffix;
  final bool isButtonSuffix;
  final Widget? suffixbutton;
  final int? minLines;
  final VoidCallback? onTapSuffix;
  final TextInputType textInputType;
  final TextAlign textAlign;
  final String? suffixIcon;
  final int? maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final bool focus;
  final bool? enabled;
  final OutlineInputBorder? inputBorder;
  void Function(String)? onFieldSubmitted;
  final bool enableInteractiveSelection;
  final bool removeSpacing;
  final Color? fillColor;
  final Widget? prefixWidget;
  final TextStyle? hintTextStyle;
  final Color? enableBorderColor;
  final TextCapitalization textCapitalization;
  final String? initialValue;
  final String? labelText;

  PrimaryTextfield({
    super.key,
    this.onFieldSubmitted,
    this.controller,
    this.hintText,
    this.isObscure = false,
    this.isSuffix = false,
    this.isPrefix = false,
    this.onTapSuffix,
    this.textInputType = TextInputType.text,
    this.suffixIcon,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.focus = false,
    this.onChanged,
    this.validator,
    this.inputBorder,
    this.maxLength,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.onEditingComplete,
    this.enabled,
    this.enableInteractiveSelection = true,
    this.removeSpacing = false,
    this.fillColor,
    this.prefixWidget,
    this.hintTextStyle,
    this.enableBorderColor,
    this.isButtonSuffix = false,
    this.textCapitalization = TextCapitalization.none,
    this.suffixbutton,
    this.minLines,
    this.initialValue,
    this.labelText,
  });

  @override
  State<PrimaryTextfield> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<PrimaryTextfield> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    if (widget.removeSpacing) {
      widget.controller?.addListener(removeSpaces);
    }
  }

  void removeSpaces() {
    String? text = widget.controller?.text;
    if (text!.contains(' ')) {
      // Cancel any previous timer to avoid multiple triggers
      _timer?.cancel();

      // Start a new timer with a brief delay
      _timer = Timer(const Duration(milliseconds: 500), () {
        // Remove spaces and update text
        widget.controller?.text = text.replaceAll(' ', '');
        // Move cursor to the end of the text
        widget.controller?.selection = TextSelection.fromPosition(
          TextPosition(offset: widget.controller!.text.length),
        );
      });
    }
  }

  @override
  void dispose() {
    if (widget.removeSpacing) {
      widget.controller?.removeListener(removeSpaces);
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      minLines: widget.minLines,

      enableInteractiveSelection: widget
          .enableInteractiveSelection, // For copy & Paste OPtion Enable and Disable
      contextMenuBuilder: widget.enableInteractiveSelection
          ? (context, editableTextState) {
              return AdaptiveTextSelectionToolbar.editableText(
                editableTextState: editableTextState,
              );
            }
          : (context, editableTextState) {
              return const SizedBox.shrink();
            },
      onFieldSubmitted: widget.onFieldSubmitted,
      textCapitalization: widget.textCapitalization,
      enabled: widget.enabled,
      textInputAction: TextInputAction.next,
      onTap: widget.onTap,
      onChanged: widget.onChanged,

      onEditingComplete: widget.onEditingComplete,
      keyboardType: widget.textInputType,
      enableSuggestions: false,
      focusNode: widget.focusNode,
      autocorrect: false,
      readOnly: widget.readOnly,
      controller: widget.controller,
      textAlign: widget.textAlign,
      maxLength: widget.maxLength,
      cursorColor: const Color.fromRGBO(32, 32, 32, 1),
      //  style: AppTextTheme.bodyLabelBlack,
      obscureText: widget.isObscure,
      maxLines: widget.maxLines,

      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          labelText: widget.labelText,
          // errorMaxLines: 6,
          prefixIcon: widget.isPrefix ? widget.prefixWidget : null,
          isDense: true,
          counterText: "",
          filled: true,
          suffixIcon: widget.isSuffix
              ? IconButton(
                  splashRadius: 25.r,
                  //   onPressed: widget.onTapSuffix,
                  onPressed: () {
                    setState(() {
                      widget.isObscure = !widget.isObscure;
                    });
                  },
                  icon: widget.suffixIcon == null
                      ? Icon(
                          !widget.isObscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 18,
                        )
                      : SvgPicture.asset(widget.suffixIcon!),
                )
              : widget.isButtonSuffix
                  ? widget.suffixbutton ??
                      // Padding(
                      //   padding: AppInsets.only(right: 10.0, top: 2, bottom: 2),
                      //   child: SecondryOutlinedButton(
                      //     buttonWidth: 87.w,
                      //     buttonHeight: 0,
                      //     // textColor: AppColors.doveGrey,
                      //     // borderColor: AppColors.softPeach,
                      //     // backgroundColor: AppColors.softPeach,
                      //     buttonText: 'Apply',
                      //   ),
                      // )
                      const SizedBox.shrink()
                  : null,
          fillColor: widget.fillColor ?? Colors.white,
          contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 25),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.focus
                  ? primaryColor
                  : widget.enableBorderColor ?? AppColors.inactiveGray,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.focus ? primaryColor : primaryColor,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          errorBorder: widget.inputBorder ??
              OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.focus ? primaryColor : AppColors.eventRed,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
          border: widget.inputBorder ??
              OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.focus ? primaryColor : AppColors.secondryWhite,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
          hintText: widget.hintText ?? '',
          hintStyle: TextStyle(
              fontFamily: 'Intro', fontSize: 16.sp, fontWeight: FontWeight.w400)
          // hintStyle: widget.hintTextStyle ??
          //     context.titleMediumStyle?.copyWith(color: AppColors.hitGrey),
          ),
    );
  }
}
