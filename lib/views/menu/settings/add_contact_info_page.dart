import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/constants/const.dart';
import '../../../widgets/common/utils/common_simple_text.dart';
import '../../../widgets/common/utils/custom_app_bar.dart';
import 'otp_page.dart';

class AddContactInfo extends StatefulWidget {
  String title;
  String type;
  String controllerTxt;
  bool edit;
  AddContactInfo(this.title,this.type, {this.controllerTxt = '',this.edit = false, Key? key}) : super(key: key);

  @override
  State<AddContactInfo> createState() => _AddContactInfoState();
}

class _AddContactInfoState extends State<AddContactInfo> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = widget.controllerTxt;
  }

  @override
  Widget build(BuildContext context) {
    var items = [
      'assets/images/Flag_of_Bangladesh.svg.png',
      'assets/images/Flag_of_the_United_States.svg.png',
      'assets/images/Flag_of_the_United_States.svg.png',
    ];
    String dropdownvalue = 'assets/images/Flag_of_Bangladesh.svg.png';
    bool onChangetxt = false;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kAppBarSizeSetting),
        child: CustomAppBar(
          onBack: () {
            Get.back();
            if(widget.controllerTxt == ''){
              Get.back();
            }
          },
          title: widget.title,
        ),
      ),
      body: Column(
        children: [
          widget.type == 'birthday'?
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Normalext("This birthday is used for the accounts and profiles in this Accounts Center. Any changes you make will apply to all of them.", color: Colors.black,),
          )
          : Container(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: widget.type == 'phone'?  Row(
              children: [
                Container(
                  width: 140.w,
                  height: 80.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                    border: Border.all(color: cLineColor)
                  ),
                  child: DropdownButton(
                    icon: const SizedBox.shrink(),
                    value: dropdownvalue,
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Image.asset(items, height: 50.h,),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
                Container(
                  width: 510.w,
                  height: 80.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                      border: Border.all(color: cLineColor)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: InputBorder.none
                      ),
                    ),
                  )
                ),
              ],
            ): widget.type == 'email'? Container(
                width: 510.w+140.w,
                height: 80.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: onChangetxt == true? Colors.white : cGreyBoxColor,
                    border: Border.all(color: cLineColor),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      prefixIcon: Icon(BipHip.mail, color: Colors.black87, size: 40.sp,),
                        hintText: "Email",
                        border: InputBorder.none
                    ),
                    onChanged: (value){

                    },
                    onTap: (){
                      setState(() {
                        onChangetxt = true;
                      });
                    },
                  ),
                )
            ): Container(
                width: 510.w+140.w,
                height: 80.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: onChangetxt == true? Colors.white : cGreyBoxColor,
                    border: Border.all(color: cLineColor),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        prefixIcon: Icon(BipHip.birthday, color: Colors.black54, size: 40.sp,),
                        hintText: "Enter Birthday",
                        border: InputBorder.none
                    ),
                    onChanged: (value){

                    },
                    onTap: (){
                      setState(() {
                        onChangetxt = true;
                      });
                    },
                  ),
                )
            ),
          ),
        ],
      ),
        bottomNavigationBar: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
          child: ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // widget.type == 'birthday'? Icon(BipHip.edit, size: 30.sp,): Container(),
                // SizedBox(width: 20.w,),
                Normalext(widget.type == 'birthday' && !widget.edit? 'Edit': 'Save', color: Colors.white,),
              ],
            ),
            onPressed: () {
              if(widget.type == 'birthday'){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddContactInfo("Edit birthday", 'birthday', controllerTxt: "January 01, 2000",edit: true,)));
                // Get.to();
                // Get.to(OTP(widget.type == 'phone'?  '+8801993-144278': 'sa*******ai@***.com'));

              }
              else{
                Get.to(OTP(widget.type == 'phone'?  '+8801993-144278': 'sa*******ai@***.com'));

              }
            },
          ),
        )
    );
  }
}
