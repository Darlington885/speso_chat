



import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../constants/image_assets.dart';
import '../screens/login_screen.dart';
import 'navigators.dart';


class LogOutDialog extends StatefulWidget {
  const LogOutDialog({Key? key}) : super(key: key);

  @override
  _LogOutDialogState createState() => _LogOutDialogState();
}

class _LogOutDialogState extends State<LogOutDialog> {
  @override
  Widget build(BuildContext context,) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: Container(
          height: 154,
          width: 327,
          decoration: BoxDecoration(
            color: Colors.white,
            //color: AppColors.containerFillColor3,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: 40,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Are you sure you want to LOG OUT?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontFamily:  AppFonts.Cabin,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        navigate(context, LoginScreen());
                      },
                      child: Container(
                        height: 44, width: 89,
                        decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Align(alignment: Alignment.center,
                          child: Text(
                            "Yes!",

                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontFamily:  AppFonts.Cabin,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 44, width: 89,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.blueColor),
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Align(alignment: Alignment.center,
                          child: Text(
                            "No, Cancel",
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontFamily:  AppFonts.Cabin,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],)

              ],
            ),
          ),
        ));
  }
}


class CustomPopupDialog extends StatefulWidget {


  final String title, description, buttonText;
  final String img;
  final VoidCallback onButtonPressed;

  const CustomPopupDialog({required this.title, required this.description, required this.buttonText, required this.img, required this.onButtonPressed});


  @override
  _CustomPopupDialogState createState() => _CustomPopupDialogState();
}

class _CustomPopupDialogState extends State<CustomPopupDialog> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  static const double padding = 20;
  static const double avatarRadius = 45;

  @override
  Widget build(BuildContext context) {


    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 400,
          width: 320,

          padding: EdgeInsets.only(left: padding,top: 5
              + padding, right: 10,bottom: padding
          ),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(padding),
              boxShadow: [
                BoxShadow(color: Colors.transparent,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),

          child: PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              SingleChildScrollView(
                child: Container(

                  padding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap:(){
                                popView(context);

                              },
                              child: Image.asset(assetImageCancel,color: AppColors.blueColor.withOpacity(0.6), height: 32, width: 32)),
                          SizedBox(
                            width: 5,
                          ),

                        ],
                      ),

                      SizedBox(height: 10.0),
                      Image.asset(
                        widget.img,
                        width: 74,
                        height: 74,
                        // color: Colors.black,
                        // colorBlendMode: BlendMode.color,
                      ),
                      SizedBox(height: 0.0),
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontFamily: AppFonts.Cabin,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.description,
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: AppFonts.Cabin,
                                fontSize: 14.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          InkWell(
                            onTap: widget.onButtonPressed,
                            child: Container(
                              width: 140,
                              decoration: BoxDecoration(
                                color: AppColors.blueColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Center(
                                  child: Text(
                                    widget.buttonText,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: AppFonts.Cabin,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Button(
                          //   text: 'See whats new',
                          //   color: AppColors.primaryColor,
                          //   textColor: Colors.white,
                          //   onPressed: () {
                          //     Navigator.of(context).pop();
                          //   },
                          // ),
                          //
                          // Button(
                          //   text: 'Proceed to Dashboard',
                          //   color: AppColors.primaryColor,
                          //   textColor: Colors.white,
                          //   onPressed: () {
                          //     Navigator.of(context).pop();
                          //   },
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // InkWell(
                          //   onTap: () {
                          //
                          //   },
                          //   child: Text(
                          //     'Proceed to Dashboard',
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(
                          //         color: secondaryColor,
                          //         fontFamily: AppFonts.Arial,
                          //         fontWeight: FontWeight.w700,
                          //         fontSize: 18.0,
                          //         decoration: TextDecoration.underline),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 20.0,
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Positioned(
        //   // top: 3,
        //   left: padding,
        //   right: padding,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.transparent,
        //     radius: avatarRadius,
        //     child: ClipRRect(
        //         borderRadius: BorderRadius.all(Radius.circular(avatarRadius)),
        //         child: Image.asset('assets/images/confetti.png',)
        //       // Image.asset(widget.img)
        //     ),
        //   ),
        // ),
      ],
    );
  }
}







openDialog(Widget widget, BuildContext context, {barrierDismissible = false,}) {
  showDialog(
    useRootNavigator: false,
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return widget;
      });
}

void showCustomDialog(BuildContext context, String title,  String? message) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext cxt) {
      return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
            child: Material(
               color: Colors.white,
              shape: Border(
                left: BorderSide(
                    width: 4,
                    //color: Color(0xFFE2494E).withOpacity(0.1),
                    color: AppColors.inactiveColor,
                ),

              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            //color: AppColors.whiteColor,
                            color: AppColors.blackColor,
                            fontFamily: AppFonts.Cabin,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
                        ),

                        Spacer(),

                        InkWell(
                            onTap:(){
                              Navigator.of(cxt).pop();

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                //color: Color(0xFFE2494E).withOpacity(0.1),
                                //color: Color(0xFFFFFFFF),
                                color: AppColors.inactiveColor.withOpacity(0.3)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(Icons.close, size: 20, color: AppColors.blueColor.withOpacity(0.5) ),
                              ),
                            )
                          //Image.asset(assetImageCancel, height: 32, width: 32,),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),


                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            message ?? "",

                            style: TextStyle(
                              color: AppColors.blackColor.withOpacity(0.7),
                              fontWeight: FontWeight.w700,
                              fontFamily: AppFonts.Cabin,
                              fontSize: 12.0,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

// void showCustomSuccessDialog(BuildContext context, String title,  String message) {
//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (BuildContext cxt) {
//       Future.delayed(Duration(seconds: 4), () {
//         Navigator.of(cxt).pop(true);
//       });
//       return Align(
//         alignment: Alignment.topCenter,
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: ClipRRect(
//             borderRadius: const BorderRadius.only(
//               topRight: Radius.circular(14),
//               bottomRight: Radius.circular(14),
//             ),
//             child: Material(
//               color: AppColors.blackColor,
//               // color: Colors.white,
//               shape: Border(
//                 left: BorderSide(
//                   width: 4,
//                   //color: Color(0xFFE2494E).withOpacity(0.1),
//                   //color: AppColors.primarySecondaryColor,
//                   color: AppColors.inactiveColor,
//                 ),
//
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           title,
//                           textAlign: TextAlign.start,
//                           style: TextStyle(
//                             color: AppColors.whiteColor,
//                             fontFamily: AppFonts.Cabin,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 14.0,
//                           ),
//                         ),
//
//                         Spacer(),
//
//                         InkWell(
//                             onTap:(){
//                               Navigator.of(cxt).pop();
//
//                             },
//                             child: Image.asset(assetImageCancel, height: 32, width: 32,)),
//                         SizedBox(
//                           width: 5,
//                         ),
//                       ],
//                     ),
//
//
//                     SizedBox(height: 8.0),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Text(
//                             message ?? "",
//
//                             style: TextStyle(
//                               color: AppColors.whiteColor,
//                               fontWeight: FontWeight.w700,
//                               fontFamily: AppFonts.Cabin,
//                               fontSize: 12.0,
//                             ),
//                             textAlign: TextAlign.start,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }