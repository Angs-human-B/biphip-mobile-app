import 'package:bip_hip/controllers/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/profile/edit_profile.dart';
import 'package:bip_hip/widgets/common/button/custom_filter_chips.dart';
import 'package:bip_hip/widgets/common/button/custom_modified_text_button.dart';
import 'package:bip_hip/widgets/common/button/custom_outline_button.dart';
import 'package:intl/intl.dart';

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
              title: ksAbout.tr,
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
                        ksAddress.tr,
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      kH20sizedBox,
                      RowTextButton(
                        text: ksHomeTown.tr,
                        buttonText: ksAdd.tr,
                        showAddButton: true,
                        buttonWidth: 151,
                        onPressedAdd: () {
                          _profileController.getMethod(9);
                        },
                      ),
                      for (int i = 0; i < _profileController.otherCityList.length; i++)
                        if (_profileController.otherCityList[i].isHometown == 1)
                          Padding(
                            padding: const EdgeInsets.only(top: k10Padding),
                            child: InfoContainer(
                              prefixIcon: BipHip.location,
                              suffixIcon: BipHip.edit,
                              text: checkNullOrStringNull(_profileController.otherCityList[i].city),
                              suffixOnPressed: () {
                                _globalController.commonBottomSheet(
                                    context: context,
                                    isScrollControlled: false,
                                    bottomSheetHeight: isDeviceScreenLarge() ? 180 : 160,
                                    content: EditModalSheet(
                                      editButtonText: ksEditAddress.tr,
                                      editOnPressed: () {
                                        _profileController.getMethod(0);
                                      },
                                      deleteButtonText: ksDeleteAddress.tr,
                                      deleteOnPressed: () async {
                                        Get.back();
                                        await _profileController.deleteCity(_profileController.hometownData.value!.id);
                                      },
                                    ),
                                    onPressCloseButton: () {
                                      Get.back();
                                    },
                                    onPressRightButton: null,
                                    rightText: '',
                                    rightTextStyle: regular10TextStyle(cBlackColor),
                                    title: ksEdit.tr,
                                    isRightButtonShow: false);
                              },
                            ),
                          ),
                      kH16sizedBox,
                      RowTextButton(
                        text: ksPresentAddress.tr,
                        buttonText: ksAdd.tr,
                        showAddButton: true,
                        onPressedAdd: () {
                          _profileController.getMethod(1);
                          Get.toNamed(krEdit);
                        },
                        buttonWidth: 108,
                      ),
                      for (int i = 0; i < _profileController.otherCityList.length; i++)
                        if (_profileController.otherCityList[i].isCurrent == 1)
                          Padding(
                            padding: const EdgeInsets.only(top: h16),
                            child: InfoContainer(
                              prefixIcon: BipHip.location,
                              suffixIcon: BipHip.edit,
                              text: checkNullOrStringNull(_profileController.currentCityData.value!.city),
                              suffixOnPressed: () {
                                // _profileController.cityList.remove(_profileController.cityList[index]);
                                _globalController.commonBottomSheet(
                                    context: context,
                                    isScrollControlled: false,
                                    bottomSheetHeight: isDeviceScreenLarge() ? 180 : 160,
                                    onPressCloseButton: () {
                                      Get.back();
                                    },
                                    onPressRightButton: null,
                                    rightText: '',
                                    rightTextStyle: regular10TextStyle(cBlackColor),
                                    title: ksEdit.tr,
                                    isRightButtonShow: false,
                                    content: EditModalSheet(
                                      editButtonText: ksEditAddress.tr,
                                      editOnPressed: () {
                                        _profileController.cityID.value = _profileController.currentCityData.value!.id!;
                                        _profileController.getMethod(2);
                                      },
                                      deleteButtonText: ksDeleteAddress.tr,
                                      deleteOnPressed: () async {
                                        _profileController.deleteCity(_profileController.currentCityData.value!.id!);

                                        Get.back();
                                      },
                                    ));
                              },
                            ),
                          ),
                      kH16sizedBox,
                      RowTextButton(
                        text: ksOther.tr,
                        buttonText: ksAdd.tr,
                        showAddButton: true,
                        onPressedAdd: () {
                          _profileController.getMethod(3);
                          Get.toNamed(krEdit);
                        },
                        buttonWidth: 108,
                      ),
                      kH16sizedBox,
                      for (int i = 0; i < _profileController.otherCityList.length; i++)
                        if (_profileController.otherCityList[i].isCurrent == 0 && _profileController.otherCityList[i].isHometown == 0)
                          Padding(
                            padding: const EdgeInsets.only(bottom: k10Padding),
                            child: InfoContainer(
                              prefixIcon: BipHip.location,
                              suffixIcon: BipHip.edit,
                              text: _profileController.otherCityList[i].city!,
                              suffixOnPressed: () {
                                _profileController.cityID.value = _profileController.otherCityList[i].id!;
                                _globalController.commonBottomSheet(
                                    context: context,
                                    isScrollControlled: false,
                                    bottomSheetHeight: isDeviceScreenLarge() ? 180 : 160,
                                    onPressCloseButton: () {
                                      Get.back();
                                    },
                                    onPressRightButton: null,
                                    rightText: '',
                                    rightTextStyle: regular10TextStyle(cBlackColor),
                                    title: ksEdit.tr,
                                    isRightButtonShow: false,
                                    content: EditModalSheet(
                                      editButtonText: ksEditAddress.tr,
                                      editOnPressed: () {
                                        // _profileController.cityListIndex.value = index;
                                        _profileController.presentAddressTextEditingController.text = _profileController.otherCityList[i].city!;
                                        _profileController.getMethod(4);
                                      },
                                      deleteButtonText: ksDeleteAddress.tr,
                                      deleteOnPressed: () async {
                                        _profileController.deleteCity(_profileController.otherCityList[i].id);
                                        Get.back();
                                      },
                                    ));
                              },
                            ),
                          ),
                      const CustomDivider(),
                      kH16sizedBox,
                      RowTextButton(
                        text: 'Education Background',
                        buttonText: 'Add',
                        showAddButton: true,
                        onPressedAdd: () {
                          _profileController.getMethod(5);
                        },
                        buttonWidth: 126,
                      ),
                      if (_profileController.schoolDataList.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: k16Padding),
                          child: Text(
                            ksSchool.tr,
                            style: semiBold16TextStyle(cBlackColor),
                          ),
                        ),
                      for (int i = 0; i < _profileController.schoolDataList.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: k10Padding),
                          child: InfoContainer(
                            prefixIcon: BipHip.schoolNew,
                            suffixIcon: BipHip.edit,
                            text: checkNullOrStringNull(_profileController.schoolDataList[i].school),
                            suffixOnPressed: () {
                              // _profileController.cityList.remove(_profileController.cityList[index]);
                              _globalController.commonBottomSheet(
                                  context: context,
                                  isScrollControlled: false,
                                  bottomSheetHeight: isDeviceScreenLarge() ? 180 : 160,
                                  onPressCloseButton: () {
                                    Get.back();
                                  },
                                  onPressRightButton: null,
                                  rightText: '',
                                  rightTextStyle: regular10TextStyle(cBlackColor),
                                  title: ksEdit.tr,
                                  isRightButtonShow: false,
                                  content: EditModalSheet(
                                    editButtonText: ksEditSchool.tr,
                                    editOnPressed: () {
                                      _profileController.schoolID.value = _profileController.schoolDataList[i].id!;
                                      _profileController.educationInstituteTextEditingController.text = _profileController.schoolDataList[i].school!;
                                      if (_profileController.schoolDataList[i].graduated == 1) {
                                        _profileController.isCurrentlyStudyingHere.value = true;
                                      } else {
                                        _profileController.isCurrentlyStudyingHere.value = false;
                                      }
                                      _profileController.getMethod(6);
                                    },
                                    deleteButtonText: ksDeleteSchool.tr,
                                    deleteOnPressed: () async {
                                      Get.back();
                                      await _profileController.deleteSchool(_profileController.schoolDataList[i].id);
                                    },
                                  ));
                            },
                          ),
                        ),
                      if (_profileController.collegeDataList.isNotEmpty)
                        Text(
                          ksCollege.tr,
                          style: semiBold16TextStyle(cBlackColor),
                        ),
                      kH16sizedBox,
                      for (int i = 0; i < _profileController.collegeDataList.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: k10Padding),
                          child: InfoContainer(
                            prefixIcon: BipHip.schoolNew,
                            suffixIcon: BipHip.edit,
                            text: checkNullOrStringNull(_profileController.collegeDataList[i].school),
                            suffixOnPressed: () {
                              // _profileController.cityList.remove(_profileController.cityList[index]);
                              _globalController.commonBottomSheet(
                                  context: context,
                                  isScrollControlled: false,
                                  bottomSheetHeight: isDeviceScreenLarge() ? 180 : 160,
                                  onPressCloseButton: () {
                                    Get.back();
                                  },
                                  onPressRightButton: null,
                                  rightText: '',
                                  rightTextStyle: regular10TextStyle(cBlackColor),
                                  title: ksEdit,
                                  isRightButtonShow: false,
                                  content: EditModalSheet(
                                    editButtonText: ksEditCollege.tr,
                                    editOnPressed: () {
                                      _profileController.collegeID.value = _profileController.collegeDataList[i].id!;

                                      _profileController.educationInstituteTextEditingController.text = _profileController.collegeDataList[i].school!;
                                      if (_profileController.collegeDataList[i].graduated == 1) {
                                        _profileController.isCurrentlyStudyingHere.value = true;
                                      } else {
                                        _profileController.isCurrentlyStudyingHere.value = false;
                                      }
                                      _profileController.getMethod(7);
                                    },
                                    deleteButtonText: ksDeleteCollege.tr,
                                    deleteOnPressed: () {
                                      Get.back();
                                      _profileController.deleteCollege(_profileController.collegeDataList[i].id);
                                    },
                                  ));
                            },
                          ),
                        ),
                      const CustomDivider(),
                      kH16sizedBox,
                      Text(
                        ksRelationshipStatus.tr,
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      kH20sizedBox,
                      // CustomSelectionButton(
                      //   prefixIcon: BipHip.love,
                      //   onPressed: () {
                      //     _profileController.showEditRelationshipStatus.value = true;
                      //     _globalController.commonBottomSheet(
                      //       context: context,
                      //       content: _RelationshipStatusListContent(
                      //         profileController: _profileController,
                      //       ),
                      //       isScrollControlled: true,
                      //       bottomSheetHeight: height * 0.6,
                      //       onPressCloseButton: () {
                      //         Get.back();
                      //       },
                      //       onPressRightButton: null,
                      //       rightText: '',
                      //       rightTextStyle: regular10TextStyle(cBlackColor),
                      //       title: ksSelectRelationshipStatus.tr,
                      //       isRightButtonShow: false,
                      //     );
                      //   },
                      //   text: checkNullOrStringNull(_profileController.profileData.value!.user!.relation) ?? ksSelectRelationshipStatus,
                      //   hintText: ksSelectRelationshipStatus.tr,
                      // ),
                      InfoContainer(
                        prefixIcon: BipHip.love,
                        suffixIcon: BipHip.downArrow,
                        text: checkNullOrStringNull(_profileController.profileData.value!.user!.relation) ?? ksSelectRelationshipStatus,
                        suffixOnPressed: () {
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
                            onPressRightButton: () {
                              Get.back();
                            },
                            rightText: ksDone.tr,
                            rightTextStyle: medium14TextStyle(cPrimaryColor),
                            title: ksSelectRelationshipStatus.tr,
                            isRightButtonShow: true,
                          );
                        },
                      ),
                      if (_profileController.relationshipStatus.value != '' && _profileController.showEditRelationshipStatus.value) kH20sizedBox,
                      if (_profileController.relationshipStatus.value != '' && _profileController.showEditRelationshipStatus.value)
                        OutLinedButton(
                          buttonWidth: 80,
                          buttonHeight: 25,
                          onPress: () {},
                          buttonText: ksPublic.tr,
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
                      kH16sizedBox,
                      const CustomDivider(),
                      kH16sizedBox,
                      RowTextButton(
                        text: ksDateOfBirth.tr,
                        buttonText: ksAdd.tr,
                        showAddButton: false,
                        onPressedAdd: null,
                        buttonWidth: 149,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: InfoContainer(
                          prefixIcon: BipHip.calendarFill,
                          suffixIcon: BipHip.edit,
                          text: DateFormat("yyyy-MM-dd").format(_profileController.userData.value!.dob!),
                          suffixOnPressed: () {
                            _profileController.isRouteFromAboutInfo.value = true;
                            Get.toNamed(krSelectBirthday);
                          },
                        ),
                      ),
                      kH16sizedBox,
                      const CustomDivider(),
                      kH16sizedBox,
                      RowTextButton(
                        text: ksProfession.tr,
                        buttonText: ksAdd.tr,
                        showAddButton: _profileController.profileData.value!.user!.profession.isEmpty,
                        onPressedAdd: () {
                          _profileController.isRouteFromAboutInfo.value = true;
                          Get.toNamed(krSelectProfession);
                        },
                        buttonWidth: 149,
                      ),
                      if (_profileController.profileData.value!.user!.profession.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: InfoContainer(
                            prefixIcon: BipHip.work,
                            suffixIcon: BipHip.edit,
                            //text: _profileController.profileData.value!.user!.profession[0] ?? ksSelectProfession.tr,
                            text: ksSelectProfession.tr,
                            suffixOnPressed: () {
                              _globalController.commonBottomSheet(
                                  context: context,
                                  isScrollControlled: false,
                                  bottomSheetHeight: isDeviceScreenLarge() ? 180 : 160,
                                  onPressCloseButton: () {
                                    Get.back();
                                  },
                                  onPressRightButton: null,
                                  rightText: '',
                                  rightTextStyle: regular10TextStyle(cBlackColor),
                                  title: ksEdit.tr,
                                  isRightButtonShow: false,
                                  content: EditModalSheet(
                                    editButtonText: ksEditProfession.tr,
                                    editOnPressed: () {
                                      _profileController.isRouteFromAboutInfo.value = true;
                                      Get.back();
                                      Get.toNamed(krSelectProfession);
                                    },
                                    deleteButtonText: ksDeleteProfession.tr,
                                    deleteOnPressed: () {
                                      _profileController.selectedProfession.value = '';
                                      Get.back();
                                    },
                                  ));
                            },
                          ),
                        ),
                      kH16sizedBox,
                      const CustomDivider(),
                      kH16sizedBox,
                      RowTextButton(
                        text: ksInterest.tr,
                        buttonText: ksAdd.tr,
                        showAddButton: true,
                        onPressedAdd: () {
                          _profileController.isRouteFromAboutInfo.value = true;
                          Get.toNamed(krSelectInterest);
                        },
                        buttonWidth: 149,
                      ),
                      if (_profileController.profileData.value!.user!.interest.isNotEmpty)
                        Wrap(
                          alignment: WrapAlignment.start,
                          direction: Axis.horizontal,
                          spacing: 8.0,
                          children: [
                            for (int i = 0; i < _profileController.profileData.value!.user!.interest.length; i++)
                              CustomChoiceChips(
                                label: _profileController.profileData.value!.user!.interest[i],
                                isSelected: false,
                                onSelected: null,
                              )
                          ],
                        ),
                      kH16sizedBox,
                      const CustomDivider(),
                      kH16sizedBox,
                      RowTextButton(
                        text: ksWork.tr,
                        buttonText: ksAdd.tr,
                        showAddButton: true,
                        onPressedAdd: () {
                          _profileController.getMethod(8);
                        },
                        buttonWidth: 149,
                      ),
                      kH16sizedBox,
                      for (int i = 0; i < _profileController.workplaceDataList.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: k10Padding),
                          child: InfoContainer(
                            prefixIcon: BipHip.officeFill,
                            suffixIcon: BipHip.edit,
                            text: _profileController.workplaceDataList[i].company!,
                            suffixOnPressed: () {
                              // _profileController.cityList.remove(_profileController.cityList[index]);
                              _globalController.commonBottomSheet(
                                  isScrollControlled: false,
                                  bottomSheetHeight: isDeviceScreenLarge() ? 180 : 160,
                                  onPressCloseButton: () {
                                    Get.back();
                                  },
                                  onPressRightButton: null,
                                  rightText: '',
                                  rightTextStyle: regular10TextStyle(cBlackColor),
                                  title: ksEdit.tr,
                                  isRightButtonShow: false,
                                  context: context,
                                  content: EditModalSheet(
                                    editButtonText: ksEditWorkplace.tr,
                                    editOnPressed: () {
                                      _profileController.officeID.value = _profileController.workplaceDataList[i].id!;
                                      _profileController.companyNameTextEditingController.text = _profileController.workplaceDataList[i].company!;
                                      _profileController.designationTextEditingController.text = _profileController.workplaceDataList[i].position ?? '';
                                      if (_profileController.workplaceDataList[i].isCurrent == 1) {
                                        _profileController.isCurrentlyWorkingHere.value = true;
                                      } else {
                                        _profileController.isCurrentlyWorkingHere.value = false;
                                      }
                                      _profileController.getMethod(10);
                                    },
                                    deleteButtonText: ksDeleteWorkplace.tr,
                                    deleteOnPressed: () async {
                                      Get.back();
                                      await _profileController.deleteWork(_profileController.workplaceDataList[i].id);
                                    },
                                  ));
                            },
                          ),
                        ),
                      const CustomDivider(),
                      kH16sizedBox,
                      Text(
                        ksContactDetails.tr,
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      kH20sizedBox,
                      RowTextButton(
                        text: ksPhone.tr,
                        buttonText: ksAdd.tr,
                        showAddButton: true,
                        onPressedAdd: () {
                          _profileController.getMethod(11);
                        },
                        buttonWidth: 177,
                      ),
                      kH16sizedBox,
                      for (int i = 0; i < _profileController.contactDataList.length; i++)
                        if (_profileController.contactDataList[i].type == 'phone')
                          Padding(
                            padding: const EdgeInsets.only(bottom: k10Padding),
                            child: InfoContainer(
                              prefixIcon: BipHip.phoneFill,
                              suffixIcon: BipHip.edit,
                              text: checkNullOrStringNull(_profileController.contactDataList[i].value),
                              suffixOnPressed: () {
                                _globalController.commonBottomSheet(
                                    context: context,
                                    isScrollControlled: false,
                                    bottomSheetHeight: isDeviceScreenLarge() ? 180 : 160,
                                    onPressCloseButton: () {
                                      Get.back();
                                    },
                                    onPressRightButton: null,
                                    rightText: '',
                                    rightTextStyle: regular10TextStyle(cBlackColor),
                                    title: ksEdit.tr,
                                    isRightButtonShow: false,
                                    content: EditModalSheet(
                                      editButtonText: ksEditPhone.tr,
                                      editOnPressed: () {
                                        _profileController.phoneID.value = _profileController.contactDataList[i].id!;
                                        _profileController.phoneTextEditingController.text = _profileController.contactDataList[i].value!;
                                        _profileController.getMethod(12);
                                      },
                                      deleteButtonText: ksDeletePhone.tr,
                                      deleteOnPressed: () async {
                                        _profileController.deleteContact(_profileController.contactDataList[i].id);
                                        Get.back();
                                      },
                                    ));
                              },
                            ),
                          ),
                      if (_profileController.phoneList.isNotEmpty) kH8sizedBox,
                      RowTextButton(
                        text: ksEmail.tr,
                        buttonText: ksAdd.tr,
                        showAddButton: true,
                        onPressedAdd: () {
                          _profileController.getMethod(13);
                        },
                        buttonWidth: 118,
                      ),
                      kH16sizedBox,
                      for (int i = 0; i < _profileController.contactDataList.length; i++)
                        if (_profileController.contactDataList[i].type == 'email')
                          Padding(
                            padding: const EdgeInsets.only(bottom: k10Padding),
                            child: InfoContainer(
                              prefixIcon: BipHip.mail,
                              suffixIcon: BipHip.edit,
                              text: checkNullOrStringNull(_profileController.contactDataList[i].value),
                              suffixOnPressed: () {
                                _globalController.commonBottomSheet(
                                    context: context,
                                    isScrollControlled: false,
                                    bottomSheetHeight: isDeviceScreenLarge() ? 180 : 160,
                                    onPressCloseButton: () {
                                      Get.back();
                                    },
                                    onPressRightButton: null,
                                    rightText: '',
                                    rightTextStyle: regular10TextStyle(cBlackColor),
                                    title: ksEdit.tr,
                                    isRightButtonShow: false,
                                    content: EditModalSheet(
                                      editButtonText: ksEditEmail.tr,
                                      editOnPressed: () {
                                        _profileController.emailID.value = _profileController.contactDataList[i].id!;
                                        _profileController.emailTextEditingController.text = _profileController.contactDataList[i].value!;
                                        _profileController.getMethod(14);
                                      },
                                      deleteButtonText: ksDeleteEmail.tr,
                                      deleteOnPressed: () async {
                                        await _profileController.deleteContact(_profileController.contactDataList[i].id);
                                        Get.back();
                                      },
                                    ));
                              },
                            ),
                          ),
                      kH16sizedBox,
                      const CustomDivider(),
                      kH16sizedBox,
                      RowTextButton(
                        text: ksWebsiteAndSocialLinks.tr,
                        buttonText: ksAdd.tr,
                        showAddButton: true,
                        onPressedAdd: () {
                          _profileController.getMethod(15);
                        },
                        buttonWidth: 109,
                      ),
                      kH16sizedBox,
                      for (int i = 0; i < _profileController.linkDataList.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: k10Padding),
                          child: InfoContainer(
                            prefixIcon: _profileController.getLinkIcon(_profileController.linkDataList[i].type!),
                            suffixIcon: BipHip.edit,
                            text: checkNullOrStringNull(_profileController.linkDataList[i].link),
                            suffixOnPressed: () {
                              _globalController.commonBottomSheet(
                                  context: context,
                                  isScrollControlled: false,
                                  bottomSheetHeight: isDeviceScreenLarge() ? 180 : 160,
                                  onPressCloseButton: () {
                                    Get.back();
                                  },
                                  onPressRightButton: null,
                                  rightText: '',
                                  rightTextStyle: regular10TextStyle(cBlackColor),
                                  title: ksEdit.tr,
                                  isRightButtonShow: false,
                                  content: EditModalSheet(
                                    editButtonText: ksEditLink.tr,
                                    editOnPressed: () {
                                      _profileController.linkTextEditingController.text = _profileController.linkDataList[i].link!;
                                      _profileController.linkID.value = _profileController.linkDataList[i].id!;
                                      _profileController.linkSource.value = _profileController.linkDataList[i].type!;
                                      _profileController.getMethod(16);
                                    },
                                    deleteButtonText: ksDeleteLink.tr,
                                    deleteOnPressed: () async {
                                      Get.back();
                                      await _profileController.deleteLink(_profileController.linkDataList[i].id);
                                    },
                                  ));
                            },
                          ),
                        ),
                      kH12sizedBox
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
    return InkWell(
      onTap: suffixOnPressed,
      child: Container(
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
                  size: screenWiseSize(kIconSize24, 4),
                ),
              ),
              kW8sizedBox,
              Text(
                text,
                style: regular16TextStyle(cIconColor),
              ),
              const Spacer(),
              Icon(
                suffixIcon,
                size: screenWiseSize(kIconSize22, 4),
                color: cIconColor,
              )
            ],
          ),
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
            label: ksCancel.tr,
            textStyle: semiBold14TextStyle(cRedColor),
            buttonColor: cWhiteColor,
            borderColor: cRedColor,
            buttonHeight: h32,
            buttonWidth: 80,
            onPressed: onPressedCancel),
        kW16sizedBox,
        CustomElevatedButton(label: ksSave.tr, textStyle: semiBold14TextStyle(cWhiteColor), buttonHeight: h32, buttonWidth: 80, onPressed: onPressedSave),
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
