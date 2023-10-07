import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speso_chat_app/constants/colors.dart';

import '../constants/fonts.dart';

InputDecoration getInputDecoration({
  @required String? label,
  String? hint,
  bool? error,
  Widget? suffixIcon,
  Widget? prefixIcon,
  Color? color,
  Color? focusedColor,
}) {
  return InputDecoration(
    suffixIcon: suffixIcon,
    prefixIcon: prefixIcon,
    labelText: label,
    hintText: hint,
    contentPadding: EdgeInsets.all(20.0),

    labelStyle: TextStyle(
      fontSize: 15.0,
      fontFamily: AppFonts.Cabin,
      color: error == true ? AppColors.redColor : color,
    ),
    hintStyle: TextStyle(
        fontSize: 16.0,
        color: AppColors.textColor.withOpacity(0.25),
        fontFamily: AppFonts.Cabin,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal),
    // color: error == true
    //       ? AppColors.redColor
    //       : (focusedColor ?? AppColors.textColor), fontFamily: AppFonts.Cabin, fontWeight: FontWeight.w400),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: error == true
              ? AppColors.redColor
              : (color ?? AppColors.blackColor),
        )),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: error == true
              ? AppColors.redColor
              : (focusedColor ?? AppColors.hintColor),
        )),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(
        color: focusedColor ?? AppColors.hintColor,
        width: 1.5,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(
        color: focusedColor ?? AppColors.hintColor,
        width: 1.5,
      ),
    ),
  );
}

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      this.label,
      this.controller,
      FocusNode? node,
      this.type,
      this.hint,
      this.color,
      this.focusedColor,
      this.maxLines,
      this.maxLength,
      this.obscureText,
      this.error,
      this.onChanged,
      this.validator,
      this.inputFormatter,
      this.textInputAction,
      this.hintColor,
      this.textColor,
      this.message,
      this.suffixIcon,
      this.prefixIcon,
      this.enabled,
      this.initialValue,
      this.height})
      : _node = node,
        super(key: key);

  final TextEditingController? controller;
  final FocusNode? _node;
  final TextInputType? type;
  final List<TextInputFormatter>? inputFormatter;
  final String? initialValue;
  final String? label;
  final String? hint;
  final String? message;
  final bool? obscureText;
  final bool? enabled;
  final bool? error;
  final int? maxLines;
  final int? maxLength;
  final int? height;

  /// The color of the border
  final Color? color;

  /// The color of the border and label when the input is focused
  final Color? focusedColor;

  /// The color of the hint text
  final Color? hintColor;

  /// The color of the input value
  final Color? textColor;

  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final String Function(String?)? validator;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          enabled: enabled ?? true,
          initialValue: initialValue,
          maxLines: maxLines ?? 1,
          controller: controller,
          focusNode: _node,
          textCapitalization: TextCapitalization.words,
          inputFormatters: inputFormatter,
          textInputAction: textInputAction ?? TextInputAction.next,
          autocorrect: false,
          keyboardType: type,
          obscureText: obscureText ?? false,
          onChanged: onChanged,
          validator: validator,
          style: TextStyle(
            fontSize: 16.0,
            fontFamily: AppFonts.Cabin,
            fontWeight: FontWeight.w400,
            color: textColor ?? AppColors.blackColor,
          ),
          maxLength: maxLength,
          decoration: getInputDecoration(
              label: label,
              color: color,
              error: error,
              focusedColor: focusedColor,
              hint: hint,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon),
        ),
        Padding(
          //padding: EdgeInsets.only(top: 5, bottom: 10, left: 2),
          padding: EdgeInsets.only(top: 0, bottom: 0, left: 2),
          child: Text(
            message ?? '',
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: AppFonts.Cabin,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              color: error == true ? AppColors.redColor : AppColors.redColor,
            ),
          ),
        ),
      ],
    );
  }
}

//
InputDecoration getInputDecorationTwo({
  @required String? label,
  String? hint,
  bool? error,
  Widget? suffixIcon,
  Widget? prefixIcon,
  Color? color,
  Color? focusedColor,
}) {
  return InputDecoration(
    suffixIcon: suffixIcon,
    prefixIcon: prefixIcon,
    labelText: label,
    hintText: hint,
    //contentPadding: EdgeInsets.all(20.0),

    labelStyle: TextStyle(
      fontSize: 14.0,
      color: error == true ? AppColors.redColor : color,
      fontFamily: AppFonts.Cabin,
      fontWeight: FontWeight.w500,
    ),
    hintStyle: TextStyle(
        fontSize: 14.0,
        color: error == true
            ? AppColors.redColor
            : (focusedColor ?? AppColors.hintColor),
        fontFamily: AppFonts.Cabin),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          width: 1.0,
          color: error == true
              ? AppColors.redColor
              : (color ?? AppColors.blackColor),
        )),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(
          width: 1.0,
          color: error == true
              ? AppColors.redColor
              : (focusedColor ?? AppColors.blackColor),
        )),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: focusedColor ?? AppColors.blackColor,
        width: 1.0,
      ),
    ),
  );
}

// class InputFieldTwo extends StatelessWidget {
//   const InputFieldTwo({
//     required Key key,
//     required this.label,
//     required this.controller,
//     required FocusNode node,
//     required this.type,
//     required this.hint,
//     required this.color,
//     required this.focusedColor,
//     required this.maxLines,
//     required this.maxLength,
//     required this.obscureText,
//     required this.error,
//     required this.onChanged,
//     required this.validator,
//     required this.textInputAction,
//     required this.hintColor,
//     required this.textColor,
//     required this.message,
//     required this.suffixIcon,
//     required this.prefixIcon,
//     required this.enabled
//
//   })  : _node = node,
//         super(key: key);
//
//   final TextEditingController controller;
//   final FocusNode _node;
//   final TextInputType type;
//
//   final String label;
//   final String hint;
//   final String message;
//   final bool obscureText;
//   final bool enabled;
//   final bool error;
//   final int maxLines;
//   final int maxLength;
//
//
//   /// The color of the border
//   final Color color;
//
//   /// The color of the border and label when the input is focused
//   final Color focusedColor;
//
//   /// The color of the hint text
//   final Color hintColor;
//
//   /// The color of the input value
//   final Color textColor;
//
//   final TextInputAction textInputAction;
//   final Function(String) onChanged;
//   final String Function(String?)? validator;
//
//   final Widget prefixIcon;
//   final Widget suffixIcon;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         TextFormField(
//           enabled: enabled?? true,
//
//           maxLines: maxLines ?? 1,
//           controller: controller,
//           focusNode: _node,
//           textCapitalization: TextCapitalization.words,
//           textInputAction: textInputAction ?? TextInputAction.next,
//           autocorrect: false,
//           keyboardType: type,
//           obscureText: obscureText ?? false,
//           onChanged: onChanged,
//           validator: validator,
//
//           style: TextStyle(
//             fontSize: 14.0,
//
//             color: textColor ?? AppColors.blackColor,
//           ),
//           maxLength: maxLength,
//
//           decoration: getInputDecorationTwo(
//               label: label,
//               color: color,
//               error: error,
//               focusedColor: focusedColor,
//               hint: hint,
//               prefixIcon: prefixIcon,
//
//
//               suffixIcon: suffixIcon),
//
//
//         ),
//         Padding(
//           padding: EdgeInsets.only(top: 5, bottom: 10),
//           child: Text(
//             message ?? '',
//             style: TextStyle(
//               fontSize: 12.0,
//               fontFamily: AppFonts.Cabin,
//               color: error == true ? AppColors.redColor : AppColors.redColor,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
