import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haji_baba_manager/Provider/dashboard_provider.dart';
import 'package:haji_baba_manager/Provider/order_screen_provider.dart';
import 'package:haji_baba_manager/Provider/profile_provider.dart';
import 'package:haji_baba_manager/Utils/const_style.dart';
import 'package:haji_baba_manager/Utils/const_text.dart';
import 'package:provider/provider.dart';

import '../../search_bottom_sheet.dart';

class LandscapeBottomNavigationBar extends StatelessWidget {
  LandscapeBottomNavigationBar({Key key}) : super(key: key);
  ProfileProvider profileProvider=ProfileProvider();
  SearchBottomSheet showBottomSheet=SearchBottomSheet();

  @override
  Widget build(BuildContext context) {
    final orderController=Provider.of<OrderProvider>(context);
    return  BottomNavigationBar(
      backgroundColor: ConstStyle.orangeColor,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[

        //Home Icon

        BottomNavigationBarItem(
          icon:
          Consumer<DashboardProvider>(builder: (context, controller, child) {
            return IconButton(
              icon: const Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              onPressed: () async {
                controller.loading(1);
                orderController.pageController('all');
                orderController.searchPageData('home');
                Navigator.of(context).pushNamed('/dashBoardScreen');
                await controller.getDashboardDetail(context);
                controller.loading(0);
              },
              iconSize: 120.sp,
            );
          }),
          title: Text(
            ConstText.homeIconText,
            style: styleText(),
          ),
        ),

        //all order Icon

        BottomNavigationBarItem(
          icon:
          Consumer<OrderProvider>(
              builder: (context, controller, child) {
                return IconButton(
                  icon: const
                  Icon(
                    Icons.menu_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () async{
                    controller.loading(1);
                    controller.allCurrentPage=1;
                    controller.searchData('0');
                    controller.pageController("all");
                    Navigator.of(context).pushNamed('/orderScreen');
                    await controller.getAllOrder(context);
                    controller.loading(0);
                  },

                  iconSize: 120.sp,
                );
              }),
          title: Text(ConstText.allOrderIconText, style: styleText()
          ),

        ),

        //today orders icon

        BottomNavigationBarItem(
          icon:
          Consumer<OrderProvider>(builder: (context, controller, child) {
            return IconButton(
              icon: const Icon(
                Icons.watch_later_outlined,
                color: Colors.white,
              ),
              onPressed: () async{
                controller.loading(1);
                controller.todayCurrentPage=1;
                controller.searchData('0');
                controller.pageController("today");
                Navigator.of(context).pushNamed('/orderScreen');
                await controller.getTodayOrder(context);
                controller.loading(0);
              },
              iconSize: 120.sp,
            );
          }),
          title: Text(ConstText.todayOrdersIconText, style: styleText()),
        ),

        //search icon

        BottomNavigationBarItem(
          icon:
          Consumer<OrderProvider>(
              builder: (context, controller, child) {
                return IconButton(
                  icon: const Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                      showBottomSheet.showSearchBottomSheet(context);
                  },
                  iconSize: 120.sp,
                );
              }),

          title: Text(ConstText.searchIconText, style: styleText()),
        ),

        //Profile Icon

        BottomNavigationBarItem(
          icon:
          Consumer<ProfileProvider>(builder: (context, controller, child) {
            return IconButton(
              icon: const Icon(
                Icons.person_outline_rounded,
                color: Colors.white,
              ),
              onPressed: () async {
                controller.loading(1);
                orderController.pageController('all');
                orderController.searchPageData('home');
                Navigator.of(context).pushNamed('/managerProfileScreen');
                await controller.getProfileData(context);
                await controller.userEmail();
                controller.loading(0);
              },
              iconSize:120.sp,
            );
          }),
          title: Text(ConstText.profileIconText, style: styleText()),
        ),

      ],
    );
  }


  styleText() {
    return TextStyle(
        color: ConstStyle.textWhiteColor,
        fontSize: 50.sp,
        fontWeight: FontWeight.w700);
  }
  //
  // showSearchBar(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     backgroundColor: ConstStyle.cardWhiteColor,
  //     shape: RoundedRectangleBorder(
  //       borderRadius:BorderRadius.circular(30.sp),
  //     ),
  //     title:   Padding(
  //       padding: EdgeInsets.all(120.sp),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Container(
  //             width: 1050,
  //             child: Row(
  //               children: <Widget>[
  //
  //                 Flexible(
  //                   child:
  //                   TextField(
  //                   autofocus: false,
  //                   //  controller: emailController,
  //                   style: TextStyle(fontSize: 60.sp),
  //                   keyboardType: TextInputType.emailAddress,
  //                   textInputAction: TextInputAction.next,
  //                   decoration: InputDecoration(
  //                     errorStyle: TextStyle(fontSize: 60.sp),
  //                     fillColor: ConstStyle.cardGreyColor,
  //                     filled: true,
  //                     contentPadding: EdgeInsets.symmetric(
  //                       vertical: 45.h,
  //                       horizontal: 80.w,
  //                     ),
  //                     hintText: ConstText.searchHintText,
  //                     hintStyle: TextStyle(
  //                       fontSize: 60.sp,
  //                       color: ConstStyle.textGreyColor,
  //                     ),
  //                     border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(100)),
  //                     enabledBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(100),
  //                       borderSide:
  //                       const BorderSide(color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           SizedBox(height:100.sp),
  //           GestureDetector(
  //             child: Container(
  //               height: 150.sp,
  //               width: 560.sp,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(60.sp),
  //                 color: ConstStyle.orangeColor,
  //               ),
  //               child: Center(child: Text("Search",
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 70.sp,
  //                   fontWeight: FontWeight.w500,
  //                   fontFamily: ConstStyle.poppins,
  //                 ),)),
  //             ),
  //             onTap: (){
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  //
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
}
