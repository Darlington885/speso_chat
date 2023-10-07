import 'package:flutter/material.dart';

import 'colors.dart';
import 'fonts.dart';

const kSmallTextStyle =  TextStyle(
    color: AppColors.blackColor,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.Cabin,
    fontStyle: FontStyle.normal);

const kLargeTextStyle =  TextStyle(
    color: AppColors.blackColor,
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    fontFamily: AppFonts.Cabin);

const kDecorationStyle =  BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(30.0),
    topRight: Radius.circular(30.0),
  ),
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  //border: InputBorder.none,
);



const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: AppColors.blueColor, width: 2.0),
  ),
);

const kSendButtonTextStyle = TextStyle(
  color: AppColors.blueColor,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);