import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile/profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class EditBio extends StatelessWidget {
  EditBio({super.key});

  final ProfileController profileController = Get.find<ProfileController>();
  final ProfileHelper profileHelper = ProfileHelper();

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
                      title: profileController.bio.value == '' ? ksAddBio.tr : ksEditBio.tr,
                      hasBackButton: true,
                      isCenterTitle: true,
                      onBack: () {
                        Get.back();
                      },
                      action: [
                        Padding(
                          padding: const EdgeInsets.only(right: k8Padding),
                          child: CustomTextButton(
                              onPressed: profileController.bioEditingController.text != profileController.bio.value
                                  ? () async {
                                      unfocus(context);
                                      profileHelper.saveBio();
                                    }
                                  : null,
                              text: ksSave.tr,
                              textStyle: profileController.bioEditingController.text != profileController.bio.value
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
                                  controller: profileController.bioEditingController,
                                  hint: ksEnterYourBio.tr,
                                  maxLength: 255,
                                  maxLines: 5,
                                  onChanged: (text) {
                                    profileController.bioCount.value = text.length;
                                  },
                                  onSubmit: (text) {},
                                  inputAction: TextInputAction.newline,
                                  inputType: TextInputType.name,
                                ),
                                Text(
                                  '${profileController.bioCount}/255',
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
            if (profileController.isBioLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (profileController.isBioLoading.value) {
                      return false;
                    }
                    return true;
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
