import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/notifications/toggle_button.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/const.dart';
import '../../../../widgets/common/utils/custom_app_bar.dart';

class PushEmail extends StatefulWidget {
  String title;
  PushEmail(this.title, {Key? key}) : super(key: key);

  @override
  State<PushEmail> createState() => _PushEmailState();
}

class _PushEmailState extends State<PushEmail> {
  bool togglePush = true;
  bool toggleEmail = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kAppBarSizeSetting),
        child: CustomAppBar(
          onBack: () {
            Get.back();
          },
          title:"${widget.title} settings",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ToggleButton("Push"),
            ToggleButton("Email", toggle: false,),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
        child: TextButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: cIconColor
          ),
          onPressed: (){

          },
          child: HeaderText("Save", color: cWhiteColor,),
        ),
      )
    );
  }
}
