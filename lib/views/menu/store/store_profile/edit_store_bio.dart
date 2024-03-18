import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class StoreEditBio extends StatelessWidget {
  StoreEditBio({super.key});

  final StoreController storeController = Get.find<StoreController>();

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
                      title: storeController.storeBio.value == null ? ksAddBio.tr : ksEditBio.tr,
                      hasBackButton: true,
                      isCenterTitle: true,
                      onBack: () {
                        Get.back();
                      },
                      action: [
                        Padding(
                          padding: const EdgeInsets.only(right: k8Padding),
                          child: CustomTextButton(
                              onPressed: storeController.storeBioTextEditingController.text != storeController.storeBio.value
                                  ? () async {
                                      unfocus(context);
                                      // kidHelper.saveEditBio();
                                    }
                                  : null,
                              text: ksSave.tr,
                              textStyle: storeController.storeBioTextEditingController.text != storeController.storeBio.value
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
                                  controller: storeController.storeBioTextEditingController,
                                  hint: ksEnterYourBio.tr,
                                  maxLength: 255,
                                  maxLines: 5,
                                  onChanged: (text) {
                                    storeController.bioCount.value = text.length;
                                  },
                                  onSubmit: (text) {},
                                  inputAction: TextInputAction.newline,
                                  inputType: TextInputType.name,
                                ),
                                Text(
                                  '${storeController.bioCount.value}/255',
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
            // if (kidsController.isKidBioLoading.value == true)//!Condition for loading
            //   Positioned(
            //     child: CommonLoadingAnimation(
            //       onWillPop: () async {
            //         if (kidsController.isKidBioLoading.value) {
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
