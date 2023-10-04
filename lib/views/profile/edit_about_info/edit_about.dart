import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/edit_profile.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/common/button/custom_modified_text_button.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';
import 'package:bip_hip/widgets/common/button/custom_selection_button.dart';

class EditAboutInfo extends StatelessWidget {
  EditAboutInfo({super.key});

  final ProfileController _profileController = Get.find<ProfileController>();
  final GlobalController _globalController = Get.find<GlobalController>();

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
              title: 'About'.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: SizedBox(
            height: height - kAppBarSize,
            width: width,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kH10sizedBox,
                      Text(
                        'Address',
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      kH20sizedBox,
                      RowTextButton(
                        text: 'Hometown',
                        buttonText: 'Add',
                        showAddButton: _profileController.homeTown.value == '' ? true : false,
                        buttonWidth: 151,
                        onPressedAdd: () {
                          _profileController.setEditPageValue('Add Hometown Address', false, BipHip.location, _profileController.homeTownTextEditingController,
                              false, _profileController.homeTownTextEditingController, 'Enter hometown address', false, true, false, false, '', 'HOMETOWN');
                          Get.toNamed(krEdit);
                        },
                      ),
                      if (_profileController.homeTown.value != '')
                        Padding(
                          padding: const EdgeInsets.only(top: k10Padding),
                          child: InfoContainer(
                            prefixIcon: BipHip.location,
                            suffixIcon: BipHip.edit,
                            text: _profileController.homeTown.value,
                            suffixOnPressed: () {
                              _globalController.commonBottomSheet(
                                  context: context,
                                  isScrollControlled: false,
                                  bottomSheetHeight: 160,
                                  content: EditModalSheet(
                                    editButtonText: 'Edit Address',
                                    editOnPressed: () {
                                      _profileController.setEditPageValue(
                                          'Edit Hometown Address',
                                          false,
                                          BipHip.location,
                                          _profileController.homeTownTextEditingController,
                                          false,
                                          _profileController.homeTownTextEditingController,
                                          'Edit hometown address',
                                          false,
                                          true,
                                          false,
                                          false,
                                          'checkBoxText',
                                          'EDIT HOMETOWN');
                                      Get.toNamed(krEdit);
                                    },
                                    deleteButtonText: 'Delete Address',
                                    deleteOnPressed: () {
                                      _profileController.homeTown.value = '';
                                      Get.back();
                                    },
                                  ),
                                  onPressCloseButton: () {
                                    Get.back();
                                  },
                                  onPressRightButton: null,
                                  rightText: '',
                                  rightTextStyle: regular10TextStyle(cBlackColor),
                                  title: 'Edit',
                                  isRightButtonShow: false);
                            },
                          ),
                        ),
                      kH16sizedBox,
                      RowTextButton(
                        text: 'Present Address',
                        buttonText: 'Add',
                        showAddButton: true,
                        onPressedAdd: () {
                          _profileController.setEditPageValue(
                              'Add Present Address',
                              false,
                              BipHip.location,
                              _profileController.presentAddressTextEditingController,
                              false,
                              _profileController.presentAddressTextEditingController,
                              'Add location',
                              true,
                              true,
                              true,
                              false,
                              'Currently living here',
                              'ADD PRESENT');
                          Get.toNamed(krEdit);
                        },
                        buttonWidth: 108,
                      ),
                      if (_profileController.cityList.isNotEmpty) kH12sizedBox,
                      if (_profileController.cityList.isNotEmpty)
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: _profileController.cityList.length,
                            itemBuilder: (context, index) {
                              var item = _profileController.cityList[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: k10Padding),
                                child: InfoContainer(
                                  prefixIcon: BipHip.location,
                                  suffixIcon: BipHip.edit,
                                  text: item,
                                  suffixOnPressed: () {
                                    // _profileController.cityList.remove(_profileController.cityList[index]);
                                    _globalController.commonBottomSheet(
                                        context: context,
                                        isScrollControlled: false,
                                        bottomSheetHeight: 160,
                                        onPressCloseButton: () {
                                          Get.back();
                                        },
                                        onPressRightButton: null,
                                        rightText: '',
                                        rightTextStyle: regular10TextStyle(cBlackColor),
                                        title: 'Edit',
                                        isRightButtonShow: false,
                                        content: EditModalSheet(
                                          editButtonText: 'Edit Address',
                                          editOnPressed: () {
                                            _profileController.cityListIndex.value = index;
                                            _profileController.presentAddressTextEditingController.text = item;
                                            _profileController.setEditPageValue(
                                                'Edit Present Address',
                                                false,
                                                BipHip.location,
                                                _profileController.presentAddressTextEditingController,
                                                false,
                                                _profileController.presentAddressTextEditingController,
                                                'Edit location',
                                                true,
                                                true,
                                                true,
                                                _profileController.isCurrentlyLiveHere.value,
                                                'Currently living here',
                                                'EDIT PRESENT');
                                            Get.toNamed(krEdit);
                                          },
                                          deleteButtonText: 'Delete Address',
                                          deleteOnPressed: () {
                                            _profileController.cityList.remove(item);
                                            Get.back();
                                          },
                                        ));
                                  },
                                ),
                              );
                            }),
                      kH20sizedBox,
                      const CustomDivider(),
                      kH20sizedBox,
                      Text(
                        'Relationship Status',
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      kH20sizedBox,
                      CustomSelectionButton(
                        prefixIcon: BipHip.love,
                        onPressed: () {
                          _profileController.showEditRelationshipStatus.value = true;
                          _globalController.commonBottomSheet(
                            context: context,
                            content: _RelationshipStatusListContent(
                              profileController: _profileController,
                            ),
                            isScrollControlled: true,
                            bottomSheetHeight: height * 0.6,
                            onPressCloseButton: () {
                              Get.back();
                            },
                            onPressRightButton: null,
                            rightText: '',
                            rightTextStyle: regular10TextStyle(cBlackColor),
                            title: 'Select Relationship Status',
                            isRightButtonShow: false,
                          );
                        },
                        text: _profileController.relationshipStatus.value,
                        hintText: 'Select Relationship Status',
                      ),
                      if (_profileController.relationshipStatus.value != '' && _profileController.showEditRelationshipStatus.value) kH20sizedBox,
                      if (_profileController.relationshipStatus.value != '' && _profileController.showEditRelationshipStatus.value)
                        OutLinedButton(
                          buttonWidth: 80,
                          buttonHeight: 25,
                          onPress: () {},
                          buttonText: 'Public',
                          buttonTextStyle: semiBold12TextStyle(cBlackColor),
                          borderColor: cLineColor,
                          suffixWidget: const Padding(
                            padding: EdgeInsets.only(right: k8Padding),
                            child: Icon(
                              BipHip.world,
                              color: cIconColor,
                              size: kIconSize16,
                            ),
                          ),
                        ),
                      if (_profileController.relationshipStatus.value != '' && _profileController.showEditRelationshipStatus.value) kH20sizedBox,
                      if (_profileController.relationshipStatus.value != '' && _profileController.showEditRelationshipStatus.value)
                        CancelSaveButton(
                          onPressedCancel: () {
                            _profileController.showEditRelationshipStatus.value = false;
                          },
                          onPressedSave: () {
                            _profileController.showEditRelationshipStatus.value = false;
                          },
                        ),
                      kH20sizedBox,
                      const CustomDivider(),
                      kH16sizedBox,
                      RowTextButton(
                        text: 'Education Background',
                        buttonText: 'Add',
                        showAddButton: true,
                        onPressedAdd: () {
                          _profileController.setEditPageValue(
                              'Add Educational Event',
                              true,
                              BipHip.schoolNew,
                              _profileController.educationInstituteTextEditingController,
                              false,
                              _profileController.educationInstituteTextEditingController,
                              'Institute name',
                              true,
                              true,
                              true,
                              _profileController.isCurrentlyStudyingHere.value,
                              'Currently studying here',
                              'ADD SCHOOL');
                          Get.toNamed(krEdit);
                        },
                        buttonWidth: 126,
                      ),
                      if (_profileController.schoolList.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: k16Padding),
                          child: Text(
                            'School',
                            style: semiBold16TextStyle(cBlackColor),
                          ),
                        ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: _profileController.schoolList.length,
                          itemBuilder: (context, index) {
                            var item = _profileController.schoolList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: k10Padding),
                              child: InfoContainer(
                                prefixIcon: BipHip.schoolNew,
                                suffixIcon: BipHip.edit,
                                text: item,
                                suffixOnPressed: () {
                                  // _profileController.cityList.remove(_profileController.cityList[index]);
                                  _globalController.commonBottomSheet(
                                      context: context,
                                      isScrollControlled: false,
                                      bottomSheetHeight: 160,
                                      onPressCloseButton: () {
                                        Get.back();
                                      },
                                      onPressRightButton: null,
                                      rightText: '',
                                      rightTextStyle: regular10TextStyle(cBlackColor),
                                      title: 'Edit',
                                      isRightButtonShow: false,
                                      content: EditModalSheet(
                                        editButtonText: 'Edit School',
                                        editOnPressed: () {
                                          _profileController.schoolIndex.value = index;
                                          _profileController.educationInstituteTextEditingController.text = item;
                                          _profileController.setEditPageValue(
                                              'Edit School',
                                              false,
                                              BipHip.schoolNew,
                                              _profileController.educationInstituteTextEditingController,
                                              false,
                                              _profileController.educationInstituteTextEditingController,
                                              'Edit school',
                                              true,
                                              true,
                                              true,
                                              _profileController.isCurrentlyStudyingHere.value,
                                              'Currently studying here',
                                              'EDIT SCHOOL');
                                          Get.toNamed(krEdit);
                                        },
                                        deleteButtonText: 'Delete School',
                                        deleteOnPressed: () {
                                          _profileController.schoolList.remove(item);
                                          Get.back();
                                        },
                                      ));
                                },
                              ),
                            );
                          }),
                      if (_profileController.collegeList.isNotEmpty)
                        Text(
                          'College',
                          style: semiBold16TextStyle(cBlackColor),
                        ),
                      kH16sizedBox,
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: _profileController.collegeList.length,
                          itemBuilder: (context, index) {
                            var item = _profileController.collegeList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: k10Padding),
                              child: InfoContainer(
                                prefixIcon: BipHip.schoolNew,
                                suffixIcon: BipHip.edit,
                                text: item,
                                suffixOnPressed: () {
                                  // _profileController.cityList.remove(_profileController.cityList[index]);
                                  _globalController.commonBottomSheet(
                                      context: context,
                                      isScrollControlled: false,
                                      bottomSheetHeight: 160,
                                       onPressCloseButton: () {
                                    Get.back();
                                  },
                                  onPressRightButton: null,
                                  rightText: '',
                                  rightTextStyle: regular10TextStyle(cBlackColor),
                                  title: 'Edit',
                                  isRightButtonShow: false,
                                      content: EditModalSheet(
                                        editButtonText: 'Edit College',
                                        editOnPressed: () {
                                          _profileController.collegeIndex.value = index;
                                          _profileController.educationInstituteTextEditingController.text = item;
                                          _profileController.setEditPageValue(
                                              'Edit College',
                                              false,
                                              BipHip.schoolNew,
                                              _profileController.educationInstituteTextEditingController,
                                              false,
                                              _profileController.educationInstituteTextEditingController,
                                              'Edit College',
                                              true,
                                              true,
                                              true,
                                              _profileController.isCurrentlyStudyingHere.value,
                                              'Currently studying here',
                                              'EDIT COLLEGE');
                                          Get.toNamed(krEdit);
                                        },
                                        deleteButtonText: 'Delete College',
                                        deleteOnPressed: () {
                                          _profileController.collegeList.remove(item);
                                          Get.back();
                                        },
                                      ));
                                },
                              ),
                            );
                          }),
                      const CustomDivider(),
                      kH16sizedBox,
                      RowTextButton(
                        text: 'Profession',
                        buttonText: 'Add',
                        showAddButton: _profileController.selectedProfession.value == '',
                        onPressedAdd: () {
                          _profileController.isRouteFromAboutInfo.value = true;
                          Get.toNamed(krSelectProfession);
                        },
                        buttonWidth: 149,
                      ),
                      if (_profileController.selectedProfession.value != '')
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: CustomSelectionButton(
                            prefixIcon: BipHip.work,
                            onPressed: () {
                              _profileController.showEditRelationshipStatus.value = true;
                              _globalController.commonBottomSheet(
                                  context: context,
                                  isScrollControlled: false,
                                  bottomSheetHeight: 160,
                                   onPressCloseButton: () {
                                    Get.back();
                                  },
                                  onPressRightButton: null,
                                  rightText: '',
                                  rightTextStyle: regular10TextStyle(cBlackColor),
                                  title: 'Edit',
                                  isRightButtonShow: false,
                                  content: EditModalSheet(
                                    editButtonText: 'Edit Profession',
                                    editOnPressed: () {
                                      _profileController.isRouteFromAboutInfo.value = true;
                                      Get.back();
                                      Get.toNamed(krSelectProfession);
                                    },
                                    deleteButtonText: 'Delete Profession',
                                    deleteOnPressed: () {
                                      _profileController.selectedProfession.value = '';
                                      Get.back();
                                    },
                                  ));
                            },
                            text: _profileController.selectedProfession.value,
                            hintText: 'Select Profession',
                          ),
                        ),
                      kH16sizedBox,
                      const CustomDivider(),
                      kH16sizedBox,
                      RowTextButton(
                        text: 'Interest',
                        buttonText: 'Add',
                        showAddButton: true,
                        onPressedAdd: () {
                          _profileController.isRouteFromAboutInfo.value = true;
                          Get.toNamed(krSelectInterest);
                        },
                        buttonWidth: 149,
                      ),
                      if (_profileController.selectedInterests.isNotEmpty)
                        Wrap(
                          alignment: WrapAlignment.start,
                          direction: Axis.horizontal,
                          spacing: 8.0,
                          children: [
                            for (int i = 0; i < _profileController.selectedInterests.length; i++)
                              CustomChoiceChips(
                                label: _profileController.selectedInterests[i],
                                isSelected: false,
                                onSelected: null,
                              )
                          ],
                        ),
                      kH16sizedBox,
                      const CustomDivider(),
                      kH16sizedBox,
                      RowTextButton(
                        text: 'Work',
                        buttonText: 'Add',
                        showAddButton: true,
                        onPressedAdd: () {
                          _profileController.setEditPageValue(
                              'Add Workplace',
                              false,
                              BipHip.officeFill,
                              _profileController.officeNameTextEditingController,
                              true,
                              _profileController.designationTextEditingController,
                              'Office name',
                              true,
                              true,
                              true,
                              _profileController.isCurrentlyStudyingHere.value,
                              'Currently working here',
                              'ADD WORKPLACE');
                          Get.toNamed(krEdit);
                        },
                        buttonWidth: 149,
                      ),
                      kH16sizedBox,
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: _profileController.officeList.length,
                          itemBuilder: (context, index) {
                            var item = _profileController.officeList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: k10Padding),
                              child: InfoContainer(
                                prefixIcon: BipHip.officeFill,
                                suffixIcon: BipHip.edit,
                                text: item['office'],
                                suffixOnPressed: () {
                                  // _profileController.cityList.remove(_profileController.cityList[index]);
                                  _globalController.blankBottomSheet(
                                      context: context,
                                      isScrollControlled: false,
                                      bottomSheetHeight: 130,
                                      content: EditModalSheet(
                                        editButtonText: 'Edit Workplace',
                                        editOnPressed: () {
                                          _profileController.officeIndex.value = index;
                                          _profileController.officeNameTextEditingController.text = item['office'];
                                          _profileController.designationTextEditingController.text = item['designation'];
                                          _profileController.setEditPageValue(
                                              'Edit Workplace',
                                              false,
                                              BipHip.officeFill,
                                              _profileController.officeNameTextEditingController,
                                              true,
                                              _profileController.designationTextEditingController,
                                              'Edit Workplace',
                                              true,
                                              true,
                                              true,
                                              _profileController.isCurrentlyWorkingHere.value,
                                              'Currently working here',
                                              'EDIT WORKPLACE');
                                          Get.toNamed(krEdit);
                                        },
                                        deleteButtonText: 'Delete workplace',
                                        deleteOnPressed: () {
                                          _profileController.officeList.remove(item);
                                          Get.back();
                                        },
                                      ));
                                },
                              ),
                            );
                          }),
                      const CustomDivider(),
                      kH16sizedBox,
                      Text(
                        'Contact Details',
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      kH20sizedBox,
                      RowTextButton(
                        text: 'Phone',
                        buttonText: 'Add',
                        showAddButton: true,
                        onPressedAdd: () {
                          _profileController.setEditPageValue('Add Phone Number', false, BipHip.phoneFill, _profileController.phoneTextEditingController, false,
                              _profileController.phoneTextEditingController, 'Phone', false, true, false, false, '', 'ADD PHONE');
                          Get.toNamed(krEdit);
                        },
                        buttonWidth: 177,
                      ),
                      kH16sizedBox,
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: _profileController.phoneList.length,
                          itemBuilder: (context, index) {
                            var item = _profileController.phoneList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: k10Padding),
                              child: InfoContainer(
                                prefixIcon: BipHip.phoneFill,
                                suffixIcon: BipHip.edit,
                                text: item,
                                suffixOnPressed: () {
                                  // _profileController.cityList.remove(_profileController.cityList[index]);
                                  _globalController.blankBottomSheet(
                                      context: context,
                                      isScrollControlled: false,
                                      bottomSheetHeight: 130,
                                      content: EditModalSheet(
                                        editButtonText: 'Edit Phone',
                                        editOnPressed: () {
                                          _profileController.phoneIndex.value = index;
                                          _profileController.phoneTextEditingController.text = item;
                                          _profileController.setEditPageValue(
                                              'Edit Phone',
                                              false,
                                              BipHip.phoneFill,
                                              _profileController.phoneTextEditingController,
                                              false,
                                              _profileController.phoneTextEditingController,
                                              'Edit Phone',
                                              false,
                                              true,
                                              false,
                                              false,
                                              '',
                                              'EDIT PHONE');
                                          Get.toNamed(krEdit);
                                        },
                                        deleteButtonText: 'Delete phone',
                                        deleteOnPressed: () {
                                          _profileController.phoneList.remove(item);
                                          Get.back();
                                        },
                                      ));
                                },
                              ),
                            );
                          }),
                      if (_profileController.phoneList.isNotEmpty) kH8sizedBox,
                      RowTextButton(
                        text: 'Email',
                        buttonText: 'Add',
                        showAddButton: true,
                        onPressedAdd: () {
                          _profileController.setEditPageValue('Add Email', false, BipHip.mail, _profileController.emailTextEditingController, false,
                              _profileController.emailTextEditingController, 'Email', false, true, false, false, '', 'ADD EMAIL');
                          Get.toNamed(krEdit);
                        },
                        buttonWidth: 118,
                      ),
                      kH16sizedBox,
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: _profileController.emailList.length,
                          itemBuilder: (context, index) {
                            var item = _profileController.emailList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: k10Padding),
                              child: InfoContainer(
                                prefixIcon: BipHip.mail,
                                suffixIcon: BipHip.edit,
                                text: item,
                                suffixOnPressed: () {
                                  // _profileController.cityList.remove(_profileController.cityList[index]);
                                  _globalController.blankBottomSheet(
                                      context: context,
                                      isScrollControlled: false,
                                      bottomSheetHeight: 130,
                                      content: EditModalSheet(
                                        editButtonText: 'Edit Email',
                                        editOnPressed: () {
                                          _profileController.emailIndex.value = index;
                                          _profileController.emailTextEditingController.text = item;
                                          _profileController.setEditPageValue('Edit Email', false, BipHip.mail, _profileController.emailTextEditingController,
                                              false, _profileController.emailTextEditingController, 'Edit Email', false, true, false, false, '', 'EDIT EMAIL');
                                          Get.toNamed(krEdit);
                                        },
                                        deleteButtonText: 'Delete email',
                                        deleteOnPressed: () {
                                          _profileController.emailList.remove(item);
                                          Get.back();
                                        },
                                      ));
                                },
                              ),
                            );
                          }),
                      kH16sizedBox,
                      // const CustomDivider(),
                      // kH8sizedBox,
                      // RowTextButton(
                      //   text: 'Websites and social links',
                      //   buttonText: 'Add Link',
                      //   showAddButton: true,
                      //   onPressedAdd: () {
                      //     _profileController.setEditPageValue('Add Link', false, BipHip.webLink, _profileController.linkTextEditingController, false,
                      //         _profileController.emailTextEditingController, 'Email', false, true, false, false, '', 'ADD EMAIL');
                      //     Get.toNamed(krEdit);
                      //   },
                      //   buttonWidth: 109,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  const InfoContainer({super.key, required this.prefixIcon, required this.suffixIcon, required this.text, this.suffixOnPressed});
  final IconData prefixIcon;
  final IconData suffixIcon;
  final String text;
  final VoidCallback? suffixOnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, color: cGreyBoxColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: k8Padding),
        child: Row(
          children: [
            Transform.scale(
              scale: .85,
              child: Icon(
                prefixIcon,
                color: cIconColor,
                size: screenWiseSize(kIconSize20, 4),
              ),
            ),
            kW8sizedBox,
            Text(
              text,
              style: regular16TextStyle(cIconColor),
            ),
            const Spacer(),
            CustomIconButton(
              onPress: suffixOnPressed,
              icon: suffixIcon,
              hasBorder: false,
              size: screenWiseSize(kIconSize20, 4),
            )
          ],
        ),
      ),
    );
  }
}

class CancelSaveButton extends StatelessWidget {
  const CancelSaveButton({super.key, required this.onPressedCancel, required this.onPressedSave});
  final VoidCallback onPressedCancel, onPressedSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomElevatedButton(
            label: 'Cancel',
            textStyle: semiBold14TextStyle(cRedColor),
            buttonColor: cWhiteColor,
            borderColor: cRedColor,
            buttonHeight: h32,
            buttonWidth: 80,
            onPressed: onPressedCancel),
        kW16sizedBox,
        CustomElevatedButton(label: 'Save', textStyle: semiBold14TextStyle(cWhiteColor), buttonHeight: h32, buttonWidth: 80, onPressed: onPressedSave),
      ],
    );
  }
}

class _RelationshipStatusListContent extends StatelessWidget {
  const _RelationshipStatusListContent({
    Key? key,
    required this.profileController,
  }) : super(key: key);

  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: profileController.relationshipStatusList.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(() => RadioListTile(
                  title: Text(profileController.relationshipStatusList[index]),
                  value: profileController.relationshipStatusList[index],
                  activeColor: cPrimaryColor,
                  contentPadding: EdgeInsets.zero,
                  groupValue: profileController.relationshipStatus.value,
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (value) {
                    profileController.relationshipStatus.value = value;
                  },
                ));
          },
        ),
      ],
    );
  }
}

class RowTextButton extends StatelessWidget {
  const RowTextButton({super.key, required this.text, required this.buttonText, required this.showAddButton, this.onPressedAdd, required this.buttonWidth});
  final String text, buttonText;
  final bool showAddButton;
  final VoidCallback? onPressedAdd;
  final double buttonWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: semiBold16TextStyle(cBlackColor),
        ),
        if (showAddButton)
          CustomTextButtonV2(
            onPressed: onPressedAdd,
            text: buttonText,
            textStyle: semiBold14TextStyle(cPrimaryColor),
            prefixWidget: Icon(
              BipHip.addNew,
              color: cPrimaryColor,
              size: isDeviceScreenLarge() ? h20 : h16,
            ),
          ),
      ],
    );
  }
}

class EditModalSheet extends StatelessWidget {
  const EditModalSheet({super.key, this.editOnPressed, this.deleteOnPressed, required this.editButtonText, required this.deleteButtonText});
  final VoidCallback? editOnPressed, deleteOnPressed;
  final String editButtonText, deleteButtonText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomElevatedButton(
          onPressed: editOnPressed,
          label: editButtonText,
          buttonColor: cWhiteColor,
          borderColor: cBlackColor,
          buttonWidth: width - 40,
          textStyle: semiBold14TextStyle(cBlackColor),
          prefixIcon: BipHip.edit,
          prefixIconColor: cBlackColor,
        ),
        kH12sizedBox,
        CustomElevatedButton(
          onPressed: deleteOnPressed,
          label: deleteButtonText,
          buttonColor: cWhiteColor,
          borderColor: cBlackColor,
          buttonWidth: width - 40,
          textStyle: semiBold14TextStyle(cBlackColor),
          prefixIcon: BipHip.delete,
          prefixIconColor: cBlackColor,
        ),
      ],
    );
  }
}
