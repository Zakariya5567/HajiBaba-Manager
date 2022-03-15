import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haji_baba_manager/Provider/internet_provider.dart';
import 'package:haji_baba_manager/Provider/login_provider.dart';
import 'package:haji_baba_manager/Utils/const_style.dart';
import 'package:haji_baba_manager/Utils/const_text.dart';
import 'package:haji_baba_manager/Utils/images.dart';
import 'package:provider/provider.dart';


class PortraitLoginFormScreen extends StatelessWidget {
  PortraitLoginFormScreen({Key key}) : super(key: key);

  //InternetProvider internetProvider=InternetProvider();

  final formKey=GlobalKey<FormState>();

  //Editing controller for email and password
  final TextEditingController emailController= TextEditingController();
  final TextEditingController passwordController= TextEditingController();

  @override
  Widget build(BuildContext context) {
   // internetProvider.internetChecker(context);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  // this image is used for the background of the user login screen
                    ConstImages.loginFormBackgroundImage
                ))),
        child: Center(
          // the center widget is user to show the form in the center of the screenSingleChildScrollView(
          child: SingleChildScrollView(
            child: Container(
              width: 900.w,
              height: 1050.h,
              decoration: BoxDecoration(
                color: Colors.white,
                //border radius is used for circular form
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                //this padding is used to create space horizontally between form sides
                // and other widgets,text, textField.
                padding: EdgeInsets.only(
                    left: 80.w, right: 80.w, top: 60.h, bottom: 60.h),
                child: Column(
                  children: [
                    Text(
                      ConstText.welcomeBackText,
                      style: TextStyle(
                          color: ConstStyle.textBlackColor,
                          fontSize: 65.sp,
                          fontFamily: ConstStyle.poppins,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(ConstText.loginToYourAccountText,
                        style: TextStyle(
                            color: ConstStyle.textGreyColor,
                            fontSize: 45.sp,
                            fontFamily: ConstStyle.poppins)),

                    SizedBox(height: 60.h,),
                    //Login form textFieldForm
                    signInForm(),
                    SizedBox(height: 80.h,),
                    //login button
                    // isLoading ? new PrimaryButton(
                    //     key: new Key('login'),
                    //     text: 'Login',
                    //     height: 44.0,
                    //     onPressed: setState((){isLoading = true;}))
                    //     : Center(
                    //   child: CircularProgressIndicator(),
                    // )
                   Consumer<LoginProvider>(
                     builder: (context,controller,child) {
                       return controller.loading==0 ? MaterialButton(
                          height: 110.h,
                          minWidth: 800.w,
                          color: ConstStyle.logButtonColor,
                         child: Text(
                           ConstText.loginButtonText,
                           style: TextStyle(
                               color: ConstStyle.logButtonTextColor,
                               fontSize: 60.sp,
                               fontWeight: FontWeight.w500),
                         ),
                          onPressed: () async{
                            controller.loadingData(1);
                            if(formKey.currentState.validate()){
                              await controller.postLogin(
                                  emailController.text,
                                  passwordController.text,
                                  context);
                            }
                            controller.loadingData(0);
                            },

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                        ):const CircularProgressIndicator(
                         color: Colors.deepOrangeAccent,
                       );
                     }
                   ),



                    SizedBox(
                      height: 60.h,
                    ),
                    //forget password text button
                    TextButton(
                      onPressed: () {
                      },
                      child: Column(
                        children: [
                          Text(ConstText.forgotYourPasswordText,
                              style: TextStyle(
                                color: ConstStyle.textGreyColor,
                                fontSize: 36.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: ConstStyle.poppins,
                              )),
                          Container(
                            height: 4.h,
                            width: 300.w,
                            color: ConstStyle.textGreyColor,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }
  signInForm(){
    return
      Form(
      key: formKey,
      child: Column(
        children: [
          // Email field of the login Form
          TextFormField(
            autofocus: false,
            controller: emailController,
            style: TextStyle(fontSize: 40.sp),
            keyboardType: TextInputType.emailAddress,
            validator: (value){
              if(value.isEmpty){
                return "please enter your email";
              }
              if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]+").hasMatch(value)){
                return "please enter valid email";
              }
              return null;
            },
            onSaved: (value){
              emailController.text=value;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              errorStyle: TextStyle(fontSize: 36.sp),
              fillColor: ConstStyle.cardGreyColor,
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 35.h,
                horizontal: 60.w,
              ),
              hintText: ConstText.emailHintText,
              hintStyle: TextStyle(
                fontSize: 40.sp,
                color: ConstStyle.textGreyColor,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide:
                const BorderSide(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          // Password field of the login Form
          TextFormField(
            autofocus: false,
            obscureText: true,
            style: TextStyle(fontSize: 40.sp),
            controller: passwordController,
            validator: (value){
              RegExp regExp=new RegExp(r'^.{3,}$');
              if(value.isEmpty){
                return "Enter your password";
              }
              if(!regExp.hasMatch(value)){
                return "Enter a valid password minimum 3 character";
              }

            },
            onSaved: (value){
              passwordController.text=value;
            },
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              errorStyle: TextStyle(fontSize: 36.sp),
              fillColor: ConstStyle.cardGreyColor,
              filled: true,
              hintText: ConstText.passwordHintText,
              contentPadding: EdgeInsets.symmetric(
                vertical: 35.h,
                horizontal: 60.w,
              ),
              hintStyle: TextStyle(
                  fontSize: 40.sp,
                  color: ConstStyle.textGreyColor
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide:
                const BorderSide(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
