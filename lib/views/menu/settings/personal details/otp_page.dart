import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/const.dart';
import '../../../../widgets/common/utils/common_simple_text.dart';
import '../../../../widgets/common/utils/custom_app_bar.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTP extends StatefulWidget {
  String sendTo;
  OTP(this.sendTo, {Key? key}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kAppBarSizeSetting),
          child: CustomAppBar(
            onBack: () {
              Get.back();
            },
            title: "OTP Verification",
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Normalext("Enter the verification code. We just sent a code to your phone number +${widget.sendTo}", color: Colors.black54,txtAlign: TextAlign.center,),
                SizedBox(height: 30,),
                OtpTextField(
                  numberOfFields: 4,
                  fieldWidth: 120.w,
                  margin: EdgeInsets.only(right: 40.w),
                  borderColor: Color(0xFF512DA8),
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode){
                    showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: Text("Verification Code"),
                            content: Text('Code entered is $verificationCode'),
                          );
                        }
                    );
                  }, // end onSubmit
                ),
                SizedBox(height: 740.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
                  child: Container(
                    width: 800.w,
                    child: ElevatedButton(
                      child: Normalext('Confirm', color: Colors.white,),
                      onPressed: () {
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Normalext("Didn’t receive code? Resend", color: Colors.black54,),
                    Normalext(" Resend", color: Colors.blue,),
                  ],
                ),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ),

    );
  }
}
