import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/change%20password/change_password_page.dart';
import 'package:bip_hip/views/menu/settings/change%20password/two%20_factor_authentication_page.dart';
import 'package:bip_hip/views/menu/settings/change%20password/where_logged_in_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/account_ownership_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/add_contact_info_page.dart';
import 'package:bip_hip/views/menu/settings/personal%20details/contact_info_page.dart';
import 'package:bip_hip/views/menu/settings/change%20password/login_alerts_page.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:bip_hip/widgets/common/utils/common_simple_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controllers/menu/kids_controller.dart';
import '../../../../helpers/menu/kids/kid_helper.dart';

class LanguageAndRegion extends StatefulWidget {
  const LanguageAndRegion({Key? key}) : super(key: key);

  @override
  State<LanguageAndRegion> createState() => _LanguageAndRegionState();
}

class _LanguageAndRegionState extends State<LanguageAndRegion> {
  final KidsController kidsController = Get.find<KidsController>();
  final KidHelper kidHelper = KidHelper();


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
            title: ksLanguageAndRegion.tr,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width*.9,
                decoration: BoxDecoration(
                    color: cGreyBoxColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: HeaderText(ksAccountLanguage.tr),
                        ),
                        IconButton(onPressed: ()  {
                           kidsController.getLanguageList();
                          Get.toNamed(krLanguageListPage);
                        },
                            icon: Icon(Icons.arrow_forward_ios, color: cIconColor,))
                      ],
                    ),
                    SizedBox(height: 5),
                    CustomDivider(),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: HeaderText(ksRegionFormat.tr),
                        ),
                        IconButton(onPressed: (){
                          kidsController.getLanguageList();
                          Get.toNamed(krLanguageListPage);
                        },
                            icon: Icon(Icons.arrow_forward_ios, color: cIconColor,))
                      ],
                    ),
                    SizedBox(height: 5),
                    CustomDivider(),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: HeaderText(ksLanguageYoudLikeToHavePostsTranslatedInto.tr),
                        ),
                        IconButton(
                            onPressed: (){
                              kidsController.getLanguageList();
                              Get.toNamed(krLanguageListPage);
                            },
                            icon: Icon(Icons.arrow_forward_ios, color: cIconColor,))
                      ],
                    ),
                    SizedBox(height: 5),
                    CustomDivider(),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Expanded(child: HeaderText(ksLanguagesYouDontWantToBeOfferedTranslations.tr)),
                        ),
                        IconButton(
                            onPressed: (){
                              kidsController.getLanguageList();
                              Get.toNamed(krLanguageListPage);
                            },
                            icon: Icon(Icons.arrow_forward_ios, color: cIconColor,))
                      ],
                    ),
                    SizedBox(height: 5),
                    CustomDivider(),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: HeaderText(ksLanguagesYouDontWantAutomaticallyTranslated.tr),
                        ),
                        IconButton(
                            onPressed: (){
                              kidsController.getLanguageList();
                              Get.toNamed(krLanguageListPage);
                            },
                            icon: Icon(Icons.arrow_forward_ios, color: cIconColor,))
                      ],
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
