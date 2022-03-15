import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haji_baba_manager/Provider/dashboard_provider.dart';
import 'package:haji_baba_manager/Provider/internet_provider.dart';
import 'package:haji_baba_manager/Provider/order_detail_provider.dart';
import 'package:haji_baba_manager/Provider/order_screen_provider.dart';
import 'package:haji_baba_manager/Provider/profile_provider.dart';
import 'package:haji_baba_manager/Utils/const_style.dart';
import 'package:haji_baba_manager/Utils/const_text.dart';
import 'package:haji_baba_manager/Widgets/bottom_navigation_bar/Landscape_bottom_navigation_bar/landscape_bottom_navigation_bar.dart';
import 'package:haji_baba_manager/Widgets/side_menu_bar/side_menu_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LandscapeDashBoardScreen extends StatelessWidget {
   LandscapeDashBoardScreen({Key key}) : super(key: key);

   //InternetProvider internetProvider=InternetProvider();

   //the getData function will call when first time open the dashboard screeen
   // initially the data is null

   getData(DashboardProvider dashboardProvider, BuildContext context )async{
     await dashboardProvider.getDashboardDetail(context);}

  @override
  Widget build(BuildContext context) {
   // internetProvider.internetChecker(context);
    final dashboardProvider=Provider.of<DashboardProvider>(context);
    if(dashboardProvider.dashboardDetailData.isEmpty){
      dashboardProvider.isLoading=1;
      getData(dashboardProvider,context);
      dashboardProvider.isLoading=0;
    }
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return
      Scaffold(
        drawer: const SideMenuBar(),
        body:
        Consumer<DashboardProvider>(
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
                      ordersBar(context, screenWidth),
                      todayOrders(context, screenWidth,screenHeight)
                    ],
                  ),
                );
            }
        ),
        bottomNavigationBar:  LandscapeBottomNavigationBar(),
      );
  }

  Widget profileAppBar(BuildContext context, double screenWidth ) {
    return  Container(
        height: 420.h,
        width: screenWidth,
        color: ConstStyle.orangeColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 60.w, top: 50.h,right: 60.w),
                child: Row(
                  children: [
                    Consumer<ProfileProvider>(
                        builder: (context, controller, child) {
                          return IconButton(
                              onPressed: () async {
                                controller.loading(1);
                                Scaffold.of(context).openDrawer();
                                await controller.getProfileData(context);
                                controller.loading(0);
                              },

                              icon: Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 100.sp,
                              ));
                        }
                    ),

                    Expanded(child: Container(width: 20,)),
                    //  Container(width: 700.w,),
                    Consumer<ProfileProvider>(
                        builder: (context,profileController,child) {
                          return Row(children: [
                          Icon(Icons.person_outline_rounded,
                            color: Colors.white,
                            size:profileController.profileData['managerRole']==null
                                ?0
                                :40.w
                          ),

                                  Text("${profileController.profileData['managerRole']==null?""
                                    :profileController.profileData['managerRole']}",
                                    style: TextStyle(
                                      color: ConstStyle.textWhiteColor,
                                      fontFamily: ConstStyle.poppins,
                                      fontSize: 70.sp,
                                      fontWeight: FontWeight.w500)
                              ),
                        ],
                        );
                      }
                    ),


                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60.w, top: 70.h),
                child: Row(
                  children: [
                    Text("Dashboard",
                        style: TextStyle(
                          color: ConstStyle.textWhiteColor,
                          fontFamily: ConstStyle.poppins,
                          fontSize: 70.sp,
                          letterSpacing: 3,
                          fontWeight: FontWeight.w900,
                        )),
                  ],
                ),
              )
            ],
          ),
        ));

  }

  Widget ordersBar(BuildContext context, double screenWidth ) {
    return  Container(
        height: 600.h,
        width: screenWidth,
        color: ConstStyle.textWhiteColor,
        child: Padding(
          padding: EdgeInsets.only(left: 60.w,top: 60.h,right: 60.w,bottom: 60.h,),
          child:  Consumer<OrderProvider>(
              builder: (context,controller,child) {
              return Column(
                children: [
                  Row(children: [
                    // all
                    GestureDetector(
                          onTap: () async{
                           controller.loading(1);
                           controller.allCurrentPage=1;
                           controller.searchData('0');
                           controller.pageController("all");
                           Navigator.of(context).pushNamed('/orderScreen');
                           await controller.getAllOrder(context);
                           controller.loading(0);
                        },
                          child: Container(
                            height: 220.h,
                            width: 340.w,
                            decoration: BoxDecoration(
                                color: ConstStyle.orangeColor,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Padding(
                              padding:edgeInset20(),
                              child: Column(
                                children: [
                                  Text(ConstText.dashAllText,
                                    style: styleOrderBarName(),
                                  ),
                                  sizedBox10(),
                                  Consumer<DashboardProvider>(builder:
                                      (context, dashboardController, child) {
                                    return
                                      dashboardController.isLoading==0?
                                      Text(
                                      "(${dashboardController.dashboardDetailData['allOrders']})",
                                      style: styleOrderBarNumber(),
                                    ):loadingIndicator();
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                    Expanded(child: Container(width: 20.w,)),

                    //pending
                    GestureDetector(
                            onTap:  () async {
                              controller.loading(1);
                              controller.pendingCurrentPage=1;
                              controller.searchData('0');
                              controller.pageController("pending");
                              Navigator.of(context).pushNamed('/orderScreen');
                              await controller.getPendingOrder(context);
                              controller.loading(0);
                            },
                          child: Container(
                            height: 220.h,
                            width: 340.w,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Padding(
                              padding: edgeInset20(),
                              child: Column(
                                children: [
                                  Text(ConstText.dashPendingText,
                                    style:styleOrderBarName(),
                                  ),
                                  sizedBox10(),
                                  Consumer<DashboardProvider>(builder:
                                      (context, dashboardController, child) {
                                    return
                                      dashboardController.isLoading==0?
                                      Text(
                                      "(${dashboardController.dashboardDetailData['allPendingOrders']})",
                                      style: styleOrderBarNumber(),
                                    ):loadingIndicator();
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                    Expanded(child: Container(width: 20.w,)),

                    //processing
                    GestureDetector(
                            onTap: () async {
                              controller.loading(1);
                              controller.processingCurrentPage=1;
                              controller.searchData('0');
                              controller.pageController("processing");
                              Navigator.of(context).pushNamed('/orderScreen');
                              await controller.getProcessingOrder(context);
                              controller.loading(0);
                            },
                          child: Container(
                            height: 220.h,
                            width: 340.w,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Padding(
                              padding: edgeInset20(),
                              child: Column(
                                children: [
                                  Text(ConstText.dashProcessingText,
                                    style: styleOrderBarName(),
                                  ),
                                  sizedBox10(),
                                  Consumer<DashboardProvider>(builder:
                                      (context, dashboardController, child) {
                                    return
                                      dashboardController.isLoading==0?
                                      Text(
                                      "(${dashboardController.dashboardDetailData['allProcessingOrders']})",
                                      style: styleOrderBarNumber(),
                                    ):loadingIndicator();
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                  ],),

                   SizedBox(height: 30.h,),
                   Row(children: [

                   // ready for collection
                   GestureDetector(
                            onTap: () async {
                              controller.loading(1);
                              controller.readyCurrentPage=1;
                              controller.searchData('0');
                              controller.pageController("ready");
                              Navigator.of(context).pushNamed('/orderScreen');
                              await controller.getReadyForCollectionOrder(context);
                              controller.loading(0);
                            },
                          child: Container(
                            height: 220.h,
                            width: 340.w,
                            decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Padding(
                              padding: edgeInset20(),
                              child: Column(
                                children: [
                                  Text(ConstText.dashReadyForCollectionText,
                                    style: styleOrderBarName(),
                                  ),
                                  sizedBox10(),
                                  Consumer<DashboardProvider>(builder:
                                      (context, dashboardController, child) {
                                    return
                                      dashboardController.isLoading==0?
                                      Text(
                                      "(${dashboardController.dashboardDetailData['allReadyToCollectOrders']})",
                                      style: styleOrderBarNumber(),
                                    ):loadingIndicator();
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                    Expanded(child: Container(width: 20,)),

                    // complete
                     GestureDetector(
                            onTap: () async {
                              controller.loading(1);
                              controller.completeCurrentPage=1;
                              controller.searchData('0');
                              controller.pageController("complete");
                              Navigator.of(context).pushNamed('/orderScreen');
                              await controller.getCompleteOrder(context);
                              controller.loading(0);
                            },
                          child: Container(
                            height: 220.h,
                            width: 340.w,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.shade700,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Padding(
                              padding:edgeInset20(),
                              child: Column(
                                children: [
                                  Text(ConstText.dashCompleteOrderText,
                                    style: styleOrderBarName(),
                                  ),
                                  sizedBox10(),
                                  Consumer<DashboardProvider>(builder:
                                      (context, dashboardController, child) {
                                    return
                                      dashboardController.isLoading==0?
                                      Text(
                                      "(${dashboardController.dashboardDetailData['allCompletedOrders']})",
                                      style: styleOrderBarNumber(),
                                    ):loadingIndicator();
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                    Expanded(child: Container(width: 20,)),

                    // Refunded
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        height: 220.h,
                        width: 340.w,
                        decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Padding(
                          padding:edgeInset20(),
                          child: Column(
                            children: [
                              Text(ConstText.dashRefundedText,
                                style: styleOrderBarName(),
                              ),
                              sizedBox10(),
                              Consumer<DashboardProvider>(builder:
                                  (context, dashboardController, child) {
                                return Text(
                                  "(${dashboardController.dashboardDetailData['allRefundedOrders']})",
                                  style: styleOrderBarNumber(),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],)
                  // )
                ],
              );
            }
          ),
        ));

  }

  Widget todayOrders(BuildContext context, double screenWidth, double screenHeight ) {
    return  Expanded(
      child: Consumer<OrderProvider>(
          builder: (context,orderController,child) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 150.h,top:60.h ),
                  child: Text(
                      "Today Orders",
                      style: TextStyle(
                          color: ConstStyle.textBlackColor,
                          fontFamily: ConstStyle.poppins,
                          fontSize: 70.sp,
                          fontWeight: FontWeight.w500)
                  ),
                ),
                orderController.isLoading==0?

                Consumer<DashboardProvider>(
            builder: (context, controller, child) {
            return controller.todayOrderList == null
            ? Center(
            child: Padding(
            padding: EdgeInsets.symmetric(vertical: 200.w),
            child: Text(
            "No Order Found! ",
            style: TextStyle(fontSize: 45.sp,fontWeight: FontWeight.w500),
            )),
            )
                :
            ListView.builder(

                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:controller.todayOrderList.length,

                itemBuilder: (context, index) {
                  String orderId=controller.todayOrderList[index]['id'];
                  return Padding(
                    // this padding is used for space between app bar , screen sides ,and this listview
                    padding: EdgeInsets.symmetric(
                      horizontal: 70.w,
                      vertical: 30.h,
                    ),
                    child: Container(
                      // this container is a the actual view of the order
                      // and the padding is user for space between widgets
                      padding: EdgeInsets.symmetric(
                        horizontal: 90.h,
                        vertical: 15.w,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0)),
                      // this row is used for the widgets of the number , id , price , detail etc
                      child: Row(
                        children: [
                          // container is used for the number box
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 70.h,
                                vertical: 80.h),
                            decoration: BoxDecoration(
                                color: ConstStyle.pinkColor,
                                // color: Colors.deepOrangeAccent.shade100,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              // number of the order
                              child: Text(
                                "${controller.todayOrderList[index]['storeOrderNumber']}",
                                style: orderNumberStyle(),
                              ),
                            ),
                          ),
                          SizedBox(width: 30.w),
                          // expanded is used to expend the widgets in row
                          Expanded(
                            // column is used for  order id,total order, date and time
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //order id text
                                Row(
                                  children: [
                                    Text(
                                      ConstText.orderIdText,
                                      style: orderIdStyle(),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Text(
                                        "${controller.todayOrderList[index]['refNumber']}",
                                        style: orderIdStyle(),
                                      ),
                                    ),
                                  ],
                                ),
                                sizedBox20(),
                                //total item text
                                Row(
                                  children: [
                                    Text(
                                      ConstText.totalItemText,
                                      style: listTextStyle(),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Text(
                                        "${controller.todayOrderList[index]['items']}",
                                        style: listTextStyle(),
                                      ),
                                    ),
                                  ],
                                ),
                                sizedBox20(),
                                // date time text
                                Text(
                                  "${getFormattedDate(controller.
                                  todayOrderList[index]['orderTime'])}" ,

                                  style: listTextStyle(),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 40.w,
                          ),
                          // price text
                          Padding(
                            padding: EdgeInsets.only(right: 50.w),
                            child: Text(
                              "£ ${controller.todayOrderList[index]['grandTotal']}",
                              style: orderPriceStyle(),
                            ),
                          ),
                          SizedBox(
                              width: 30.w
                          ),
                          Padding(
                              padding: EdgeInsets.only(right: 20.w),
                              // column is used for text info(pending or complete) and detail button
                              child: Column(
                                children: [
                                  // info text (pending or complete)
                                  Text(
                                    "${controller.todayOrderList[index]['name']}",
                                    style: orderStatusStyle(),
                                  ),
                                  sizedBox20(),
                                  // detail button
                               Consumer<OrderProvider>(
                                builder: (context,orderController,child) {
                                      return Consumer<OrderDetailProvider>(
                                          builder: (context,orderDetailController,child) {
                                            return GestureDetector(
                                              child: Container(
                                                height: 90.h,
                                                width: 110.w,
                                                decoration: BoxDecoration(
                                                  color: ConstStyle.greenColor,
                                                  borderRadius:  BorderRadius.circular(30),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    ConstText.detailButtonText,
                                                    style: detailButtonTextStyle(),
                                                  ),
                                                ),
                                              ),
                                              onTap: ()async {
                                                orderDetailController.loading(1);
                                                orderController.pageController('today');
                                                Navigator.of(context).pushNamed('/orderDetailScreen');
                                                await orderDetailController.getOrderDetail(context, orderId);
                                                orderDetailController.loading(0);
                                              },
                                            );
                                          }
                                      );
                                    }
                                  ),
                                ],
                              )
                          ),
                          Center(
                              child:PopupMenuButton(
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 100.sp,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.sp),
                                  ),
                                  itemBuilder: (context)=>
                                  [
                                    PopupMenuItem(
                                        child:TextButton(
                                          child: Text("Pending",style: dropDownTextStyle(),),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                        )),
                                    PopupMenuItem(
                                      child:TextButton(
                                        child: Text("Procession",style:  dropDownTextStyle(),),
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                    PopupMenuItem(
                                        child:TextButton(
                                          child: Text("Ready for collection",style:  dropDownTextStyle()),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                        )),
                                    PopupMenuItem(
                                        child:TextButton(
                                          child: Text("Complete",style: dropDownTextStyle()),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                        )),
                                  ]
                              )
                          )
                        ],
                      ),
                    ),
                  );
                }

                        );
                  }
                )
                    : loadingIndicator()
              ],
            ),
          );
        }
      ),
    );


  }

  sizedBox20(){return SizedBox(height: 20.h);}

  listTextStyle(){
    return  TextStyle(
        color: ConstStyle.textGreyColor,
        fontSize: 48.sp,
        fontWeight: FontWeight.w600);
  }

  orderNumberStyle(){
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 34.w,
      fontFamily:ConstStyle.poppins ,
      color: ConstStyle.textOrangeColor,
      //color: Colors.deepOrange
    );
  }
  orderPriceStyle(){
    return TextStyle(
      color: ConstStyle.textOrangeColor,
      fontWeight: FontWeight.w500,
      fontSize: 28.w,
    );
  }
  orderStatusStyle(){
    return TextStyle(
      color: ConstStyle.orangeColor,
      fontWeight: FontWeight.w700,
      fontSize: 22.w,
    );
  }
  detailButtonTextStyle(){
    return  TextStyle(
      color: Colors.white,
      fontSize: 22.w,
    );
  }

  orderIdStyle(){
    return TextStyle(
      color: ConstStyle.textBlackColor,
      fontWeight: FontWeight.bold,
      fontSize:54.sp,
    );
  }
  edgeInset20(){
    return const EdgeInsets.all(20);
  }
  sizedBox10(){
    return const SizedBox(height: 10,);
  }
  styleOrderBarNumber(){
    return TextStyle(
      color: ConstStyle.textWhiteColor,
      fontFamily: ConstStyle.poppins,
      fontSize: 50.sp,
      letterSpacing: 3,
      fontWeight: FontWeight.w900,
    );
  }
  styleOrderBarName(){
    return  TextStyle(
      color: ConstStyle.textWhiteColor,
      fontSize: 54.sp,
      fontWeight: FontWeight.w900,
    );
  }
  dropDownTextStyle(){
    return
      TextStyle(fontSize: 50.sp,color: Colors.black);
  }
  String getFormattedDate(String date) {
    /// Convert into local date format.
    var localDate = DateTime.parse(date).toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());

    var outputFormat = DateFormat('dd-MM-yyyy HH:mm a');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

   loadingIndicator(){
     return const Center(
       child: CircularProgressIndicator(
         color:Colors.red,
       ),
     );
   }
}