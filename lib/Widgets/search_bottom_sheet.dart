import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haji_baba_manager/Provider/order_screen_provider.dart';
import 'package:haji_baba_manager/Utils/const_style.dart';
import 'package:haji_baba_manager/Utils/const_text.dart';
import 'package:provider/provider.dart';
class SearchBottomSheet{

  // this class is used to when the user click on search icon of bottom navigation bar
  // when click on the search icon this bottom sheet will araise

  TextEditingController searchController=TextEditingController();
  showSearchBottomSheet(BuildContext context) {
   return
     showModalBottomSheet(
     shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.only(
             topLeft:Radius.circular(50.w)
             ,topRight:Radius.circular(50.w)
         )
     ),
     backgroundColor: ConstStyle.orangeColor,
     isScrollControlled: true,
     context: context,
     builder: (context) =>
         Padding(
           padding: EdgeInsets.only(
               top: MediaQuery.of(context).size.height>
                   MediaQuery.of(context).size.width?
               80.w:50.w,
           ),
           child: Container(
             height: MediaQuery.of(context).size.height>
                 MediaQuery.of(context).size.width?
             800.w:530.w,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.only(
                   topLeft:Radius.circular(50.w)
                   ,topRight:Radius.circular(50.w)
               ),
             ),
             child: Padding(
               padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height>
                   MediaQuery.of(context).size.width? 80.w:55.w,
                   horizontal: 50.w),
               child:
               SingleChildScrollView(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Consumer<OrderProvider>(
                       builder: (context,controller,child) {
                         return Container(
                           width: 950.w,
                           child: Row(
                             children: <Widget>[
                               Flexible(child: TextField(

                                  controller: searchController,
                                 style: TextStyle(fontSize:
                                 MediaQuery.of(context).size.height>
                                     MediaQuery.of(context).size.width? 36.w:30.w,
                                 ),
                                 keyboardType: TextInputType.text,
                                 textInputAction: TextInputAction.search,

                                 onChanged: (value) {
                                   if (controller.showOrders == 'all') {
                                     controller.searchData(value);
                                     controller.loading(1);
                                     controller.getAllOrder(context);
                                     controller.loading(0);
                                   }
                                   else if (controller.showOrders == 'pending') {
                                     controller.searchData(value);
                                     controller.loading(1);
                                     controller.getPendingOrder(context);
                                     controller.loading(0);
                                   }
                                   else if (controller.showOrders == 'processing') {
                                     controller.searchData(value);
                                     controller.loading(1);
                                     controller.getProcessingOrder(context);
                                     controller.loading(0);
                                   }
                                   else if (controller.showOrders == 'ready') {
                                     controller.searchData(value);
                                     controller.loading(1);
                                     controller.getReadyForCollectionOrder(context);
                                     controller.loading(0);
                                   }
                                   else if (controller.showOrders == 'complete') {
                                     controller.searchData(value);
                                     controller.loading(1);
                                     controller.getCompleteOrder(context);
                                     controller.loading(0);
                                   }
                                 },

                                 decoration: InputDecoration(
                                   fillColor: ConstStyle.cardGreyColor,
                                   filled: true,
                                   contentPadding: EdgeInsets.symmetric(
                                     vertical: 35.h,
                                     horizontal: 60.w,
                                   ),
                                   hintText: ConstText.searchHintText,
                                   hintStyle: TextStyle(
                                     fontSize:
                                     MediaQuery.of(context).size.height>
                                         MediaQuery.of(context).size.width?
                                     36.w:30.w,
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
                               ),
                             ],
                           ),
                         );
                       }
                     ),
                     SizedBox(height:MediaQuery.of(context).size.height>
                         MediaQuery.of(context).size.width?
                     50.w:25.w,),


                     Consumer<OrderProvider>(
                       builder: (context,controller,child) {
                         return GestureDetector(
                           child: Container(
                             height:
                               MediaQuery.of(context).size.height>
                               MediaQuery.of(context).size.width? 95.w:65.w,
                             width:
                               MediaQuery.of(context).size.height>
                               MediaQuery.of(context).size.width? 450.w:520.w,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(
                                 MediaQuery.of(context).size.height>
                                   MediaQuery.of(context).size.width?
                               50.w:80.w,),
                               color: ConstStyle.orangeColor,
                             ),
                             child: Center(child: Text("Search",
                               style: TextStyle(
                                 color: Colors.white,
                                 fontSize:
                                 MediaQuery.of(context).size.height>
                                     MediaQuery.of(context).size.width?
                                 38.w:32.w,
                                 fontWeight: FontWeight.w500,
                                 fontFamily: ConstStyle.poppins,
                               ),)),
                           ),
                           onTap: ()async{
                             if(controller.searchPage=='profile'
                             || controller.searchPage=='home'){
                               controller.loading(1);
                               controller.allCurrentPage=1;
                               controller.pageController("all");
                               Navigator.of(context).pushNamed('/orderScreen');
                               await controller.getAllOrder(context);
                               controller.loading(0);
                             }
                             else{
                               Navigator.of(context).pop();
                             }

                           },
                         );
                       }
                     ),
                   ],
                 ),
               ),
             ),
           ),
         ),
   );
  }
}