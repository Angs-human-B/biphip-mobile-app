import 'package:bip_hip/controllers/menu/kids_controller.dart';
import 'package:bip_hip/helpers/menu/kids/kid_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class KidEditBio extends StatelessWidget {
  KidEditBio({super.key});

  final KidsController kidsController = Get.find<KidsController>();
  final KidHelper kidHelper = KidHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: Obx(
        () => Stack(
          children: [
            SafeArea(
              top: false,
              child: Scaffold(
                  backgroundColor: cWhiteColor,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(kAppBarSize),
                    //* info:: appBar
                    child: CustomAppBar(
                      appBarColor: cWhiteColor,
                      title: kidsController.kidBio.value == '' ? ksAddBio.tr : ksEditBio.tr,
                      hasBackButton: true,
                      isCenterTitle: true,
                      onBack: () {
                        Get.back();
                      },
                      action: [
                        Padding(
                          padding: const EdgeInsets.only(right: k8Padding),
                          child: CustomTextButton(
                              onPressed: kidsController.kidBioEditingController.text != kidsController.kidBio.value
                                  ? () async {
                                      unfocus(context);
                                      // profileHelper.saveBio();//! Change using api(save bio api call)
                                    }
                                  : null,
                              text: ksSave.tr,
                              textStyle: kidsController.kidBioEditingController.text != kidsController.kidBio.value
                                  ? regular14TextStyle(cPrimaryColor)
                                  : regular14TextStyle(cIconColor)),
                        )
                      ],
                    ),
                  ),
                  body: Stack(
                    children: [
                      SizedBox(
                        height: height,
                        width: width,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kH20sizedBox,
                                CustomModifiedTextField(
                                  controller: kidsController.kidBioEditingController,
                                  hint: ksEnterYourBio.tr,
                                  maxLength: 255,
                                  maxLines: 5,
                                  onChanged: (text) {
                                    kidsController.bioCount.value = text.length;
                                  },
                                  onSubmit: (text) {},
                                  inputAction: TextInputAction.newline,
                                  inputType: TextInputType.name,
                                ),
                                Text(
                                  '${ kidsController.bioCount.value}/255',
                                  style: regular14TextStyle(cIconColor),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            //!Add api call loading condition
            // if (profileController.isBioLoading.value == true)
            //   Positioned(
            //     child: CommonLoadingAnimation(
            //       onWillPop: () async {
            //         if (profileController.isBioLoading.value) {
            //           return false;
            //         }
            //         return true;
            //       },
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
