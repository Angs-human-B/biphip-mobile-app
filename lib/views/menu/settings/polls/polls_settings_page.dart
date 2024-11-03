import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/common/utils/common_divider.dart';
import '../../../../widgets/common/utils/common_headertext.dart';
import '../../../../widgets/common/utils/common_simple_text.dart';
import '../how people will find you/modalsheetWidget.dart';

class PollsSettingsPage extends StatefulWidget {
  const PollsSettingsPage({Key? key}) : super(key: key);

  @override
  State<PollsSettingsPage> createState() => _PollsSettingsPageState();
}

class _PollsSettingsPageState extends State<PollsSettingsPage> {
  bool toggleArchivePolls = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kAppBarSizeSetting),
        child: CustomAppBar(
          onBack: () {
            Get.back();
          },
          title: ksPolls.tr,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                    color: cGreyBoxColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 400.w,
                                child: HeaderText(
                                  "Who can see your Poll?",
                                )),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft:
                                          Radius.circular(k16BorderRadius),
                                          topRight:
                                          Radius.circular(k16BorderRadius)),
                                    ),
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Modalsheetwidget(
                                          "Who can see your Poll?",
                                          "Your post Will appear in Feed, on your profile and in search results. Your default audience is set to Public, but you can change the audience of this specific post",
                                          1);
                                    });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: cPrimaryTint3Color,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    Icon(
                                      BipHip.world,
                                      color: Colors.black,
                                      size: 30.sp,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 4.5.h),
                                      child: Normalext(
                                        "Public",
                                        weight: FontWeight.bold,
                                        fontSize: 26.sp,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Normalext(
                          "Your default audience is set to Public. This will be your audience for See star bonus, but you can always change it for a specific post.",
                          fontSize: 25.sp,
                          txtAlign: TextAlign.start,
                          weight: FontWeight.normal,
                          color: cBlackColor,
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const CustomDivider(),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeaderText("Archiving your Poll"),
                              SizedBox(height: 5),
                              Container(
                                width: double.infinity,
                                child: Normalext(
                                  "Their poll will include your full name and a link to your original poll. They control who sees it.",fontSize: 26.sp,
                                  txtAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: toggleArchivePolls,
                          activeTrackColor:Colors.green ,
                          thumbColor: WidgetStateProperty.all(cWhiteColor),
                          onChanged: (bool value) {
                            setState(() {
                              toggleArchivePolls = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
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
