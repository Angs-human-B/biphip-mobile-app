import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/edit_profile.dart';
import 'package:bip_hip/widgets/common/custom_app_bar.dart';
import 'package:bip_hip/widgets/textfields/custom_textfield.dart';

class EditBio extends StatelessWidget {
  EditBio({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              title: 'Edit bio'.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: k8Padding),
                  child: CustomTextButton(
                      onPressed: () {
                        _profileController.bio.value = _profileController.bioEditingController.text.trim();
                        Get.back();
                        _profileController.clearBio();
                      },
                      text: 'Save',
                      textStyle: regular14TextStyle(cPrimaryColor)),
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
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kH20sizedBox,
                          CustomModifiedTextField(
                            controller: _profileController.bioEditingController,
                            hint: "Enter your bio",
                            maxLength: 255,
                            maxLines: 5,
                            onChanged: (text) {
                              _profileController.bioCount.value = text.length;
                            },
                            onSubmit: (text) {},
                            inputAction: TextInputAction.newline,
                            inputType: TextInputType.name,
                          ),
                          kH12sizedBox,
                          Text(
                            '${_profileController.bioCount}/255',
                            style: regular14TextStyle(cIconColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Positioned(
                top: 0,
                child: CustomDivider(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
