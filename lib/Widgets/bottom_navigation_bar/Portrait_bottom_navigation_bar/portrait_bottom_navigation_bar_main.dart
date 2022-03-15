import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haji_baba_manager/Provider/dashboard_provider.dart';
import 'package:haji_baba_manager/Provider/manager_profile_provider.dart';
import 'package:haji_baba_manager/Provider/order_screen_provider.dart';
import 'package:haji_baba_manager/Provider/profile_provider.dart';
import 'package:haji_baba_manager/Utils/const_style.dart';
import 'package:haji_baba_manager/Utils/const_text.dart';
import 'package:haji_baba_manager/Widgets/search_bottom_sheet.dart';
import 'package:haji_baba_manager/Widgets/side_menu_bar/portrait_side_bar/portrait_side_bar.dart';
import 'package:provider/provider.dart';

class PortraitBottomNavigationBar extends StatelessWidget {
   PortraitBottomNavigationBar({Key key}) : super(key: key);
   SearchBottomSheet showBottomSheet=SearchBottomSheet();

  @override
  Widget build(BuildContext context) {
    final orderController=Provider.of<OrderProvider>(context);
    return BottomNavigationBar(
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
              iconSize: 90.sp,
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

                iconSize: 90.sp,
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
                controller.pageController("today");
                controller.searchData('0');
                Navigator.of(context).pushNamed('/orderScreen');
                await controller.getTodayOrder(context);
                controller.loading(0);

              },
              iconSize: 90.sp,
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
                iconSize: 90.sp,
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
                orderController.searchPageData('profile');
                Navigator.of(context).pushNamed('/managerProfileScreen');
                await controller.getProfileData(context);
                await controller.userEmail();
                controller.loading(0);
              },
              iconSize: 90.sp,
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
        fontSize: 36.sp,
        fontWeight: FontWeight.w700);
  }
}

