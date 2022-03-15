import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haji_baba_manager/Provider/dashboard_provider.dart';
import 'package:haji_baba_manager/Provider/internet_provider.dart';
import 'package:haji_baba_manager/Provider/order_detail_provider.dart';
import 'package:haji_baba_manager/Provider/order_screen_provider.dart';
import 'package:haji_baba_manager/Provider/status_provider.dart';
import 'package:haji_baba_manager/Utils/const_style.dart';
import 'package:haji_baba_manager/Utils/const_text.dart';
import 'package:haji_baba_manager/Widgets/bottom_navigation_bar/Portrait_bottom_navigation_bar/portrait_bottom_navigation_bar_main.dart';
import 'package:haji_baba_manager/Widgets/side_menu_bar/portrait_side_bar/portrait_side_bar.dart';
import 'package:haji_baba_manager/Widgets/side_menu_bar/side_menu_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PortraitOrderScreen extends StatelessWidget {
  PortraitOrderScreen({Key key}) : super(key: key);

  // internet provider is the instance of  internet connection class
  // refresh controller is the  the controller of smart resfresher (use for pagination)
  // TextEditingController is the controller of search

  //InternetProvider internetProvider = InternetProvider();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // calling to internet provider class to check the internet connection
    //status provider is the instance of status provider class to call api to get all status
    // which are display in dropdown button

    //internetProvider.internetChecker(context);

    final statusProvider = Provider.of<StatusProvider>(context, listen: false);
    statusProvider.getAllStatus(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        // the orderScreenAppBar is the function to display the app bar in the screen

        title: orderScreenAppBar(context),
        toolbarHeight: 350.h,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      drawer: const SideMenuBar(),
      body: Consumer<OrderProvider>(builder: (context, orderController, child) {
        return orderController.isLoading == 0
            ? SmartRefresher(
                enablePullUp: true,
                enablePullDown: false,
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text(
                        "↑ pull up load",
                        style: refresherTextStyle(),
                      );
                    } else if (mode == LoadStatus.loading) {
                      body = CupertinoActivityIndicator(
                        radius: 32.w,
                      );
                    } else if (mode == LoadStatus.failed) {
                      body = Text(
                        "Load Failed!",
                        style: refresherTextStyle(),
                      );
                    } else if (mode == LoadStatus.canLoading) {
                      body = Text(
                        "↑ pull up load",
                        style: refresherTextStyle(),
                      );
                    } else if (mode == LoadStatus.noMore) {
                      body = Text(
                        "No more Data",
                        style: refresherTextStyle(),
                      );
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                onLoading: () async {
                  if (orderController.showOrders == "all") {
                    orderController.refresh = refreshController;
                    orderController.allCurrentPage++;
                    orderController.getAllOrder(context);
                  } else if (orderController.showOrders == "pending") {
                    orderController.refresh = refreshController;
                    orderController.pendingCurrentPage++;
                    orderController.getPendingOrder(context);
                  } else if (orderController.showOrders == "processing") {
                    orderController.refresh = refreshController;
                    orderController.processingCurrentPage++;
                    orderController.getProcessingOrder(context);
                  } else if (orderController.showOrders == "ready") {
                    orderController.refresh = refreshController;
                    orderController.readyCurrentPage++;
                    orderController.getReadyForCollectionOrder(context);
                  } else if (orderController.showOrders == "complete") {
                    orderController.refresh = refreshController;
                    orderController.completeCurrentPage++;
                    orderController.getCompleteOrder(context);
                  } else if (orderController.showOrders == "today") {
                    orderController.refresh = refreshController;
                    orderController.todayCurrentPage++;
                    orderController.getTodayOrder(context);
                  }
                },
                controller: refreshController,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (orderController.showOrders == "pending")
                        pendingOrders(context)
                      else if (orderController.showOrders == "processing")
                        processingOrders(context)
                      else if (orderController.showOrders == "ready")
                        readyForCollectionOrders(context)
                      else if (orderController.showOrders == "complete")
                        completeOrders(context)
                      else if (orderController.showOrders == "all")
                        allOrders(context)
                      else if (orderController.showOrders == "today")
                        todayOrders(context),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.deepOrangeAccent,
                ),
              );
      }),
      bottomNavigationBar: PortraitBottomNavigationBar(),
    );
  }

  Widget orderScreenAppBar(BuildContext context) {
    final orderController = Provider.of<OrderProvider>(context);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
      ),
      child: Column(
        children: [
          // The first row is used for arrow back and all order text
          Container(
            height: 20.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // arrow back icon of app bar
              Consumer<DashboardProvider>(
                  builder: (context, controller, child) {
                return IconButton(
                    onPressed: () async {
                      controller.loading(1);
                      orderController.pageController('home');
                      Navigator.of(context).pushNamed('/dashBoardScreen');
                      await controller.getDashboardDetail(context);
                      controller.loading(0);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 52.w,
                    ));
              }),
              // container and expanded user for "All order" text alignment in the center
              // of the screen
              Expanded(
                child: Container(),
              ),
              Expanded(
                child:
                    // Status text  of the appBar
                    Consumer<OrderProvider>(
                        builder: (context, controller, child) {
                  return Text(
                      controller.showOrders == 'all'
                          ? "All Orders"
                          : controller.showOrders == "pending"
                              ? "Pending "
                              : controller.showOrders == 'processing'
                                  ? "Processing"
                                  : controller.showOrders == "ready"
                                      ? "Ready Orders"
                                      : controller.showOrders == "complete"
                                          ? "Complete"
                                          : controller.showOrders == "today"
                                              ? "Today Orders"
                                              : '',
                      style: TextStyle(
                        color: ConstStyle.textBlackColor,
                        fontFamily: ConstStyle.poppins,
                        fontSize: 52.w,
                        fontWeight: FontWeight.bold,
                      ));
                }),
              ),

              Expanded(
                child: Container(),
              ),
            ],
          ),
          Container(
            height: 20.h,
          ),
          Consumer<OrderProvider>(builder: (context, controller, child) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  //search bar
                  child: TextField(
                    style: TextStyle(fontSize: 34.w),
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {
                      if (controller.showOrders == 'all') {
                        controller.searchData(value);
                        controller.loading(1);
                        controller.getAllOrder(context);
                        controller.loading(0);
                      } else if (controller.showOrders == 'pending') {
                        controller.searchData(value);
                        controller.loading(1);
                        controller.getPendingOrder(context);
                        controller.loading(0);
                      } else if (controller.showOrders == 'processing') {
                        controller.searchData(value);
                        controller.loading(1);
                        controller.getProcessingOrder(context);
                        controller.loading(0);
                      } else if (controller.showOrders == 'ready') {
                        controller.searchData(value);
                        controller.loading(1);
                        controller.getReadyForCollectionOrder(context);
                        controller.loading(0);
                      } else if (controller.showOrders == 'complete') {
                        controller.searchData(value);
                        controller.loading(1);
                        controller.getCompleteOrder(context);
                        controller.loading(0);
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: ConstStyle.cardGreyColor,
                      filled: true,
                      hintText: ConstText.searchHintText,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 30.h, horizontal: 30.w),
                      hintStyle: TextStyle(
                          fontSize: 35.w, color: ConstStyle.textGreyColor),
                      prefixIcon: Padding(
                        //padding use for space between side and icon
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Icon(
                          Icons.search,
                          size: 52.w,
                          color: ConstStyle.textGreyColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                // filter image button of app bar
              ],
            );
          }),
          sizedBox20(),
        ],
      ),
    );
  }

  Widget allOrders(BuildContext context,) {
    return Consumer<OrderProvider>(builder: (context, controller, child) {
      return
        controller.allOrderList == null
          ? Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 500.w),
                  child: Text(
                    "No Order Found! ",
                    style:
                        TextStyle(fontSize: 50.sp, fontWeight: FontWeight.w500),
                  )),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.allOrderList.length,
              itemBuilder: (context, index) {
                String orderId = controller.allOrderList[index]['id'];
                return Padding(
                  // this padding is used for space between app bar , screen sides ,and this listview
                  padding: EdgeInsets.symmetric(
                    horizontal: 60.w,
                    vertical: 30.h,
                  ),
                  child: Container(
                    // this container is a the actual view of the order
                    // and the padding is user for space between widgets
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.h,
                      vertical: 25.w,
                    ),
                    decoration: BoxDecoration(
                        color: ConstStyle.cardWhiteColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    // this row is used for the widgets of the number , id , price , detail etc
                    child: Row(
                      children: [
                        // container is used for the number box
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.h, vertical: 50.h),
                          decoration: BoxDecoration(
                              color: ConstStyle.pinkColor,
                              // color: Colors.deepOrangeAccent.shade100,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            //  number of the order
                            child: Text(
                              "${controller.allOrderList[index]['storeOrderNumber']}",
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
                              //calling to order id text
                              Row(
                                children: [
                                  Text(
                                    ConstText.orderIdText,
                                    style: orderIdStyle(),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Text(
                                      "${controller.allOrderList[index]['refNumber']}",
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
                                      "${controller.allOrderList[index]['items']}",
                                      style: listTextStyle(),
                                    ),
                                  ),
                                ],
                              ),

                              sizedBox20(),
                              // date time text
                              Text(
                                "${getFormattedDate(controller.allOrderList[index]['orderTime'])}",
                                style: listTextStyle(),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        //price text
                        Padding(
                          padding: EdgeInsets.only(right: 70.w),
                          child: Text(
                            "£ ${controller.allOrderList[index]['grandTotal']}",
                            style: orderPriceStyle(),
                          ),
                        ),
                        SizedBox(width: 30.w),

                        // column is used for text info(pending or complete) and detail button
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Column(
                            children: [
                              // info text (pending or complete)
                              Text(
                                "${controller.allOrderList[index]['name']}",
                                style: orderStatusStyle(),
                              ),
                              sizedBox20(),
                              //  detail button
                              Consumer<OrderDetailProvider>(builder:
                                  (context, orderDetailController, child) {
                                return GestureDetector(
                                  child: Container(
                                    height: 60.h,
                                    width: 140.w,
                                    decoration: BoxDecoration(
                                      color: ConstStyle.greenColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        ConstText.detailButtonText,
                                        style: detailButtonTextStyle(),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    orderDetailController.loading(1);
                                    controller.pageController('all');
                                    Navigator.of(context)
                                        .pushNamed('/orderDetailScreen');
                                    await orderDetailController.getOrderDetail(
                                        context, orderId);
                                    orderDetailController.loading(0);
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                        Container(
                          width: 40.w,
                          height: 70,
                          child: Consumer<StatusProvider>(
                              builder: (context, statusController, child) {
                            //statusController.getAllStatus(context);
                            return PopupMenuButton(
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 50.w,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.sp),
                              ),
                              itemBuilder: (context) {
                                return statusController.statusList.map((item) {
                                  return PopupMenuItem<String>(
                                    child: Text(
                                      item['orderStatusList'],
                                      style: dropDownTextStyle(),
                                    ),
                                    value: item['id'].toString(),
                                  );
                                }).toList();
                              },
                              onSelected: (newValue) async {
                                int id = int.parse(newValue);
                                controller.loading(1);
                                await statusController.updateOrderStatus(
                                    id, orderId,context);
                                await controller.getAllOrder(context);
                                controller.loading(0);
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              });
    });
  }

  Widget pendingOrders(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, controller, child) {
      return controller.pendingList == null
          ? Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 500.w),
                  child: Text(
                    "No Order Found! ",
                    style:
                        TextStyle(fontSize: 50.sp, fontWeight: FontWeight.w500),
                  )),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.pendingList.length,
              itemBuilder: (context, index) {
                String orderId = controller.pendingList[index]['id'];
                return Padding(
                  // this padding is used for space between app bar , screen sides ,and this listview
                  padding: EdgeInsets.symmetric(
                    horizontal: 60.w,
                    vertical: 30.h,
                  ),
                  child: Container(
                    // this container is a the actual view of the order
                    // and the padding is user for space between widgets
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.h,
                      vertical: 25.w,
                    ),
                    decoration: BoxDecoration(
                        color: ConstStyle.cardWhiteColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    // this row is used for the widgets of the number , id , price , detail etc
                    child: Row(
                      children: [
                        // container is used for the number box
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.h, vertical: 50.h),
                          decoration: BoxDecoration(
                              color: ConstStyle.pinkColor,
                              // color: Colors.deepOrangeAccent.shade100,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            //  number of the order
                            child: Text(
                              "${controller.pendingList[index]['storeOrderNumber']}",
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
                              //calling to order id text
                              Row(
                                children: [
                                  Text(
                                    ConstText.orderIdText,
                                    style: orderIdStyle(),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Text(
                                      "${controller.pendingList[index]['refNumber']}",
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
                                      "${controller.pendingList[index]['items']}",
                                      style: listTextStyle(),
                                    ),
                                  ),
                                ],
                              ),

                              sizedBox20(),
                              // date time text
                              Text(
                                "${getFormattedDate(controller.pendingList[index]['orderTime'])}",
                                style: listTextStyle(),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        //price text
                        Padding(
                          padding: EdgeInsets.only(right: 70.w),
                          child: Text(
                            "£ ${controller.pendingList[index]['grandTotal']}",
                            style: orderPriceStyle(),
                          ),
                        ),
                        SizedBox(width: 30.w),

                        // column is used for text info(pending or complete) and detail button
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Column(
                            children: [
                              // info text (pending or complete)
                              Text(
                                "${controller.pendingList[index]['name']}",
                                style: orderStatusStyle(),
                              ),
                              sizedBox20(),
                              //  detail button
                              Consumer<OrderDetailProvider>(builder:
                                  (context, orderDetailController, child) {
                                return GestureDetector(
                                  child: Container(
                                    height: 60.h,
                                    width: 140.w,
                                    decoration: BoxDecoration(
                                      color: ConstStyle.greenColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        ConstText.detailButtonText,
                                        style: detailButtonTextStyle(),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    orderDetailController.loading(1);
                                    controller.pageController('pending');
                                    Navigator.of(context)
                                        .pushNamed('/orderDetailScreen');
                                    await orderDetailController.getOrderDetail(
                                        context, orderId);
                                    orderDetailController.loading(0);
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                        Container(
                          width: 40.w,
                          height: 70,
                          child: Consumer<StatusProvider>(
                              builder: (context, statusController, child) {
                            // statusController.getAllStatus(context);
                            return PopupMenuButton(
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 50.w,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.sp),
                              ),
                              itemBuilder: (context) {
                                return statusController.statusList.map((item) {
                                  return PopupMenuItem<String>(
                                    child: Text(
                                      item['orderStatusList'],
                                      style: dropDownTextStyle(),
                                    ),
                                    value: item['id'].toString(),
                                  );
                                }).toList();
                              },
                              onSelected: (newValue) async {
                                int id = int.parse(newValue);
                                controller.loading(1);
                                await statusController.updateOrderStatus(
                                    id, orderId,context);
                                await controller.getPendingOrder(context);
                                controller.loading(0);
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              });
    });
  }

  Widget processingOrders(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, controller, child) {
      return controller.processingList == null
          ? Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 500.w),
                  child: Text(
                    "No Order Found! ",
                    style:
                        TextStyle(fontSize: 50.sp, fontWeight: FontWeight.w500),
                  )),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.processingList.length,
              itemBuilder: (context, index) {
                String orderId = controller.processingList[index]['id'];
                return Padding(
                  // this padding is used for space between app bar , screen sides ,and this listview
                  padding: EdgeInsets.symmetric(
                    horizontal: 60.w,
                    vertical: 30.h,
                  ),
                  child: Container(
                    // this container is a the actual view of the order
                    // and the padding is user for space between widgets
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.h,
                      vertical: 25.w,
                    ),
                    decoration: BoxDecoration(
                        color: ConstStyle.cardWhiteColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    // this row is used for the widgets of the number , id , price , detail etc
                    child: Row(
                      children: [
                        // container is used for the number box
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.h, vertical: 50.h),
                          decoration: BoxDecoration(
                              color: ConstStyle.pinkColor,
                              // color: Colors.deepOrangeAccent.shade100,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            //  number of the order
                            child: Text(
                              "${controller.processingList[index]['storeOrderNumber']}",
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
                              //calling to order id text
                              Row(
                                children: [
                                  Text(
                                    ConstText.orderIdText,
                                    style: orderIdStyle(),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Text(
                                      "${controller.processingList[index]['refNumber']}",
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
                                      "${controller.processingList[index]['items']}",
                                      style: listTextStyle(),
                                    ),
                                  ),
                                ],
                              ),

                              sizedBox20(),
                              // date time text
                              Text(
                                "${getFormattedDate(controller.processingList[index]['orderTime'])}",
                                style: listTextStyle(),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        //price text
                        Padding(
                          padding: EdgeInsets.only(right: 70.w),
                          child: Text(
                            "£ ${controller.processingList[index]['grandTotal']}",
                            style: orderPriceStyle(),
                          ),
                        ),
                        SizedBox(width: 30.w),

                        // column is used for text info(pending or complete) and detail button
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Column(
                            children: [
                              // info text (pending or complete)
                              Text(
                                "${controller.processingList[index]['name']}",
                                style: orderStatusStyle(),
                              ),
                              sizedBox20(),
                              //  detail button
                              Consumer<OrderDetailProvider>(builder:
                                  (context, orderDetailController, child) {
                                return GestureDetector(
                                  child: Container(
                                    height: 60.h,
                                    width: 140.w,
                                    decoration: BoxDecoration(
                                      color: ConstStyle.greenColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        ConstText.detailButtonText,
                                        style: detailButtonTextStyle(),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    orderDetailController.loading(1);
                                    controller.pageController('processing');
                                    Navigator.of(context)
                                        .pushNamed('/orderDetailScreen');
                                    await orderDetailController.getOrderDetail(
                                        context, orderId);
                                    orderDetailController.loading(0);
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                        Container(
                          width: 40.w,
                          height: 70,
                          child: Consumer<StatusProvider>(
                              builder: (context, statusController, child) {
                            //  statusController.getAllStatus(context);
                            return PopupMenuButton(
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 50.w,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.sp),
                              ),
                              itemBuilder: (context) {
                                return statusController.statusList.map((item) {
                                  return PopupMenuItem<String>(
                                    child: Text(
                                      item['orderStatusList'],
                                      style: dropDownTextStyle(),
                                    ),
                                    value: item['id'].toString(),
                                  );
                                }).toList();
                              },
                              onSelected: (newValue) async {
                                int id = int.parse(newValue);
                                controller.loading(1);
                                await statusController.updateOrderStatus(
                                    id, orderId,context);
                                await controller.getProcessingOrder(context);
                                controller.loading(0);
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              });
    });
  }

  Widget readyForCollectionOrders(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, controller, child) {
      return controller.readyForCollectionList == null
          ? Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 500.w),
                  child: Text(
                    "No Order Found! ",
                    style:
                        TextStyle(fontSize: 50.sp, fontWeight: FontWeight.w500),
                  )),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.readyForCollectionList.length,
              itemBuilder: (context, index) {
                String orderId = controller.readyForCollectionList[index]['id'];
                return Padding(
                  // this padding is used for space between app bar , screen sides ,and this listview
                  padding: EdgeInsets.symmetric(
                    horizontal: 60.w,
                    vertical: 30.h,
                  ),
                  child: Container(
                    // this container is a the actual view of the order
                    // and the padding is user for space between widgets
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.h,
                      vertical: 25.w,
                    ),
                    decoration: BoxDecoration(
                        color: ConstStyle.cardWhiteColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    // this row is used for the widgets of the number , id , price , detail etc
                    child: Row(
                      children: [
                        // container is used for the number box
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.h, vertical: 50.h),
                          decoration: BoxDecoration(
                              color: ConstStyle.pinkColor,
                              // color: Colors.deepOrangeAccent.shade100,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            //  number of the order
                            child: Text(
                              "${controller.readyForCollectionList[index]['storeOrderNumber']}",
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
                              //calling to order id text
                              Row(
                                children: [
                                  Text(
                                    ConstText.orderIdText,
                                    style: orderIdStyle(),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Text(
                                      "${controller.readyForCollectionList[index]['refNumber']}",
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
                                      "${controller.readyForCollectionList[index]['items']}",
                                      style: listTextStyle(),
                                    ),
                                  ),
                                ],
                              ),

                              sizedBox20(),
                              // date time text
                              Text(
                                "${getFormattedDate(controller.readyForCollectionList[index]['orderTime'])}",
                                style: listTextStyle(),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        //price text
                        Padding(
                          padding: EdgeInsets.only(right: 70.w),
                          child: Text(
                            "£ ${controller.readyForCollectionList[index]['grandTotal']}",
                            style: orderPriceStyle(),
                          ),
                        ),
                        SizedBox(width: 30.w),

                        // column is used for text info(pending or complete) and detail button
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Column(
                            children: [
                              // order status
                              Text(
                                "${controller.readyForCollectionList[index]['name']}",
                                style: orderStatusStyle(),
                              ),
                              sizedBox20(),
                              //  detail button
                              Consumer<OrderDetailProvider>(builder:
                                  (context, orderDetailController, child) {
                                return GestureDetector(
                                  child: Container(
                                    height: 60.h,
                                    width: 140.w,
                                    decoration: BoxDecoration(
                                      color: ConstStyle.greenColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        ConstText.detailButtonText,
                                        style: detailButtonTextStyle(),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    orderDetailController.loading(1);
                                    controller.pageController('ready');
                                    Navigator.of(context)
                                        .pushNamed('/orderDetailScreen');
                                    await orderDetailController.getOrderDetail(
                                        context, orderId);
                                    orderDetailController.loading(0);
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                        Container(
                          width: 40.w,
                          height: 70,
                          child: Consumer<StatusProvider>(
                              builder: (context, statusController, child) {
                            // statusController.getAllStatus(context);
                            return PopupMenuButton(
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 50.w,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.sp),
                              ),
                              itemBuilder: (context) {
                                return statusController.statusList.map((item) {
                                  return PopupMenuItem<String>(
                                    child: Text(
                                      item['orderStatusList'],
                                      style: dropDownTextStyle(),
                                    ),
                                    value: item['id'].toString(),
                                  );
                                }).toList();
                              },
                              onSelected: (newValue) async {
                                int id = int.parse(newValue);
                                controller.loading(1);
                                await statusController.updateOrderStatus(
                                    id, orderId,context);
                                await controller
                                    .getReadyForCollectionOrder(context);
                                controller.loading(0);
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              });
    });
  }

  Widget completeOrders(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, controller, child) {
      return controller.completeList == null
          ? Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 500.w),
                  child: Text(
                    "No Order Found! ",
                    style:
                        TextStyle(fontSize: 50.sp, fontWeight: FontWeight.w500),
                  )),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.completeList.length,
              itemBuilder: (context, index) {
                String orderId = controller.completeList[index]['id'];
                return Padding(
                  // this padding is used for space between app bar , screen sides ,and this listview
                  padding: EdgeInsets.symmetric(
                    horizontal: 60.w,
                    vertical: 30.h,
                  ),
                  child: Container(
                    // this container is a the actual view of the order
                    // and the padding is user for space between widgets
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.h,
                      vertical: 25.w,
                    ),
                    decoration: BoxDecoration(
                        color: ConstStyle.cardWhiteColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    // this row is used for the widgets of the number , id , price , detail etc
                    child: Row(
                      children: [
                        // container is used for the number box
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.h, vertical: 50.h),
                          decoration: BoxDecoration(
                              color: ConstStyle.pinkColor,
                              // color: Colors.deepOrangeAccent.shade100,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            //  number of the order
                            child: Text(
                              "${controller.completeList[index]['storeOrderNumber']}",
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
                              //calling to order id text
                              Row(
                                children: [
                                  Text(
                                    ConstText.orderIdText,
                                    style: orderIdStyle(),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Text(
                                      "${controller.completeList[index]['refNumber']}",
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
                                      "${controller.completeList[index]['items']}",
                                      style: listTextStyle(),
                                    ),
                                  ),
                                ],
                              ),

                              sizedBox20(),
                              // date time text
                              Text(
                                "${getFormattedDate(controller.completeList[index]['orderTime'])}",
                                style: listTextStyle(),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        //price text
                        Padding(
                          padding: EdgeInsets.only(right: 70.w),
                          child: Text(
                            "£ ${controller.completeList[index]['grandTotal']}",
                            style: orderPriceStyle(),
                          ),
                        ),
                        SizedBox(width: 30.w),

                        // column is used for text info(pending or complete) and detail button
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Column(
                            children: [
                              // info text (pending or complete)
                              Text(
                                "${controller.completeList[index]['name']}",
                                style: orderStatusStyle(),
                              ),
                              sizedBox20(),
                              //  detail button
                              Consumer<OrderDetailProvider>(builder:
                                  (context, orderDetailController, child) {
                                return GestureDetector(
                                  child: Container(
                                    height: 60.h,
                                    width: 140.w,
                                    decoration: BoxDecoration(
                                      color: ConstStyle.greenColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        ConstText.detailButtonText,
                                        style: detailButtonTextStyle(),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    orderDetailController.loading(1);
                                    controller.pageController('complete');
                                    Navigator.of(context)
                                        .pushNamed('/orderDetailScreen');
                                    await orderDetailController.getOrderDetail(
                                        context, orderId);
                                    orderDetailController.loading(0);
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                        Container(
                          width: 40.w,
                          height: 70,
                          child: Consumer<StatusProvider>(
                              builder: (context, statusController, child) {
                            // statusController.getAllStatus(context);
                            return PopupMenuButton(
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 50.w,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.sp),
                              ),
                              itemBuilder: (context) {
                                return statusController.statusList.map((item) {
                                  return PopupMenuItem<String>(
                                    child: Text(
                                      item['orderStatusList'],
                                      style: dropDownTextStyle(),
                                    ),
                                    value: item['id'].toString(),
                                  );
                                }).toList();
                              },
                              onSelected: (newValue) async {
                                int id = int.parse(newValue);
                                controller.loading(1);
                                await statusController.updateOrderStatus(
                                    id, orderId,context);
                                await controller.getCompleteOrder(context);
                                controller.loading(0);
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              });
    });
  }

  Widget todayOrders(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, controller, child) {
      return controller.todayList == null
          ? Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 500.w),
                  child: Text(
                    "No Order Found! ",
                    style:
                        TextStyle(fontSize: 50.sp, fontWeight: FontWeight.w500),
                  )),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.todayList.length,
              itemBuilder: (context, index) {
                String orderId = controller.todayList[index]['id'];
                return Padding(
                  // this padding is used for space between app bar , screen sides ,and this listview
                  padding: EdgeInsets.symmetric(
                    horizontal: 60.w,
                    vertical: 30.h,
                  ),
                  child: Container(
                    // this container is a the actual view of the order
                    // and the padding is user for space between widgets
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.h,
                      vertical: 25.w,
                    ),
                    decoration: BoxDecoration(
                        color: ConstStyle.cardWhiteColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    // this row is used for the widgets of the number , id , price , detail etc
                    child: Row(
                      children: [
                        // container is used for the number box
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.h, vertical: 50.h),
                          decoration: BoxDecoration(
                              color: ConstStyle.pinkColor,
                              // color: Colors.deepOrangeAccent.shade100,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            //  number of the order
                            child: Text(
                              "${controller.todayList[index]['storeOrderNumber']}",
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
                              //calling to order id text
                              Row(
                                children: [
                                  Text(
                                    ConstText.orderIdText,
                                    style: orderIdStyle(),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Text(
                                      "${controller.todayList[index]['refNumber']}",
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
                                      "${controller.todayList[index]['items']}",
                                      style: listTextStyle(),
                                    ),
                                  ),
                                ],
                              ),

                              sizedBox20(),
                              // date time text
                              Text(
                                "${getFormattedDate(controller.todayList[index]['orderTime'])}",
                                style: listTextStyle(),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        //price text
                        Padding(
                          padding: EdgeInsets.only(right: 70.w),
                          child: Text(
                            "£ ${controller.todayList[index]['grandTotal']}",
                            style: orderPriceStyle(),
                          ),
                        ),
                        SizedBox(width: 30.w),

                        // column is used for text info(pending or complete) and detail button
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Column(
                            children: [
                              // info text (pending or complete)
                              Text(
                                "${controller.todayList[index]['name']}",
                                style: orderStatusStyle(),
                              ),
                              sizedBox20(),
                              //  detail button
                              Consumer<OrderDetailProvider>(builder:
                                  (context, orderDetailController, child) {
                                return GestureDetector(
                                  child: Container(
                                    height: 60.h,
                                    width: 140.w,
                                    decoration: BoxDecoration(
                                      color: ConstStyle.greenColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        ConstText.detailButtonText,
                                        style: detailButtonTextStyle(),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    orderDetailController.loading(1);
                                    controller.pageController('today');
                                    Navigator.of(context)
                                        .pushNamed('/orderDetailScreen');
                                    await orderDetailController.getOrderDetail(
                                        context, orderId);
                                    orderDetailController.loading(0);
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                        Container(
                          width: 40.w,
                          height: 70,
                          child: Consumer<StatusProvider>(
                              builder: (context, statusController, child) {
                            // statusController.getAllStatus(context);
                            return PopupMenuButton(
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 50.w,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.sp),
                              ),
                              itemBuilder: (context) {
                                return statusController.statusList.map((item) {
                                  return PopupMenuItem<String>(
                                    child: Text(
                                      item['orderStatusList'],
                                      style: dropDownTextStyle(),
                                    ),
                                    value: item['id'].toString(),
                                  );
                                }).toList();
                              },
                              onSelected: (newValue) async {
                                int id = int.parse(newValue);
                                controller.loading(1);
                                await statusController.updateOrderStatus(
                                    id, orderId,context);
                                await controller.getTodayOrder(context);
                                controller.loading(0);
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              });
    });
  }

//========================================================================================
  //methods

  String getFormattedDate(String date) {
    /// Convert into local date format.
    var localDate = DateTime.parse(date).toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());

    var outputFormat = DateFormat('dd-MM-yyyy HH:mm a');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  sizedBox20() {
    return SizedBox(height: 12.h);
  }

  listTextStyle() {
    return TextStyle(
        color: ConstStyle.textGreyColor,
        fontSize: 33.w,
        fontWeight: FontWeight.w600);
  }

  orderIdStyle() {
    return TextStyle(
      color: ConstStyle.textBlackColor,
      fontWeight: FontWeight.bold,
      fontSize: 40.w,
    );
  }

  orderNumberStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 52.w,
      fontFamily: ConstStyle.poppins,
      color: ConstStyle.textOrangeColor,
      //color: Colors.deepOrange
    );
  }

  dropDownTextStyle() {
    return TextStyle(
        fontSize: 40.sp,
        fontWeight: FontWeight.w500,
        fontFamily: ConstStyle.poppins,
        color: Colors.black);
  }

  orderPriceStyle() {
    return TextStyle(
      color: ConstStyle.textOrangeColor,
      fontWeight: FontWeight.w500,
      fontSize: 36.w,
    );
  }

  orderStatusStyle() {
    return TextStyle(
      color: ConstStyle.orangeColor,
      fontWeight: FontWeight.w700,
      fontSize: 30.w,
    );
  }

  detailButtonTextStyle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 34.w,
    );
  }

  refresherTextStyle() {
    return TextStyle(fontSize: 30.w, fontWeight: FontWeight.w500);
  }
}
