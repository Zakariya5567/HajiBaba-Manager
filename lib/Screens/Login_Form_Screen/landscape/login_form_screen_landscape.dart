import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haji_baba_manager/Model/user_model.dart';
import 'package:haji_baba_manager/Provider/login_provider.dart';
import 'package:haji_baba_manager/Utils/const_style.dart';
import 'package:haji_baba_manager/Utils/const_text.dart';
import 'package:haji_baba_manager/Utils/images.dart';
import 'package:provider/provider.dart';


class LandscapeLoginFormScreen extends StatelessWidget{
  LandscapeLoginFormScreen({Key key}) : super(key: key);

  //InternetProvider internetProvider=InternetProvider();

  final formKey=GlobalKey<FormState>();

  //Editing controller for email and password
  final TextEditingController emailController= TextEditingController();
  final TextEditingController passwordController= TextEditingController();

  @override
  Widget build(BuildContext context) {
   // internetProvider.internetChecker(context);
    LoginProvider loginProvider=Provider.of<LoginProvider>(context,listen: false);
    return  Scaffold(
      body: Container(
        width:MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  // this image is used for the background of the user login screen
                    ConstImages.loginFormBackgroundImage
                )
            )
        ),
        child:  Center(
          // the center widget is user to show the form in the center of the screenSingleChildScrollView(
          child: SingleChildScrollView(
            child: Container(
              width: 600.w,
              height: 1550.h,
              decoration: BoxDecoration(
                color: Colors.white,
                //border radius is used for circular form
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                //this padding is used to create space horizontally between form sides
                // and other widgets,text, textField.
                padding: EdgeInsets.only(
                    left:50.w,right: 50.w,top: 80.h,bottom: 80.h),
                child: Column(
                  children: [
                    Text(ConstText.welcomeBackText,
                      style:TextStyle(
                          color: ConstStyle.textBlackColor,
                          fontSize: 100.sp,
                          fontFamily: ConstStyle.poppins,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    Text(ConstText.loginToYourAccountText,
                        style:TextStyle(
                            color: ConstStyle.textGreyColor,
                            fontSize:65.sp,
                            fontFamily:ConstStyle.poppins)),

                    SizedBox(height:70.h,),
                    //Login form textFieldForm
                    signInForm(),
                    SizedBox(height:100.h,),
                    //calling to login button widget function
                    Consumer<LoginProvider>(
                      builder: (context,controller,child) {
                        return controller.loading==0 ? MaterialButton(
                          height: 180.h,
                          minWidth: 500.w,
                          color: ConstStyle.logButtonColor,
                          child: Text(ConstText.loginButtonText,
                            style: TextStyle(
                                color: ConstStyle.logButtonTextColor,
                                fontSize: 90.sp,
                                fontWeight: FontWeight.w500),),
                          onPressed: ()async{
                            loginProvider.loadingData(1);
                            if(formKey.currentState.validate()){
                              UserModel user= await loginProvider.postLogin(
                                  emailController.text,
                                  passwordController.text,
                                  context);
                            }
                            loginProvider.loadingData(0);
                          },

                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)
                          ),
                        ):const CircularProgressIndicator(
                          color: Colors.deepOrangeAccent,
                        );
                      }
                    ),
                    SizedBox(height: 60.h,),
                    //forget password text button
                    TextButton(
                      onPressed: (){},
                      child: Column(
                        children: [
                          Text(ConstText.forgotYourPasswordText,
                              style:TextStyle(color: Colors.black54,
                                fontSize: 58.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: ConstStyle.poppins,
                              )),
                          Container(
                            height: 4.h,
                            width:235.w,
                            color: ConstStyle.textGreyColor,)
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
    return  Form(
      key: formKey,
      child: Column(
        children: [
          // Email field of the login Form
          TextFormField(
            autofocus: false,
            controller: emailController,
            style: TextStyle(fontSize: 70.sp),
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
              errorStyle: TextStyle(fontSize: 50.sp),
              fillColor:ConstStyle.cardGreyColor ,
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 60.h,
                horizontal: 40.w,
              ),
              hintText:  ConstText.emailHintText,
              hintStyle: TextStyle(
                fontSize:70.sp,
                color: ConstStyle.textGreyColor, ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100)
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide:  const BorderSide(color: Colors.white ),
              ),
            ),
          ),
          SizedBox(height:60.h,),
          // Password field of the login Form
          TextFormField(
            autofocus: false,
            obscureText: true,
            style: TextStyle(fontSize: 70.sp),
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
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              errorStyle: TextStyle(fontSize: 50.sp),
              fillColor: const Color(0xFFf1f2f6),
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 60.h,
                horizontal: 40.w,
              ),
              hintText:  ConstText.passwordHintText,
              hintStyle: TextStyle(
                fontSize:70.sp,
                color: ConstStyle.textGreyColor,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100)
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide:  const BorderSide(color: Colors.white ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
