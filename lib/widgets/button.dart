import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';

enum ButtonMode { text, outlined, contained }

class Button extends StatelessWidget {
  const Button({
    this.text="",
    this.onPressed,
    this.color,
    this.textColor,
    this.loaderColor,
    this.mode,
    this.loading,
    this.disabled,
    this.border,
  });

  final String text;
  final VoidCallback? onPressed;
  final ButtonMode? mode;
  final Color? color;
  final Color? textColor;
  final Color? loaderColor;
  final bool? loading;
  final bool? disabled;
  final BorderSide? border;

  @override
  Widget build(BuildContext context) {
    Widget loader = SizedBox(
      width: 18,
      height: 18,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(loaderColor ?? Colors.white),
      ),
    );

    if (mode == ButtonMode.outlined) {
      return OutlinedButton(
        onPressed: (disabled == true || loading == true) ? null : onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0))),
          elevation: MaterialStateProperty.all(0),
          side: MaterialStateProperty.all(
              BorderSide(color: color ?? Colors.white)),
          padding:
              MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20)),
        ),
        child: loading == true
            ? loader
            : Text(
                text,
                style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: AppFonts.Cabin,
                    color: textColor ?? color ?? Colors.white,
                    fontWeight: FontWeight.w700),
              ),
      );
    } else if (mode == ButtonMode.text) {
      return TextButton(
        onPressed: (disabled == true || loading == true) ? null : onPressed,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 17.0,
              fontFamily: AppFonts.Cabin,
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.w700),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: (disabled == true || loading == true) ? null : onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0))),
          elevation: MaterialStateProperty.all(0),
          backgroundColor:
              MaterialStateProperty.all(color ?? AppColors.blueColor),
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(
            vertical: 20,
          )),
        ),
        child: loading == true
            ? loader
            : Text(
                text,
                style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: AppFonts.Cabin,
                    color: textColor ?? Colors.white,
                    fontWeight: FontWeight.w700),
              ),
      );
    }
  }
}
