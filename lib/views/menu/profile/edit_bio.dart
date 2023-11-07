import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/helpers/profile_helpers/profile_helper.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class EditBio extends StatelessWidget {
  EditBio({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();
  final ProfileHelper _profileHelper = ProfileHelper();

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
                      title: _profileController.bio.value == '' ? ksAddBio.tr : ksEditBio.tr,
                      hasBackButton: true,
                      isCenterTitle: true,
                      onBack: () {
                        Get.back();
                      },
                      action: [
                        Padding(
                          padding: const EdgeInsets.only(right: k8Padding),
                          child: CustomTextButton(
                              onPressed: _profileController.bioEditingController.text != _profileController.bio.value
                                  ? () async {
                                      unfocus(context);
                                      _profileHelper.saveBio();
                                    }
                                  : null,
                              text: ksSave.tr,
                              textStyle: _profileController.bioEditingController.text != _profileController.bio.value
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
                                  controller: _profileController.bioEditingController,
                                  hint: ksEnterYourBio.tr,
                                  maxLength: 255,
                                  maxLines: 5,
                                  onChanged: (text) {
                                    _profileController.bioCount.value = text.length;
                                  },
                                  onSubmit: (text) {},
                                  inputAction: TextInputAction.newline,
                                  inputType: TextInputType.name,
                                ),
                                Text(
                                  '${_profileController.bioCount}/255',
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
            if (_profileController.isBioLoading.value == true)
              Positioned(
                child: CommonLoadingAnimation(
                  onWillPop: () async {
                    if (_profileController.isBioLoading.value) {
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
