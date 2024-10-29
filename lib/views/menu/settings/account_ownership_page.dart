import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/add_contact_info_page.dart';
import 'package:bip_hip/views/menu/settings/contact_info_page.dart';
import 'package:bip_hip/views/menu/settings/delete_account_page.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:bip_hip/widgets/common/utils/common_simple_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountOwnership extends StatefulWidget {
  const AccountOwnership({Key? key}) : super(key: key);

  @override
  State<AccountOwnership> createState() => _AccountOwnershipState();
}

class _AccountOwnershipState extends State<AccountOwnership> {
  int selectDelete = 0;
  int selectPermanentlyDelete = 0;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kAppBarSizeSetting),
          child: CustomAppBar(
            onBack: (){
              Get.back();
            },
            title: "Personal Details",

          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Normalext(

                  "To start the process, select what you’d like to temporarily deactivate or permanently delete.", txtAlign: TextAlign.justify,fontSize: 25.sp,),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(left: 20),
                height: 250,
                width: MediaQuery.of(context).size.width*.9,
                decoration: BoxDecoration(
                    color: cGreyBoxColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeaderText("Deactivate your account"),
                            SizedBox(height: 5,),
                            Container(
                              width: 500.w,
                                child: Normalext("profile will be hidden on Instagram until you reactivate it through Accounts Center or by logging in to your Instagram account. ", fontSize: 26.sp, txtAlign: TextAlign.start,)),
                          ],
                        ),
                        IconButton(onPressed: (){
                        },
                            icon: Radio<int>(
                              value: 1,
                              groupValue: selectDelete,
                              onChanged: (value) {
                                setState(() {
                                  selectPermanentlyDelete = 0;
                                  selectDelete = value!;
                                  print("Button value: $value");
                                });
                              },
                            ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    CustomDivider(),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeaderText("Permanently Delete"),
                            SizedBox(height: 5,),
                            Container(
                              width: 500.w,
                                child: Normalext("profile will be permanently delete on Bip-Hip. you are loos your every information and you can’t recover it again.", fontSize: 26.sp)),
                          ],
                        ),
                        IconButton(
                            onPressed: (){
                        },
                            icon: Radio<int>(
                              value: 1,
                              groupValue: selectPermanentlyDelete,
                              onChanged: (value) {
                                setState(() {
                                  selectDelete = 0;
                                  selectPermanentlyDelete = value!;
                                  print("Button value: $value");
                                });
                              },
                            ),
                        )
                      ],
                    ),

                    SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ),
          bottomNavigationBar: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
            child: ElevatedButton(
              child: Normalext('Continue', color: Colors.white,),
              onPressed: () {
                if(selectDelete == 1){
                  Get.to(DeleteAccount("Delete Account", "profile will be hidden on Instagram until you reactivate it through Accounts Center or by logging in to your Instagram account."));
                }
                if(selectPermanentlyDelete == 1){
                  Get.to(DeleteAccount("Permanently Delete Account", "Deleting your account is permanent. When you delete your Bip-Hip account, your profile, photos, videos, comments, likes and followers will be permanently removed. If you’d just like to take a break, you can temporarily deactivate your account."));
                }
              },
            ),
          ),
      ),
    );
  }
}
