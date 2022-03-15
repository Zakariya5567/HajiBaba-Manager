import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haji_baba_manager/Provider/order_screen_provider.dart';
import 'package:haji_baba_manager/Provider/profile_provider.dart';
import 'package:haji_baba_manager/Utils/const_style.dart';
import 'package:haji_baba_manager/Utils/const_text.dart';
import 'package:haji_baba_manager/services/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PortraitSideBar extends StatelessWidget {
  const PortraitSideBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Consumer<ProfileProvider>(builder: (context, controller, child) {
          return Container(
                  height: screenHeight,
                  width: 700.w,
                  color: Colors.white,
                  child:
                  // controller.isLoading == 0
                  //     ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // calling to profile app bar
                      profileAppBar(context),
                      // calling to order list button
                      orderListButton(context),
                      Expanded(child: Container()),
                      // calling to counter name
                      counterName(context),
                      // logOutButton(context),
                    ],
                  )
          //       : const Center(
          // child: CircularProgressIndicator(
          // color: Colors.deepOrangeAccent,
          // ),
          // ),
                );
        });
  }

  Widget profileAppBar(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, controller, child) {
      return Container(
          height: 340.h,
          width: 700.w,
          color: ConstStyle.orangeColor,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 60.w, top: 50.h),
                  child: Row(
                    children: [
                      // profile image
                      Container(
                        height: 200.h,
                        width: 200.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(Icons.person,
                              color: ConstStyle.orangeColor, size: 160.sp),
                        ),
                      ),
                      SizedBox(
                        width: 40.w,
                      ),
                      Expanded(
                        child:controller.isLoading==0?
                            //profile person name and position
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(
                                  "${controller.profileData['name']}",
                                  style: TextStyle(
                                    color: ConstStyle.textWhiteColor,
                                    fontFamily: ConstStyle.poppins,
                                    fontSize: 55.sp,
                                    fontWeight: FontWeight.w900,
                                  )),
                              Text("${controller.profileData['managerRole']}",
                                  style: TextStyle(
                                      color: ConstStyle.textWhiteColor,
                                      fontFamily: ConstStyle.poppins,
                                      fontSize: 50.sp,
                                      fontWeight: FontWeight.w500)),
                            ]):
                            loadingIndicator()
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
    });
  }

  Widget orderListButton(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, controller, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 90.w, top: 50.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // order list text
                Text(ConstText.orderListText,
                    style: TextStyle(
                      color: ConstStyle.textBlackColor,
                      fontFamily: ConstStyle.poppins,
                      fontSize: 55.sp,
                      fontWeight: FontWeight.w900,
                    )),
                SizedBox(
                  height: 30.h,
                ),
                //===========================================================================================
                // "All" text button
                TextButton(
                    onPressed: () async {
                      controller.loading(1);
                      controller.buttonAllColor(true);
                      controller.allCurrentPage=1;
                      controller.searchData('0');
                      controller.pageController("all");
                      Navigator.of(context).pushNamed('/orderScreen');
                      await controller.getAllOrder(context);
                      controller.buttonAllColor(false);
                      controller.loading(0);
                    },
                    child: Text(
                      ConstText.allButtonText,
                      style: TextStyle(
                          color: controller.allColor == true
                              ? ConstStyle.orangeColor
                              : ConstStyle.textGreyColor,
                          fontFamily: ConstStyle.poppins,
                          fontSize: 45.sp,
                          fontWeight: FontWeight.w800),
                    )),
                // "pending" text button
                TextButton(
                    onPressed: () async {
                      controller.loading(1);
                      controller.buttonPendingColor(true);
                      controller.pendingCurrentPage=1;
                      controller.searchData('0');
                      controller.pageController("pending");
                      Navigator.of(context).pushNamed('/orderScreen');
                      await controller.getPendingOrder(context);
                      controller.buttonPendingColor(false);
                      controller.loading(0);
                    },
                    child: Text(
                      ConstText.pendingButtonText,
                      style: TextStyle(
                          color: controller.pendingColor == true
                              ? ConstStyle.orangeColor
                              : ConstStyle.textGreyColor,
                          fontFamily: ConstStyle.poppins,
                          fontSize: 45.sp,
                          fontWeight: FontWeight.w800),
                    )),

                // "procession" text button
                TextButton(
                    onPressed: () async {
                      controller.loading(1);
                      controller.buttonProcessingColor(true);
                      controller.processingCurrentPage=1;
                      controller.searchData('0');
                      controller.pageController("processing");
                      Navigator.of(context).pushNamed('/orderScreen');
                      await controller.getProcessingOrder(context);
                      controller.buttonProcessingColor(false);
                      controller.loading(0);
                    },
                    child: Text(
                      ConstText.processionButtonText,
                      style: TextStyle(
                          color: controller.processingColor == true
                              ? ConstStyle.orangeColor
                              : ConstStyle.textGreyColor,
                          fontFamily: ConstStyle.poppins,
                          fontSize: 45.sp,
                          fontWeight: FontWeight.w800),
                    )),
                // "readyForCollection" text button
                TextButton(
                    onPressed: () async {
                      controller.loading(1);
                      controller.buttonReadyColor(true);
                      controller.readyCurrentPage=1;
                      controller.searchData('0');
                      controller.pageController("ready");
                      Navigator.of(context).pushNamed('/orderScreen');
                      await controller.getReadyForCollectionOrder(context);
                      controller.buttonReadyColor(false);
                      controller.loading(0);
                    },
                    child: Text(
                      ConstText.readyForCollectionButtonText,
                      style: TextStyle(
                          color: controller.readyColor == true
                              ? ConstStyle.orangeColor
                              : ConstStyle.textGreyColor,
                          fontFamily: ConstStyle.poppins,
                          fontSize: 45.sp,
                          fontWeight: FontWeight.w800),
                    )),
                // "complete" text button
                TextButton(
                    onPressed: () async {
                      controller.loading(1);
                      controller.buttonCompleteColor(true);
                      controller.completeCurrentPage=1;
                      controller.searchData('0');
                      controller.pageController("complete");
                      Navigator.of(context).pushNamed('/orderScreen');
                      await controller.getCompleteOrder(context);
                      controller.buttonCompleteColor(false);
                      controller.loading(0);
                    },
                    child: Text(
                      ConstText.completeButtonText,
                      style: TextStyle(
                          color: controller.completeColor == true
                              ? ConstStyle.orangeColor
                              : ConstStyle.textGreyColor,
                          fontFamily: ConstStyle.poppins,
                          fontSize: 45.sp,
                          fontWeight: FontWeight.w800),
                    )),
              ],
            ),
          )
        ],
      );
    });
  }

  Widget counterName(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Consumer<ProfileProvider>(builder: (context, controller, child) {
      return
        Container(
        width: 700.w,
        color: ConstStyle.cardGreyColor,
        child: Padding(
          padding: EdgeInsets.only(left: 90.w, top: 50.h),
          child:
          controller.isLoading==0?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //counter name text
              Text("${controller.profileData['storeName']}",
                  style: TextStyle(
                    color: ConstStyle.textBlackColor,
                    fontFamily: ConstStyle.poppins,
                    fontSize: 55.sp,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 30.h),
              //counter address text

              Text(
                "${controller.profileData['storeAddress']}",
                style: counterNameTextStyle(),
              ),
              SizedBox(height: 30.h),
              //counter phone number text
              Text(
                "${controller.profileData['storePhoneNumber']}",
                style: counterNameTextStyle(),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 30.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // logOut button of the profile screen
                    MaterialButton(
                      minWidth: 250.w,
                      height: 80.h,
                      color: ConstStyle.logButtonColor,
                      onPressed: () async {
                        SharedPreferencesData sharedPreferencesData =
                            SharedPreferencesData();
                        sharedPreferencesData.clearData();
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setBool("login", false);
                        Navigator.of(context)
                            .pushReplacementNamed('/loginScreen');
                      },
                      child: Text(ConstText.logOutButtonText,
                          style: TextStyle(
                            color: ConstStyle.logButtonTextColor,
                            fontFamily: ConstStyle.poppins,
                            fontSize: 42.sp,
                            fontWeight: FontWeight.w700,
                          )),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight / 38),
            ],
          ):
              loadingIndicator()
        ),
      );
    });
  }

  counterNameTextStyle() {
    return TextStyle(
      color: ConstStyle.textGreyColor,
      fontFamily: ConstStyle.poppins,
      fontSize: 38.sp,
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
