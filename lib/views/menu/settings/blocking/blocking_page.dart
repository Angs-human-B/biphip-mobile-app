import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/blocking/blocking_setting_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/const.dart';
import '../../../../widgets/common/utils/common_divider.dart';
import '../../../../widgets/common/utils/common_headertext.dart';
import '../../../../widgets/common/utils/common_simple_text.dart';
import '../../../../widgets/common/utils/custom_app_bar.dart';
import '../../friends/widgets/all_friend_listview.dart';
import '../how people will find you/modalsheetWidget.dart';

class Blocking extends StatefulWidget {
  const Blocking({Key? key}) : super(key: key);

  @override
  State<Blocking> createState() => _BlockingState();
}

class _BlockingState extends State<Blocking> {
  List text = [
    {
      'title': "Block users",
      'body': "Once you block someone, that person can no longer see things you post on your timeline, tag you, invite you to events or groups, start a conversation with you, or add you as a friend. Note: Does not include apps, games or groups you both participate in."
    },
    {
      "title":"Block Messages",
      "body":"If you block someone's profile on Facebook, they won't be able to contact you in Messenger either. Unless you block someone's Facebook profile and any others they may create, they may be able to post on your timeline, tag you, and comment on your posts or comments."
    },
    {
      "title":"Block from all",
      "body":"Once you block someone, that person can no longer see things you post on your timeline, tag you, invite you to events or groups, start a conversation with you, or add you as a friend. Note: Does not include apps, games or groups you both participate in."
    },
    {
      "title":"Block kids ",
      "body":"Once you block someone, that person can no longer see things you post on your timeline, tag you, invite you to events or groups, start a conversation with you, or add you as a friend. Note: Does not include apps, games or groups you both participate in."
    },
    {
      "title":"Block shop",
      "body":"Once you block someone, that person can no longer see things you post on your timeline, tag you, invite you to events or groups, start a conversation with you, or add you as a friend. Note: Does not include apps, games or groups you both participate in."
    },

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kAppBarSizeSetting),
        child: CustomAppBar(
          onBack: () {
            Get.back();
          },
          title: ksBlocking.tr,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 1100.h,
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                    color: cGreyBoxColor,
                    borderRadius: BorderRadius.circular(10)),
                child: ListView.builder(
                    itemCount: text.length,
                    itemBuilder: (context, index){
                  return BlockingSettingTiles(text, index);
                })
              ),
            ],
          ),
        ),
      ),
    );
  }
}
