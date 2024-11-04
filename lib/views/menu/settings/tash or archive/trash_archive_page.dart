import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/settings/tash%20or%20archive/trash_archive_list_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/constants/const.dart';
import '../../../../widgets/common/utils/custom_app_bar.dart';

class TrashArchive extends StatefulWidget {
  String title;
  TrashArchive(this.title,{Key? key}) : super(key: key);
  @override
  State<TrashArchive> createState() => _TrashArchiveState();
}

class _TrashArchiveState extends State<TrashArchive> {

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
          title: widget.title
        ),
      ),
      body: TrashArchiveListWidget()
    );
  }
}
