import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:haji_baba_manager/Utils/const_style.dart';

class ConnectionCheckerDialog{
  showConnectionDialog(BuildContext context, ) {
    AlertDialog alert = AlertDialog(
      backgroundColor: ConstStyle.cardGreyColor,
      shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(20.w),
      ),
      title:   Padding(
        padding: EdgeInsets.all( MediaQuery.of(context).size.height>
            MediaQuery.of(context).size.height?40.w:20.w,),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height>
                MediaQuery.of(context).size.width?50.w:20.w,),

            Image.asset('assets/images/errorImage.png',
              height: MediaQuery.of(context).size.height>
                  MediaQuery.of(context).size.width?140.w:180.w,
             width: MediaQuery.of(context).size.height>
                  MediaQuery.of(context).size.width?140.w:180.w,),

            SizedBox(height: MediaQuery.of(context).size.height>
                MediaQuery.of(context).size.width?50.w:30.w,),

            Text("Network Error",style:TextStyle(
                fontSize: MediaQuery.of(context).size.height>
                MediaQuery.of(context).size.width?50.w:40.w,
                color: Colors.red,
                fontWeight: FontWeight.w700
            )),
            SizedBox(height: MediaQuery.of(context).size.height>
                MediaQuery.of(context).size.width?30.w:30.w,),

            Text("Check your internet connection",style:TextStyle(
                fontSize: MediaQuery.of(context).size.height>
                MediaQuery.of(context).size.width?40.w:30.w,

                color: Colors.red,
                fontWeight: FontWeight.w500
            )),
            SizedBox(height: MediaQuery.of(context).size.height>
                MediaQuery.of(context).size.width?50.w:36.w,
            ),
            GestureDetector(
              child: Container(
                height: MediaQuery.of(context).size.height>
                  MediaQuery.of(context).size.width?100.w:80.w,

                width: MediaQuery.of(context).size.height>
                  MediaQuery.of(context).size.width?300.w:240.w,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.w),
                  color: ConstStyle.orangeColor,
                ),
                child: Center(child: Text("Ok",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:MediaQuery.of(context).size.height>
                      MediaQuery.of(context).size.width?50.w:36.w,
                    fontWeight: FontWeight.w500,
                    fontFamily: ConstStyle.poppins,
                  ),)),
              ),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height>
                MediaQuery.of(context).size.width?80.w:50.w,),

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
}