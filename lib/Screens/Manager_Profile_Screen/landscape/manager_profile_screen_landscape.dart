import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haji_baba_manager/Provider/dashboard_provider.dart';
import 'package:haji_baba_manager/Provider/order_screen_provider.dart';
import 'package:haji_baba_manager/Provider/profile_provider.dart';
import 'package:haji_baba_manager/Utils/const_style.dart';
import 'package:haji_baba_manager/Widgets/bottom_navigation_bar/Landscape_bottom_navigation_bar/landscape_bottom_navigation_bar.dart';
import 'package:haji_baba_manager/Widgets/side_menu_bar/side_menu_bar.dart';
import 'package:haji_baba_manager/services/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LandscapeManagerProfileScreen extends StatelessWidget {
  LandscapeManagerProfileScreen({Key key}) : super(key: key);
  //InternetProvider internetProvider=InternetProvider();

  @override
  Widget build(BuildContext context) {
    //internetProvider.internetChecker(context);
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return
      Scaffold(
        drawer: const SideMenuBar(),
        backgroundColor: Colors.grey.shade300,
        //  drawer: const SideMenuBar(),
        body: Stack(
          children: [
            Consumer<ProfileProvider>(
                builder: (context,controller,child) {
                  return
                    Container(
                      height: screenHeight,
                      width: screenWidth,
                      color: ConstStyle.cardGreyColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          profileAppBar(context,screenWidth),
                          managerDetail(context, screenWidth,screenHeight),
                        ],
                      ),
                    );

                }
            ),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/2.5,
                top: 260.sp,
              ),
              child: Container(height: 330,width: 330,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: Icon(Icons.person,color: ConstStyle.orangeColor,size: 300.sp,),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: LandscapeBottomNavigationBar(),
      );
  }

  Widget profileAppBar(BuildContext context, double screenWidth ) {
    return  Container(
        height: 520.h,
        width: screenWidth,
        color: ConstStyle.orangeColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 60.w, top: 90.h,right: 60.w),
                child: Consumer<OrderProvider>(
                    builder: (context,orderController,child) {
                    return Row(
                      children: [
                        Consumer<DashboardProvider>(
                          builder: (context,controller,child) {
                            return IconButton(
                                onPressed: () async {
                                  controller.loading(1);
                                  orderController.pageController('all');
                                  orderController.searchPageData('home');
                                  Navigator.of(context).pushNamed('/dashBoardScreen');
                                  await controller.getDashboardDetail(context);
                                  controller.loading(0);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 100.sp,
                                ));
                          }
                        ),
                        Expanded(child: Container(width: 20,)),
                        Text(
                            "Profile    ",
                            style: TextStyle(
                                color: ConstStyle.textWhiteColor,
                                fontFamily: ConstStyle.poppins,
                                fontSize: 80.sp,
                                fontWeight: FontWeight.w500)
                        ),
                        Expanded(child: Container(width: 20,)),
                      ],
                    );
                  }
                ),
              ),
            ],
          ),
        ));

  }
  Widget managerDetail(BuildContext context, double screenWidth, double screenHeight ) {
    return  Expanded(
      child: Consumer<ProfileProvider>(
          builder: (context,controller,child) {
          return Container(
              height:screenHeight,
              width: screenWidth,
              color: Colors.grey.shade100,
              child: Padding(
                padding: EdgeInsets.only(left: 80.w,top: 80.h,right: 60.w,bottom: 60.h,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 250.sp,),
                    Center(
                      child:
                      controller.isLoading==0?
                      Text( "${controller.profileData['name']}",style: TextStyle(
                        color: ConstStyle.orangeColor,fontSize: 100.sp,
                        fontWeight: FontWeight.w900,
                      )):loadingIndicator(),
                    ),
                    SizedBox(height: 100.sp,),
                    Row(children: [
                      Icon(Icons.phone,size: 100.0.sp,color: Colors.grey,),
                      SizedBox(width: 100.sp,),
                      controller.isLoading==0?
                      Text("${controller.email}",style: greyTextStyle(),)
                          :loadingIndicator(),
                    ],),
                    sizedBox20(),
                    Row(children: [
                      Icon(Icons.email,size: 100.0.sp,color: Colors.grey,),
                      SizedBox(width: 100.sp,),
                      controller.isLoading==0?
                      Text("${controller.profileData['storePhoneNumber']}",
                        style: greyTextStyle(),)
                          :loadingIndicator(),
                    ],),

                    SizedBox(height: 60.sp,),
                    Container(height: 2.0,width: screenWidth,
                      color: Colors.grey.shade400,
                    ),

                    SizedBox(height: 30.sp,),
                    Row(children: [
                      Icon(Icons.lock,size: 100.0.sp,color: Colors.black87,),
                      SizedBox(width: 100.sp,),

                      //request to change password button
                      TextButton(
                        onPressed: ()async{
                          controller.isLoading=1;
                          changePasswordDialog(context);
                          await controller.restPassword(context);
                          controller.isLoading=0;
                        },
                        child: Text("Request to change password",style: blackTextStyle(),),
                      ),
                    ],),
                    SizedBox(height: 20.sp,),
                    Row(children: [
                      Icon(Icons.logout,size: 100.0.sp,color: Colors.black87,),
                      SizedBox(width: 100.sp,),

                      // logout button
                      TextButton( onPressed: () async {
                        SharedPreferencesData sharedPreferencesData = SharedPreferencesData();
                        sharedPreferencesData.clearData();
                        SharedPreferences pref = await SharedPreferences
                            .getInstance();
                        pref.setBool("login", false);
                        Navigator.of(context).pushReplacementNamed('/loginScreen');
                      },
                        child:Text("Logout",style: blackTextStyle(),),
                      )
                    ],),
                  ],
                ),
              ));
        }
      ),
    );

  }


  changePasswordDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: ConstStyle.cardGreyColor,
      shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(30.sp),
      ),
      title:   Padding(
        padding: EdgeInsets.all(120.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100.sp,),
            Image.asset('assets/images/resetPasswordImage.jpeg',
              height: 400.sp,width:400.sp ,),
            SizedBox(height: 80.sp,),
            Text("Your password has",style: resetBlackStyle(),),
            Text("been reset",style: resetBlackStyle(),),
            sizedBox20(),
            Text("You'll shortly recieve on email with a",style: resetGreyStyle(),),
            Text("code to setup a new password",style: resetGreyStyle(),),
            SizedBox(height:120.sp),
            GestureDetector(
              child: Container(
                height: 140.sp,
                width: 1100.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.sp),
                  color: ConstStyle.orangeColor,
                ),
                child: Center(child: Text("Done",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 80.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: ConstStyle.poppins,
                  ),)),
              ),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),
            SizedBox(height: 100.sp,),

          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  sizedBox20(){
    return SizedBox(height: 20.sp);
  }
  sizedBox40(){
    return SizedBox(height: 40.sp);
  }

  greyTextStyle(){
    return  TextStyle(
      color: ConstStyle.textGreyColor,
      fontWeight: FontWeight.w500,
      fontFamily: ConstStyle.poppins,
      letterSpacing: 3,
      fontSize:66.sp,

    );
  }
  blackTextStyle(){
    return  TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.w800,
      fontFamily: ConstStyle.poppins,
      letterSpacing: 3,
      fontSize:66.sp,

    );
  }
  resetGreyStyle(){
    return TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w500,
      fontFamily: ConstStyle.poppins,
      letterSpacing: 3,
      fontSize:62.sp,
    );
  }
  resetBlackStyle(){
    return TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.w500,
      fontFamily: ConstStyle.poppins,
      letterSpacing: 3,
      fontSize:76.sp,
    );
  }

  loadingIndicator(){
    return const Center(
      child: CircularProgressIndicator(
        color:Colors.red,
      ),
    );
  }
}