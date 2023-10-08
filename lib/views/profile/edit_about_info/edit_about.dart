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
                        showAddButton: _profileController.hometownData.value == null ? true : false,
                        buttonWidth: 151,
                        onPressedAdd: () {
                          _profileController.setEditPageValue(ksAddHomeTownAddress.tr, false, BipHip.location, _profileController.homeTownTextEditingController,
                              false, _profileController.homeTownTextEditingController, ksEnterHometownAddress.tr, false, true, false, false, '', 'HOMETOWN');
                          Get.toNamed(krEdit);
                        },
                      ),
                      if (_profileController.hometownData.value != null)
                        Padding(
                          padding: const EdgeInsets.only(top: k10Padding),
                          child: InfoContainer(
                            prefixIcon: BipHip.location,
                            suffixIcon: BipHip.edit,
                            text: checkNullOrStringNull(_profileController.hometownData.value!.city),
                            suffixOnPressed: () {
                              _globalController.commonBottomSheet(
                                  context: context,
                                  isScrollControlled: false,
                                  bottomSheetHeight: 160,
                                  content: EditModalSheet(
                                    editButtonText: ksEditAddress.tr,
                                    editOnPressed: () {
                                      _profileController.homeTownTextEditingController.text = _profileController.hometownData.value!.city!;
                                      _profileController.setEditPageValue(
                                          ksEditHometownAddress.tr,
                                          false,
                                          BipHip.location,
                                          _profileController.homeTownTextEditingController,
                                          false,
                                          _profileController.homeTownTextEditingController,
                                          ksEditHometownAddress.tr,
                                          false,
                                          true,
                                          false,
                                          false,
                                          'checkBoxText',
                                          'EDIT HOMETOWN');
                                      Get.toNamed(krEdit);
                                    },
                                    deleteButtonText: ksDeleteAddress.tr,
                                    deleteOnPressed: () {
                                      // _profileController.homeTown.value = '';
                                      //todo: implement hometown delete api
                                      Get.back();
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
                          _profileController.setEditPageValue(
                              ksAddPresentAddress.tr,
                              false,
                              BipHip.location,
                              _profileController.presentAddressTextEditingController,
                              false,
                              _profileController.presentAddressTextEditingController,
                              ksAddLocation.tr,
                              true,
                              true,
                              true,
                              _profileController.isCurrentlyLiveHere.value,
                              ksCurrentlyLivingHere.tr,
                              'ADD PRESENT');
                          Get.toNamed(krEdit);
                        },
                        buttonWidth: 108,
                      ),
                      if (_profileController.currentCityData.value!.city != null) kH12sizedBox,
                      if (_profileController.currentCityData.value!.city != null)
                        InfoContainer(
                          prefixIcon: BipHip.location,
                          suffixIcon: BipHip.edit,
                          text: checkNullOrStringNull(_profileController.currentCityData.value!.city),
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
                                title: ksEdit.tr,
                                isRightButtonShow: false,
                                content: EditModalSheet(
                                  editButtonText: ksEditAddress.tr,
                                  editOnPressed: () {
                                    _profileController.presentAddressTextEditingController.text = _profileController.currentCityData.value!.city!;
                                    _profileController.setEditPageValue(
                                        ksEditPresentAddress.tr,
                                        false,
                                        BipHip.location,
                                        _profileController.presentAddressTextEditingController,
                                        false,
                                        _profileController.presentAddressTextEditingController,
                                        ksEditLocation.tr,
                                        true,
                                        true,
                                        true,
                                        _profileController.isCurrentlyLiveHere.value,
                                        ksCurrentlyLivingHere.tr,
                                        'EDIT PRESENT');
                                    Get.toNamed(krEdit);
                                  },
                                  deleteButtonText: ksDeleteAddress.tr,
                                  deleteOnPressed: () {
                                    //todo: implement delete address api
                                    // _profileController.cityList.remove(item);
                                    Get.back();
                                  },
                                ));
                          },
                        ),
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
                                        title: ksEdit.tr,
                                        isRightButtonShow: false,
                                        content: EditModalSheet(
                                          editButtonText: ksEditAddress.tr,
                                          editOnPressed: () {
                                            _profileController.cityListIndex.value = index;
                                            _profileController.deleteIndex.value = index;
                                            _profileController.presentAddressTextEditingController.text = item;
                                            _profileController.setEditPageValue(
                                                ksEditPresentAddress.tr,
                                                false,
                                                BipHip.location,
                                                _profileController.presentAddressTextEditingController,
                                                false,
                                                _profileController.presentAddressTextEditingController,
                                                ksEditLocation.tr,
                                                true,
                                                true,
                                                true,
                                                _profileController.isCurrentlyLiveHere.value,
                                                ksCurrentlyLivingHere.tr,
                                                'EDIT PRESENT');
                                            Get.toNamed(krEdit);
                                          },
                                          deleteButtonText: ksDeleteAddress.tr,
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
                        ksRelationshipStatus.tr,
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
                            title: ksSelectRelationshipStatus.tr,
                            isRightButtonShow: false,
                          );
                        },
                        text: checkNullOrStringNull(_profileController.profileData.value!.user!.relation),
                        hintText: ksSelectRelationshipStatus.tr,
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
                      if (_profileController.schoolDataList.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: k16Padding),
                          child: Text(
                            ksSchool.tr,
                            style: semiBold16TextStyle(cBlackColor),
                          ),
                        ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: _profileController.schoolDataList.length,
                          itemBuilder: (context, index) {
                            var item = _profileController.schoolDataList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: k10Padding),
                              child: InfoContainer(
                                prefixIcon: BipHip.schoolNew,
                                suffixIcon: BipHip.edit,
                                text: checkNullOrStringNull(item.school),
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
                                      title: ksEdit.tr,
                                      isRightButtonShow: false,
                                      content: EditModalSheet(
                                        editButtonText: ksEditSchool.tr,
                                        editOnPressed: () {
                                          _profileController.schoolID.value = item.id!;
                                          _profileController.deleteIndex.value = index;
                                          _profileController.educationInstituteTextEditingController.text = item.school!;
                                          _profileController.setEditPageValue(
                                              ksEditSchool.tr,
                                              false,
                                              BipHip.schoolNew,
                                              _profileController.educationInstituteTextEditingController,
                                              false,
                                              _profileController.educationInstituteTextEditingController,
                                              ksEditSchool.tr,
                                              true,
                                              true,
                                              true,
                                              _profileController.isCurrentlyStudyingHere.value,
                                              ksCurrentlyStudyingHere.tr,
                                              'EDIT SCHOOL');
                                          Get.toNamed(krEdit);
                                        },
                                        deleteButtonText: ksDeleteSchool.tr,
                                        deleteOnPressed: () async {
                                          Get.back();
                                          await _profileController.deleteSchool(item.id);
                                        },
                                      ));
                                },
                              ),
                            );
                          }),
                      if (_profileController.collegeDataList.isNotEmpty)
                        Text(
                          ksCollege.tr,
                          style: semiBold16TextStyle(cBlackColor),
                        ),
                      kH16sizedBox,
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: _profileController.collegeDataList.length,
                          itemBuilder: (context, index) {
                            var item = _profileController.collegeDataList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: k10Padding),
                              child: InfoContainer(
                                prefixIcon: BipHip.schoolNew,
                                suffixIcon: BipHip.edit,
                                text: checkNullOrStringNull(item.school),
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
                                      title: ksEdit,
                                      isRightButtonShow: false,
                                      content: EditModalSheet(
                                        editButtonText: ksEditCollege.tr,
                                        editOnPressed: () {
                                          _profileController.collegeID.value = item.id!;
                                          _profileController.deleteIndex.value = index;
                                          _profileController.educationInstituteTextEditingController.text = item.school!;
                                          _profileController.setEditPageValue(
                                              ksEditCollege.tr,
                                              false,
                                              BipHip.schoolNew,
                                              _profileController.educationInstituteTextEditingController,
                                              false,
                                              _profileController.educationInstituteTextEditingController,
                                              ksEditCollege.tr,
                                              true,
                                              true,
                                              true,
                                              _profileController.isCurrentlyStudyingHere.value,
                                              ksCurrentlyStudyingHere.tr,
                                              'EDIT COLLEGE');
                                          Get.toNamed(krEdit);
                                        },
                                        deleteButtonText: ksDeleteCollege.tr,
                                        deleteOnPressed: () {
                                          _profileController.deleteCollege(item.id);
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
                            text: _profileController.profileData.value!.user!.profession[0],
                            hintText: ksSelectProfession.tr,
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
                          _profileController.setEditPageValue(
                              ksAddWorkplace.tr,
                              false,
                              BipHip.officeFill,
                              _profileController.officeNameTextEditingController,
                              true,
                              _profileController.designationTextEditingController,
                              ksOfficeName.tr,
                              true,
                              true,
                              true,
                              _profileController.isCurrentlyStudyingHere.value,
                              ksCurrentlyWorkingHere.tr,
                              'ADD WORKPLACE');
                          Get.toNamed(krEdit);
                        },
                        buttonWidth: 149,
                      ),
                      kH16sizedBox,
                      if (_profileController.profileData.value!.currentWorkplace != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: k10Padding),
                          child: InfoContainer(
                            prefixIcon: BipHip.officeFill,
                            suffixIcon: BipHip.edit,
                            text: checkNullOrStringNull(_profileController.profileData.value!.currentWorkplace!.company),
                            suffixOnPressed: () {
                              // _profileController.cityList.remove(_profileController.cityList[index]);
                              // _globalController.blankBottomSheet(
                              //     context: context,
                              //     isScrollControlled: false,
                              //     bottomSheetHeight: 130,
                              //     content: EditModalSheet(
                              //       editButtonText: ksEditWorkplace.tr,
                              //       editOnPressed: () {
                              //         _profileController.officeIndex.value = index;
                              //         _profileController.deleteIndex.value = index;
                              //         _profileController.officeNameTextEditingController.text = item['office'];
                              //         _profileController.designationTextEditingController.text = item['designation'];
                              //         _profileController.setEditPageValue(
                              //             ksEditWorkplace.tr,
                              //             false,
                              //             BipHip.officeFill,
                              //             _profileController.officeNameTextEditingController,
                              //             true,
                              //             _profileController.designationTextEditingController,
                              //             ksEditWorkplace.tr,
                              //             true,
                              //             true,
                              //             true,
                              //             _profileController.isCurrentlyWorkingHere.value,
                              //             ksCurrentlyWorkingHere.tr,
                              //             'EDIT WORKPLACE');
                              //         Get.toNamed(krEdit);
                              //       },
                              //       deleteButtonText: ksDeleteWorkplace.tr,
                              //       deleteOnPressed: () {
                              //         // _profileController.officeList.remove(item);
                              //         Get.back();
                              //       },
                              //     ));
                            },
                          ),
                        ),
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
                                        editButtonText: ksEditWorkplace.tr,
                                        editOnPressed: () {
                                          _profileController.officeIndex.value = index;
                                          _profileController.deleteIndex.value = index;
                                          _profileController.officeNameTextEditingController.text = item['office'];
                                          _profileController.designationTextEditingController.text = item['designation'];
                                          _profileController.setEditPageValue(
                                              ksEditWorkplace.tr,
                                              false,
                                              BipHip.officeFill,
                                              _profileController.officeNameTextEditingController,
                                              true,
                                              _profileController.designationTextEditingController,
                                              ksEditWorkplace.tr,
                                              true,
                                              true,
                                              true,
                                              _profileController.isCurrentlyWorkingHere.value,
                                              ksCurrentlyWorkingHere.tr,
                                              'EDIT WORKPLACE');
                                          Get.toNamed(krEdit);
                                        },
                                        deleteButtonText: ksDeleteWorkplace.tr,
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
                        ksContactDetails.tr,
                        style: semiBold18TextStyle(cBlackColor),
                      ),
                      kH20sizedBox,
                      RowTextButton(
                        text: ksPhone.tr,
                        buttonText: ksAdd.tr,
                        showAddButton: true,
                        onPressedAdd: () {
                          _profileController.setEditPageValue(ksAddPhoneNumber.tr, false, BipHip.phoneFill, _profileController.phoneTextEditingController,
                              false, _profileController.phoneTextEditingController, ksPhone.tr, false, true, false, false, '', 'ADD PHONE');
                          Get.toNamed(krEdit);
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
                                _globalController.blankBottomSheet(
                                    context: context,
                                    isScrollControlled: false,
                                    bottomSheetHeight: 130,
                                    content: EditModalSheet(
                                      editButtonText: ksEditPhone.tr,
                                      editOnPressed: () {
                                        _profileController.phoneID.value = _profileController.contactDataList[i].id!;
                                        _profileController.phoneTextEditingController.text = _profileController.contactDataList[i].value!;
                                        _profileController.setEditPageValue(
                                            ksEditPhone.tr,
                                            false,
                                            BipHip.phoneFill,
                                            _profileController.phoneTextEditingController,
                                            false,
                                            _profileController.phoneTextEditingController,
                                            ksEditPhone.tr,
                                            false,
                                            true,
                                            false,
                                            false,
                                            '',
                                            'EDIT PHONE');
                                        Get.toNamed(krEdit);
                                      },
                                      deleteButtonText: ksDeletePhone.tr,
                                      deleteOnPressed: () {
                                        // _profileController.phoneList.remove(item);
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
                          _profileController.setEditPageValue(ksAddEmail.tr, false, BipHip.mail, _profileController.emailTextEditingController, false,
                              _profileController.emailTextEditingController, ksEmail.tr, false, true, false, false, '', 'ADD EMAIL');
                          Get.toNamed(krEdit);
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
                                _globalController.blankBottomSheet(
                                    context: context,
                                    isScrollControlled: false,
                                    bottomSheetHeight: 130,
                                    content: EditModalSheet(
                                      editButtonText: ksEditEmail.tr,
                                      editOnPressed: () {
                                        _profileController.emailID.value = _profileController.contactDataList[i].id!;
                                        _profileController.emailTextEditingController.text = _profileController.contactDataList[i].value!;
                                        _profileController.setEditPageValue(
                                            ksEditEmail.tr,
                                            false,
                                            BipHip.mail,
                                            _profileController.emailTextEditingController,
                                            false,
                                            _profileController.emailTextEditingController,
                                            ksEditEmail.tr,
                                            false,
                                            true,
                                            false,
                                            false,
                                            '',
                                            'EDIT EMAIL');
                                        Get.toNamed(krEdit);
                                      },
                                      deleteButtonText: ksDeleteEmail.tr,
                                      deleteOnPressed: () {

                                        Get.back();
                                      },
                                    ));
                              },
                            ),
                          ),
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
