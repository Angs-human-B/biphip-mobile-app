import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/change%20password/password_and_security_page.dart';
import 'package:bip_hip/views/menu/settings/change%20password/personal_details_page.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/const.dart';
import '../../../../widgets/common/utils/common_simple_text.dart';
import '../../../../widgets/common/utils/custom_app_bar.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController reTypePassword = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            },
            title: 'Change Password',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Normalext(r"Your password must be at least 6 characters and should include a combination of numbers, letters and special characters (!$@%).", txtAlign: TextAlign.justify,fontSize: 25.sp,),
            SizedBox(height: 30.h,),
            Container(
                width: 510.w + 140.w,
                height: 90.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: cLineColor),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: currentPassword,
                    decoration: InputDecoration(
                        hintText: "Current Password",
                        border: InputBorder.none),
                    onChanged: (value) {
                      setState(() {
                      });
                    },
                    onTap: () {
                      setState(() {
                      });
                    },
                  ),
                )),
            SizedBox(height: 20.h,),

            Container(
                width: 510.w + 140.w,
                height: 90.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: cLineColor),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: newPassword,
                    decoration: InputDecoration(
                        hintText: "New Password",
                        border: InputBorder.none),
                    onChanged: (value) {
                      setState(() {
                      });
                    },
                    onTap: () {
                    },
                  ),
                )),
            SizedBox(height: 20.h,),

            Container(
                width: 510.w + 140.w,
                height: 90.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: cLineColor),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: reTypePassword,
                    decoration: InputDecoration(
                        hintText: "Re-type Password",
                        border: InputBorder.none),
                    onChanged: (value) {
                      setState(() {
                      });
                    },
                    onTap: () {
                      setState(() {

                      });
                    },
                  ),
                )),
                SizedBox(height: 20.h,),
                GestureDetector(
                  onTap: (){},
                    child: HeaderText("Forget Passowrd", color: Colors.blue,)),
          ]),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: currentPassword.text.isEmpty || newPassword.text.isEmpty || reTypePassword.text.isEmpty? Colors.black38: Colors.blue
            ),
            child: Normalext(
              'Confirm Password',
              color: Colors.white,
            ),
            onPressed: () {
              Get.offUntil(
                GetPageRoute(
                  page: () => const PasswordAndSecurity(),
                ),
                    (route) => route.isFirst,
              );
            },
          ),
        ));
  }
}
