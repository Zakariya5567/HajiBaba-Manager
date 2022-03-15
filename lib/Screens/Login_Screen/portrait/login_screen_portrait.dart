import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haji_baba_manager/Provider/login_provider.dart';
import 'package:haji_baba_manager/Utils/const_style.dart';
import 'package:haji_baba_manager/Utils/const_text.dart';
import 'package:haji_baba_manager/Utils/images.dart';
import 'package:provider/provider.dart';

class PortraitLoginScreen extends StatelessWidget {
  const PortraitLoginScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider=Provider.of<LoginProvider>(context,listen: false);
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
              SizedBox(height: 80.h),
              //login button
              MaterialButton(
                minWidth: 620.w,
                height: 120.h,
                color: ConstStyle.logButtonColor,
                onPressed: () async{
                  Navigator.of(context).pushNamed('/loginFormScreen');
                },
                child: Text(
                  ConstText.loginButtonText,
                  style: TextStyle(
                      color: ConstStyle.logButtonTextColor,
                      fontSize: 60.sp,
                      fontWeight: FontWeight.w500),
                ),
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              ),
              SizedBox(
                height: 50.h,
              ),
              //forget password textButton
              TextButton(
                  onPressed: () {
                    //loginProvider.getData();
                  },
                  child: Column(
                    children: [
                      Text(
                        ConstText.forgotPasswordText,
                        style: TextStyle(
                          color: ConstStyle.logButtonTextColor,
                          fontSize: 45.sp,
                          letterSpacing: 2,
                          fontFamily: ConstStyle.poppins,
                        ),
                      ),
                      Container(
                        height: 5.h,
                        width: 310.w,
                        color: Colors.white,
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  styleText() => TextStyle(
    color: ConstStyle.textWhiteColor,
    fontFamily: ConstStyle.poppins,
    fontWeight: FontWeight.w700,
    fontSize: 80.sp,
  );
}
