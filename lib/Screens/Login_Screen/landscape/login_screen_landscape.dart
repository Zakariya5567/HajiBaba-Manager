import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haji_baba_manager/Provider/login_provider.dart';
import 'package:haji_baba_manager/Utils/const_style.dart';
import 'package:haji_baba_manager/Utils/const_text.dart';
import 'package:haji_baba_manager/Utils/images.dart';
import 'package:provider/provider.dart';



class LandscapeLoginScreen extends StatelessWidget {
  const LandscapeLoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider=Provider.of<LoginProvider>(context,listen: false);
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                //This image is a background image of the login Screen
                image: AssetImage(ConstImages.loginBackgroundImage)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // this column is used for the welcome text and login button
              // sized box are used for the space between text and button
              //welcome text
              Text(
                ConstText.welcomeText,
                style: styleText(),
              ),
              SizedBox(
                height: 30.h,
              ),
              // haji baba halal meat text
              Text(
                ConstText.hajiBabaText,
                style: styleText(),
              ),
              SizedBox(
                height: 30.h,
              ),
              // counter text
              Text(
                ConstText.counterText,
                style: styleText(),
              ),
              SizedBox(height: 180.h),
              //login button
              MaterialButton(
                minWidth: 450.w,
                height: 190.h,
                color: ConstStyle.logButtonColor,
                onPressed: () async {
                  Navigator.of(context).pushNamed('/loginFormScreen');
                },
                child: Text(
                  ConstText.loginButtonText,
                  style: TextStyle(
                      color: ConstStyle.textWhiteColor,
                      fontSize: 100.sp,
                      fontWeight: FontWeight.w500),
                ),
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              ),
              SizedBox(
                height: 100.h,
              ),
              //forget password textButton
              TextButton(
                  onPressed: () {},
                  child: Column(
                    children: [
                      Text(
                        ConstText.forgotPasswordText,
                        style: TextStyle(
                          color: ConstStyle.textWhiteColor,
                          fontSize: 80.sp,
                          letterSpacing: 2,
                          fontFamily: ConstStyle.poppins,
                        ),
                      ),
                      Container(
                        height: 8.h,
                        width: 260.w,
                        color: Colors.white,
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  styleText() {
    return TextStyle(
      color: ConstStyle.textWhiteColor,
      fontSize: 140.sp,
      fontFamily: ConstStyle.poppins,
      fontWeight: FontWeight.w700,
    );
  }
}
