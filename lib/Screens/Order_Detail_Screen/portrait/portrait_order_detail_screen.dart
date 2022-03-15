import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haji_baba_manager/Provider/order_detail_provider.dart';
import 'package:haji_baba_manager/Utils/const_style.dart';
import 'package:haji_baba_manager/Utils/const_text.dart';
import 'package:haji_baba_manager/Widgets/bottom_navigation_bar/Portrait_bottom_navigation_bar/portrait_bottom_navigation_bar_main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class PortraitOrderDetailScreen extends StatelessWidget {
  PortraitOrderDetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ConstStyle.cardGreyColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ConstStyle.cardWhiteColor,
        toolbarHeight: 250.h,
        leadingWidth: 200.w,
        // app bar arrow back icon
        leading: MaterialButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/orderScreen');
          },
          child: Icon(Icons.arrow_back,
            color: Colors.black,
            size: 80.sp,
          ),
        ),
        //  title of the app bar
        title:
        Consumer<OrderDetailProvider>(
          builder: (context,controller,child) {
            return Text("${ConstText.orderIdText}"
                "${controller.orderDetail['refNumber']==null
                ? "" :controller.orderDetail['refNumber']}",
              style:orderIdStyle(),
            );
          }
        ),

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 60.w,
          vertical: 50.h,
        ),
        child:
              Consumer<OrderDetailProvider>(
              builder: (context,controller,child) {
                double total=0;
                return controller.isLoading==0 ?
                ListView(
                  children: [
                    // list view is used to show all detail in list
                    // calling to order item list
                    orderItem(context,controller, total),
                    sizedBox60(),
                    // calling to order detail
                    orderDetail(context,controller),
                    sizedBox60(),
                    //calling customer detail
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
      //PortraitBottomNavigationBar is a class in which i define the bottom navigation bar
      bottomNavigationBar:  PortraitBottomNavigationBar(),
    );
  }

  // in this detail screen here is 6 types of detail about order
  // order item is the list of all item of the order
  // order detail is the detail of the order
  // customer detail is the detail of the customer
  // billing detail is the detail of the  the order
  // paymentInformation is the detail of the payment method
  // orderSummery is the detail of the order summery

  Widget orderItem(BuildContext context,OrderDetailProvider controller, double total,) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // calling to order item text
            Text(ConstText.orderItemText,
                style:orderDetailTitleStyle()
            ),
            sizedBox60(),
            // card is used for to show list in the card view
            Card(
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey.shade300,
                      width: 3
                  )),
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
                        (index % 2 == 0) ? ConstStyle.cardWhiteColor: ConstStyle.cardGreyColor ,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 30.h,
                            horizontal:30.w),
                        child: Row(
                          children: [
                            // image padding
                            Padding(
                                padding: EdgeInsets.only(
                                  left:  20.w,
                                  right:  40.h,
                                  top: 20.sp,
                                  bottom: 20.sp,
                                ),
                                 child: Container(
                                  height: 180.h,
                                  width: 160.w,
                                  decoration:BoxDecoration(
                                      color: ConstStyle.textOrangeColor,
                                      borderRadius: BorderRadius.circular(40.0.sp),
                                      // image: DecorationImage(
                                      //     fit: BoxFit.cover,
                                      //     //image:NetworkImage('${controller.productDetailList[index]['prodcutImg']}'),
                                      //   image:NetworkImage('http://hajibabaadmin.asollearning.com/ProductImages/HajiBabaEntities.ProductImage'),
                                      // ),
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
                                        //"${productList[index]['productTitle']}",
                                        style: listBlackTextStyle(),                                  ),
                                      TextSpan(
                                        text: "- 1KG",
                                        style: orderNameTextStyle(),

                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
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
                              child: Container(width: 100.sp,),
                            ),
                            Expanded(
                              child: Container(width: 100.sp,),
                            ),

                            Expanded(
                              //  price of the item
                              child: Text("£ ${total}",
                                  style: TextStyle(
                                    color: ConstStyle.textOrangeColor,
                                    fontFamily: ConstStyle.poppins,
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
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
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical:10.h,
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

                        // order date and time text
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
                        SizedBox(
                            height: 30.h
                        ),
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
                        SizedBox(height: 30.h,),
                        Container(height: 1.5,color:Colors.grey.shade500,
                        width: MediaQuery.of(context).size.width,),
                        SizedBox(height: 30.h,),
                        //  total text
                        Row(children: [
                          Text(ConstText.totalOrderText,
                            style:
                             TextStyle(
                          color: ConstStyle.textOrangeColor,
                          fontFamily: ConstStyle.poppins,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        )
                          ),
                          Expanded(child: Container()),
                          Text("£ ${controller.orderDetail['total']}",
                              style: TextStyle(
                                color: ConstStyle.textOrangeColor,
                                fontFamily: ConstStyle.poppins,
                                fontSize: 40.sp,
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

  Widget customerDetail(BuildContext context,OrderDetailProvider controller) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 30.h,
              ),
              child: Text(ConstText.customerDetailText,
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
                          Text(
                            ConstText.customerNameText,
                            style:
                            listBlackTextStyle(),
                          ),
                          Expanded(child: Container()),
                          Text("${controller.orderDetail["customerName"]}",
                              style: TextStyle(
                                color: ConstStyle.textBlackColor,
                                fontFamily: ConstStyle.poppins,
                                fontSize:40.sp,
                                fontWeight: FontWeight.bold,
                              )
                          )
                        ]),
                        SizedBox(height: 20.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 20.h,
                          ),
                          child: Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        SizedBox(height: 30.h,),
                        // click and collect text
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
                              const  SizedBox(
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

  Widget billingDetail(BuildContext context,OrderDetailProvider controller) {
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 30.h,
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
                                fontSize:40.sp,
                                fontWeight: FontWeight.bold,
                              ))
                        ]),
                        SizedBox(height: 20.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 20.h,
                          ),
                          child: Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        //  billing address text
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(ConstText.billingAddressText,
                                style:
                                listBlackTextStyle(),
                              ),
                              const  SizedBox(
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

  Widget paymentInformation(BuildContext context,OrderDetailProvider controller) {
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 30.h,
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
                          style: orangeTextStyle(),
                      )
                    ]),
                  )),
            )
          ],
        );

  }

  Widget orderSummery(BuildContext context,OrderDetailProvider controller) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
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
                        //subtotal
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
                            style:orangeTextStyle(),
                          ),
                          Expanded(child: Container()),
                          Text("£ ${controller.orderDetail['grandTotal']}",

                            style: orangeTextStyle(),
                          )
                        ]),
                      ],
                    ),
                  )),
            )
          ],
        );

  }

// getFormattedDate is a function to format the data style
// orderDetailTitleStyle  is the style of titles of the detail
// orderNameTextStyle is the style of  order name
// listBlackTextStyle is the style of  which are the text is black in detail
// listGreyTextStyle is the style of  which are the text is grey in detail
// sizedBox60  is used for space between widgets
// paddingSpace is used for padding
// addressStyle  is the style of  address of the user detail
// orderIdStyle  is the style of  order id text style
// orangeTextStyle is the style of orange color text

  String getFormattedDate(String date) {
    /// Convert into local date format.
    var localDate = DateTime.parse(date).toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());

    var outputFormat = DateFormat('dd-MM-yyyy HH:mm a');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }
  orderDetailTitleStyle(){
    return  TextStyle(
      color: ConstStyle.textBlackColor,
      fontFamily: ConstStyle.poppins,
      fontSize: 46.sp,
      fontWeight: FontWeight.w700,
    );
  }
  orderNameTextStyle(){
    return TextStyle(
      color: ConstStyle.textGreyColor,
      fontFamily: ConstStyle.poppins,
      fontSize: 40.sp,
      fontWeight: FontWeight.bold,
    );
  }
  listBlackTextStyle(){
    return TextStyle(
      color: ConstStyle.textBlackColor,
      fontFamily: ConstStyle.poppins,
      fontSize: 40.sp,
      fontWeight: FontWeight.bold,
    );
  }
  listGreyTextStyle(){
    return TextStyle(
      color: ConstStyle.textGreyColor,
      fontFamily: ConstStyle.poppins,
      fontSize: 40.sp,
      fontWeight: FontWeight.bold,
    );
  }
  sizedBox60(){
    return SizedBox(height: 50.h,);
  }
  paddingSpace(){
    return EdgeInsets.symmetric(
        horizontal: 40.sp,
        vertical: 60.h);
  }
  addressStyle(){
    return TextStyle(
      color: ConstStyle.textGreyColor,
      fontFamily: ConstStyle.poppins,
      fontSize: 40.sp,
      fontWeight: FontWeight.w500,
    );
  }
  orderIdStyle(){
    return  TextStyle(
      color: ConstStyle.textBlackColor,
      fontFamily: ConstStyle.poppins,
      fontSize: 60.sp,
      fontWeight: FontWeight.bold,
    );
  }
  orangeTextStyle(){
    return TextStyle(
      color: ConstStyle.textOrangeColor,
      fontFamily: ConstStyle.poppins,
      fontSize: 40.sp,
      fontWeight: FontWeight.bold,
    );
  }
}
