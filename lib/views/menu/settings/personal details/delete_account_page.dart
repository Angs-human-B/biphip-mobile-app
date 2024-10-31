import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/const.dart';
import '../../../../widgets/common/utils/common_simple_text.dart';
import '../../../../widgets/common/utils/custom_app_bar.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class DeleteAccount extends StatefulWidget {
  String title;
  String bodyText;
  DeleteAccount(this.title,this.bodyText, {Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  TextEditingController controller = TextEditingController();

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
          title: widget.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Normalext(widget.bodyText, color: Colors.black54,txtAlign: TextAlign.center,),
              SizedBox(height: 30,),
              Container(
                  width: 510.w+140.w,
                  height: 80.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: cLineColor),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: "Enter your Bip-Hip password",
                          border: InputBorder.none
                      ),
                      onChanged: (value){
                        setState(() {

                        });
                      },
                      onTap: (){
                      },
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: controller.text.isEmpty? Colors.black38: Colors.blue
          ),
          child: Normalext('Confirm', color: Colors.white,),
          onPressed: () {
          },
        ),
      ),

    );
  }
}
