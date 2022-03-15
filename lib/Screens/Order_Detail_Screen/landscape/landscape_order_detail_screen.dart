import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haji_baba_manager/Provider/order_detail_provider.dart';
import 'package:haji_baba_manager/Utils/const_style.dart';
import 'package:haji_baba_manager/Utils/const_text.dart';
import 'package:haji_baba_manager/Widgets/bottom_navigation_bar/Landscape_bottom_navigation_bar/landscape_bottom_navigation_bar.dart';
import 'package:haji_baba_manager/Widgets/side_menu_bar/side_menu_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LandscapeOrderDetailScreen extends StatelessWidget {
   LandscapeOrderDetailScreen({Key key}) : super(key: key);

   //InternetProvider internetProvider=InternetProvider();

  @override
  Widget build(BuildContext context) {
    //internetProvider.internetChecker(context);
    return  Scaffold(
      backgroundColor: ConstStyle.cardGreyColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:ConstStyle.cardWhiteColor,
        toolbarHeight: 400.h,
        leadingWidth: 200.w,
        // app bar arrow back icon
        leading: MaterialButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/orderScreen');
          },
          child: Icon(Icons.arrow_back,
            color: Colors.black,
            size: 100.sp,
          ),
        ),
        // title of the app bar
        title:
        Consumer<OrderDetailProvider>(
            builder: (context,controller,child) {
              return Text("${ConstText.orderIdText}${controller.orderDetail['refNumber']==null?"":controller.orderDetail['refNumber']}",
                style:orderIdStyle(),
              );
            }
        ),
      ),
      drawer: SideMenuBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 80.w,
          vertical: 80.h,
        ),
        // list view is used to show all detail in list
        child:
              Consumer<OrderDetailProvider>(
                builder: (context,controller,child) {
                  double total=0;
                  return controller.isLoading==0 ?
                  ListView(
                  children: [
                    // calling to order item list
                    orderItem(context,controller, total),
                    sizedBox60(),
                    // calling to order detail
                    orderDetail(context,controller),
                    sizedBox60(),
                    // calling to customer detail
                    customerDetail(context,controller),
                    sizedBox60(),
                    // calling to billing
                    billingDetail(context,controller),
                    sizedBox60(),
                    // calling to payment information
                    paymentInformation(context,controller),
                    sizedBox60(),
                    // calling to order summery
                    orderSummery(context,controller),
                  ],
                )
                      : const Center(
                        child: CircularProgressIndicator(
                      color: Colors.deepOrangeAccent,
                    ),
                  );
              }
            ),
      ),
      bottomNavigationBar: LandscapeBottomNavigationBar(),
    );
  }

  Widget orderItem(BuildContext context,OrderDetailProvider controller, double total,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // order item text
        Text(ConstText.orderItemText,
            style:orderDetailTitleStyle()
        ),
        sizedBox60(),
        // card is used for to show list in the card view
        Card(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(color: Colors.grey.shade300,  width: 3)),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.productDetailList.length,
              itemBuilder: (context, index) {
                total=controller.productDetailList[index]['quanitty']*controller.productDetailList[index]['price'];
                return Container(
                  // evey thing will be see in  container
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color:
                    (index % 2 == 0) ? ConstStyle.cardWhiteColor : ConstStyle.cardGreyColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 40.h,
                        horizontal: 10.w),
                    child: Row(
                      children: [
                        // image
                        Padding(
                            padding: EdgeInsets.only(
                              left:  20.w,
                              right:  20.w,
                            ),
                            child: Container(
                              height: 300.sp,
                              width: 280.sp,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.0.sp),
                                //  image: DecorationImage(
                                    // image: DecorationImage(
                                    //     fit: BoxFit.cover,
                                    //     //image:NetworkImage('${controller.productDetailList[index]['prodcutImg']}'),
                                    //   image:NetworkImage('http://hajibabaadmin.asollearning.com/ProductImages/HajiBabaEntities.ProductImage'),
                                    // ),
                                  //)
                              ),
                            )
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // name of the item
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                   text:"${controller.productDetailList[index]['productTitle']} ",
                                    style:listBlackTextStyle(),
                                  ),
                                  TextSpan(
                                    text: "- 1KG",
                                    style: orderNameTextStyle(),

                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            //  price  multiplication
                            Text("${controller.productDetailList[index]['quanitty']} " "x"
                                " £"
                                " ${controller.productDetailList[index]['price']} ",
                              style: orderNameTextStyle(),
                            ),
                          ],
                        ),
                        // expanded is used for alignment
                        Expanded(
                          child: Container(),
                        ),

                        Expanded(
                          //  name of the item
                          child: Text("£ ${total}",
                              style: TextStyle(
                                color:ConstStyle.textOrangeColor,
                                fontFamily: ConstStyle.poppins,
                                fontSize: 70.sp,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }

  Widget orderDetail(BuildContext context, OrderDetailProvider controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical:20.h,
          ),
          child:
          Text(ConstText.orderDetailText,
            style: orderDetailTitleStyle(),
          ),
        ),
        sizedBox60(),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 2,
          child: Container(
              decoration: BoxDecoration(
                  color: ConstStyle.cardWhiteColor,
                  borderRadius: BorderRadius.circular(30.0)),
              child: Padding(
                padding: paddingSpace(),
                child: Column(
                  children: [

                    // calling to order date and time text
                    Row(children: [
                      Text(ConstText.orderDateText,
                        style:
                        listBlackTextStyle(),
                      ),
                      Expanded(child: Container()),
                      Text(
                        "${getFormattedDate(controller.orderDetail['orderTime'])}",
                        style: listGreyTextStyle(),
                      )
                    ]),
                    SizedBox(height: 40.h,),
                    // order id
                    Row(children: [
                      Text(ConstText.orderIdText,
                        style:
                        listBlackTextStyle(),
                      ),
                      Expanded(child: Container()),
                      Text("${controller.orderDetail['refNumber']}",
                        style:
                        listGreyTextStyle(),
                      )
                    ]),
                    SizedBox(height: 40.h,),
                    Container(height: 1.5,color:Colors.grey.shade500,
                      width: MediaQuery.of(context).size.width,),
                    SizedBox(height: 40.h,),
                    // total text
                    Row(children: [
                      Text(ConstText.totalOrderText,
                        style:
                        TextStyle(
                          color: ConstStyle.textOrangeColor,
                          fontFamily: ConstStyle.poppins,
                          fontSize: 70.sp,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      Expanded(child: Container()),
                      Text("£ ${controller.orderDetail['total']}",
                        style:
                        TextStyle(
                          color: ConstStyle.textOrangeColor,
                          fontFamily: ConstStyle.poppins,
                          fontSize: 70.sp,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ]),
                  ],
                ),
              )),
        )
      ],
    );
  }

  Widget customerDetail(BuildContext context, OrderDetailProvider controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 50.h,
          ),
          child:Text(ConstText.customerDetailText,
            style:
            orderDetailTitleStyle(),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 2,
          child: Container(
              decoration: BoxDecoration(
                  color: ConstStyle.cardWhiteColor,
                  borderRadius: BorderRadius.circular(30.0)),
              child: Padding(
                padding:paddingSpace(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // order status text
                    Row(children: [
                      Text( ConstText.customerNameText,
                        style:
                        listBlackTextStyle(),
                      ),
                      Expanded(child: Container()),
                      Text("${controller.orderDetail["customerName"]}",
                          style: TextStyle(
                            color: ConstStyle.greenColor,
                            fontFamily: ConstStyle.poppins,
                            fontSize:60.sp,
                            fontWeight: FontWeight.bold,
                          ))
                    ]),
                    SizedBox(height: 40.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20.h,
                      ),
                      child: Container(
                        height: 1.5,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    //  click and collect text
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ConstText.customerEmailText,
                             style:
                              listBlackTextStyle(),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${controller.orderDetail['customerEmail']}",
                            style:
                            addressStyle(),
                          )
                        ]),
                    SizedBox(
                      height: 30.h,
                    ),
                    //  billing address text
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ConstText.customerPhoneText,
                            style:
                            listBlackTextStyle(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${controller.orderDetail['customerPhone']}",
                            style:
                            addressStyle(),
                          )
                        ]),
                  ],
                ),
              )),
        )
      ],
    );
  }

  Widget billingDetail(BuildContext context, OrderDetailProvider controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 50.h,
          ),
          child: Text(ConstText.billingDetailText,
            style:
            orderDetailTitleStyle(),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 2,
          child: Container(
              decoration: BoxDecoration(
                  color: ConstStyle.cardWhiteColor,
                  borderRadius: BorderRadius.circular(30.0)),
              child: Padding(
                padding:paddingSpace(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // order status text
                    Row(children: [
                      Text(ConstText.orderStatusText,
                        style:
                        listBlackTextStyle(),
                      ),
                      Expanded(child: Container()),
                      Text("${controller.orderDetail['orderStatus']}",
                          style: TextStyle(
                            color: ConstStyle.greenColor,
                            fontFamily: ConstStyle.poppins,
                            fontSize:60.sp,
                            fontWeight: FontWeight.bold,
                          ))
                    ]),
                    SizedBox(height: 40.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20.h,
                      ),
                      child: Container(
                        height: 1.5,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    SizedBox(height: 30.h,),

                    //  billing address text
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ConstText.billingAddressText,
                            style:
                            listBlackTextStyle(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${controller.orderDetail['street']} "
                                "${controller.orderDetail['code']} "
                                "${controller.orderDetail['city']} "
                                "${controller.orderDetail['country']} "
                                "${controller.orderDetail['address']} "
                            ,
                            style:
                            addressStyle(),
                          )
                        ]),
                  ],
                ),
              )),
        )
      ],
    );
  }

  Widget paymentInformation(BuildContext context, OrderDetailProvider controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 50.h,
          ),
          child:
          Text(ConstText.paymentInformationText,
            style:orderDetailTitleStyle(),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 2,
          child: Container(
              decoration: BoxDecoration(
                  color:ConstStyle.cardWhiteColor,
                  borderRadius: BorderRadius.circular(30.0)),
              child: Padding(
                padding: paddingSpace(),
                child:
                // billing method text
                Row(children: [
                  Text(ConstText.paymentMethodText,
                    style:
                    listBlackTextStyle(),
                  ),
                  Expanded(child: Container()),
                  Text( "${controller.orderDetail['paymentMethod']}",
                      style: TextStyle(
                        color: ConstStyle.textOrangeColor,
                        fontFamily: ConstStyle.poppins,
                        fontSize: 70.sp,
                        fontWeight: FontWeight.bold,
                      ))
                ]),
              )),
        )
      ],
    );
  }

  Widget orderSummery(BuildContext context, OrderDetailProvider controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 50.h),
          child: Text(
            ConstText.orderSummeryText,
            style:
            orderDetailTitleStyle(),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 2,
          child: Container(
              decoration: BoxDecoration(
                  color: ConstStyle.cardWhiteColor,
                  borderRadius: BorderRadius.circular(30.0)),
              child: Padding(
                padding: paddingSpace(),
                child: Column(
                  children: [
                    //calling to subtotal
                    Row(children: [
                      Text(ConstText.subTotalText,
                        style:
                        listBlackTextStyle(),
                      ),
                      Expanded(child: Container()),
                      Text("£ ${controller.orderDetail['total']}",
                        style:listGreyTextStyle(),)
                    ]),
                    SizedBox(
                        height:30.h
                    ),
                    // click and collect summery
                    Row(children: [
                      Text(ConstText.discountText,
                        style: listBlackTextStyle(),
                      ),
                      Expanded(child: Container()),
                      Text("£ ${controller.orderDetail['discount']}",
                          style: listGreyTextStyle()
                      )
                    ]),
                    SizedBox(height: 30.h),
                    // total amount
                    Row(children: [
                      Text(ConstText.totalAmountText,
                        style: TextStyle(
                          color: ConstStyle.orangeColor,
                          fontFamily: ConstStyle.poppins,
                          fontSize: 70.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(child: Container()),
                      Text("£ ${controller.orderDetail['grandTotal']}",
                        style: TextStyle(
                          color: ConstStyle.orangeColor,
                          fontFamily: ConstStyle.poppins,
                          fontSize: 70.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ]),
                  ],
                ),
              )),
        )
      ],
    );
  }

  orderDetailTitleStyle(){
    return  TextStyle(
      color: ConstStyle.textBlackColor,
      fontFamily: ConstStyle.poppins,
      fontSize: 80.sp,
      fontWeight: FontWeight.bold,
    );
  }

  orderNameTextStyle(){
    return TextStyle(
      color: ConstStyle.textGreyColor,
      fontFamily: ConstStyle.poppins,
      fontSize: 70.sp,
      fontWeight: FontWeight.bold,
    );
  }

  listBlackTextStyle(){
    return TextStyle(
      color: ConstStyle.textBlackColor,
      fontFamily: ConstStyle.poppins,
      fontSize: 70.sp,
      fontWeight: FontWeight.bold,
    );
  }

  listGreyTextStyle(){
    return TextStyle(
      color: ConstStyle.textGreyColor,
      fontFamily: ConstStyle.poppins,
      fontSize: 70.sp,
      fontWeight: FontWeight.bold,
    );
  }

  sizedBox60(){
    return SizedBox(height: 60.h,);
  }

  paddingSpace(){
    return EdgeInsets.symmetric(
        horizontal: 140.sp,
        vertical: 80.h);
  }

  addressStyle(){
    return TextStyle(
      color: ConstStyle.textGreyColor,
      fontFamily: ConstStyle.poppins,
      fontSize: 70.sp,
      fontWeight: FontWeight.w500,
    );
  }
  orderIdStyle(){
    return TextStyle(
      color: ConstStyle.textBlackColor,
      fontFamily: ConstStyle.poppins,
      fontSize: 80.sp,
      fontWeight: FontWeight.bold,
    );
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
}
