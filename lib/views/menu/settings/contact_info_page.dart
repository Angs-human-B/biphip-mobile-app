import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/add_contact_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/constants/const.dart';
import '../../../widgets/common/utils/common_divider.dart';
import '../../../widgets/common/utils/common_headertext.dart';
import '../../../widgets/common/utils/common_simple_text.dart';
import '../../../widgets/common/utils/custom_app_bar.dart';
import 'package:bip_hip/utils/icons/bip_hip_icons.dart';

class ContactInfo extends StatefulWidget {
  const ContactInfo({Key? key}) : super(key: key);

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  List contact_info = [
    "shohagjalal@gmail.com",
    "sshohagjalal@gmail.com",
    "+8801793-144278",
    "+8801993-144278"
  ];
  showBottomSheet(){
    return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(top: 50.h, left: 30.w),
            child: Container(
              height: 500.h,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  HeaderText('Which would you like to add?'),
                  SizedBox(height: 40.h,),
                  Container(
                    height: 200.h,
                    width: MediaQuery.of(context).size.width*.9,
                    decoration: BoxDecoration(
                        color: cGreyBoxColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 35.h,),
                        GestureDetector(
                          onTap: (){
                            Get.to(AddContactInfo("Add Contact Info", 'phone'));
                          },
                          child: Padding(
                            padding:  EdgeInsets.only(left: 20.w),
                            child: Normalext("Add mobile number", color: Colors.blue),
                          ),
                        ),
                        SizedBox(height: 35.h,),
                        CustomDivider(),
                        SizedBox(height: 35.h),
                        GestureDetector(
                          onTap: (){
                            Get.to(AddContactInfo("Add Contact Info", "email"));
                          },
                          child: Padding(
                            padding:  EdgeInsets.only(left: 20.w),
                            child: Normalext("Add email", color: Colors.blue,),
                          ),
                        ),
                    ]
                    ),
                  )
                ],
              ),
            ),
          );
  });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kAppBarSizeSetting),
            child: CustomAppBar(
              onBack: () {
                Get.back();
              },
              title: "Contact Info",
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Normalext(
                      "Manage your mobile numbers and emails to make sure your contact info is accurate and up to date."),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 70.h * contact_info.length,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                          color: cGreyBoxColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: contact_info.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        if(contact_info[index].toString().contains(".")){
                                          Get.to(AddContactInfo("Edit Contact Info", 'email',controllerTxt: contact_info[index],));
                                        }
                                        else{
                                          Get.to(AddContactInfo("Edit Contact Info", 'phone',controllerTxt: contact_info[index],));

                                        }

                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 20.w),
                                        child: Normalext(contact_info[index]),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    IconButton(onPressed: (){
                                      contact_info.remove(contact_info[index]);
                                      setState(() {
                                      });
                                    },
                                        icon: Icon(BipHip.delete))
                                  ],
                                ),
                                if (index < contact_info.length - 1)
                                  CustomDivider()
                              ],
                            );
                          }))
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
            child: ElevatedButton(
              child: Normalext('+ Add new contact', color: Colors.white,),
              onPressed: () {
                showBottomSheet();
              },
            ),
          )),
    );
  }
}
