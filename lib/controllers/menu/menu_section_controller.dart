import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/models/menu/profile/common_list_models.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class MenuSectionController extends GetxController {
  final SpController spController = SpController();
  final ApiController apiController = ApiController();
  final ProfileController profileController = Get.find<ProfileController>();

  final RxBool isSupportButtonPressed = RxBool(false);
  final RxBool isSettingButtonPressed = RxBool(false);
  List shortcutButtonContent = [
    {'text': 'Friend', 'icon': BipHip.friends},
    {'text': 'Family', 'icon': BipHip.addFamily},
    {'text': 'Images', 'icon': BipHip.imageFile},
    {'text': 'Videos', 'icon': BipHip.playNew},
    {'text': 'Badges', 'icon': BipHip.giftNew},
    {'text': 'Pendent', 'icon': BipHip.badgesFill},
    {'text': 'Earnings', 'icon': BipHip.earnings},
    {'text': 'Kids', 'icon': BipHip.kids},
    {'text': 'Stores', 'icon': BipHip.shopFill},
    {'text': 'Quiz', 'icon': BipHip.activity},
  ];

  List supportButtonContent = [
    {
      'text': 'Help Center',
      'icon': BipHip.helpFill,
      'onPressed': () {
        ll('help center');
      }
    },
    {
      'text': 'Support Inbox',
      'icon': BipHip.supportInbox,
      'onPressed': () {
        ll('Support inbox');
      }
    },
    {
      'text': 'Report a Problem',
      'icon': BipHip.report,
      'onPressed': () {
        ll('Report a problem');
      }
    },
    {
      'text': 'Terms & Conditions',
      'icon': BipHip.termsCondition,
      'onPressed': () {
        ll('Terms and condition');
      }
    },
  ];

  List settingsButtonContent = [
    {
      'text': 'Setting',
      'icon': BipHip.setting,
      'onPressed': () {
        ll('Setting');
        Get.toNamed(krSettings);
      }
    },
    {
      'text': 'Recent Activity',
      'icon': BipHip.activity,
      'onPressed': () {
        ll('Recent Activity');
      }
    },
    {
      'text': 'Dark Mode',
      'icon': BipHip.darkMode,
      'onPressed': () {
        ll('Dark Mode');
      }
    },
    {
      'text': 'Language',
      'icon': BipHip.language,
      'onPressed': () {
        ll('Language');
      }
    },
  ];

  List friendList = [
    {'name': 'Karnaze Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Joe Biden', 'image': kiFriendImageUrl},
    {'name': 'Stewie Griffin', 'image': kiFriendImageUrl},
    {'name': 'Rick Sanchez', 'image': kiFriendImageUrl},
    {'name': 'Johan Liebert', 'image': kiFriendImageUrl},
    {'name': 'Akshia Rekrahs', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl}
  ];

  List familyList = [
    {'name': 'Peter Griffin', 'image': kiFamilyImageUrl},
    {'name': 'Vladmir Putin', 'image': kiFamilyImageUrl},
    {'name': 'Meg Griffin', 'image': kiFamilyImageUrl},
    {'name': 'Rick Sanchez', 'image': kiFamilyImageUrl},
    {'name': 'Morty Sanchez', 'image': kiFamilyImageUrl},
    {'name': 'Beth Sanchez', 'image': kiFamilyImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl},
    {'name': 'Alyssa Krnunkenstein', 'image': kiFriendImageUrl}
  ];

  final TextEditingController firstNameEditingController = TextEditingController();
  final TextEditingController lastNameEditingController = TextEditingController();
  final RxBool changeNameBottomSheetButtonState = RxBool(false);
  //* name change API Implementation
  RxBool isChangeNameLoading = RxBool(false);
  Future<void> changeName() async {
    try {
      isChangeNameLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        'first_name': firstNameEditingController.text.trim(),
        'last_name': lastNameEditingController.text.trim(),
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateUserFullName,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        ll(response.data);
        profileController.commonUserLayeredData.value = CommonUserDataModel.fromJson(response.data);
        profileController.userData.value = profileController.commonUserLayeredData.value!.user;
        var rememberMe = await spController.getRememberMe();
        if (rememberMe == true) {
          await spController.saveUserList({
            "email": profileController.userData.value!.email.toString(),
            "name": profileController.userData.value!.fullName.toString(),
            "first_name": profileController.userData.value!.firstName.toString(),
            "last_name": profileController.userData.value!.lastName.toString(),
            "image_url": profileController.userData.value!.profilePicture.toString(),
            "token": token.toString(),
          });
        }
        await spController.saveUserFirstName(profileController.userData.value!.firstName.toString());
        await spController.saveUserLastName(profileController.userData.value!.lastName.toString());
        await spController.saveUserName(profileController.userData.value!.fullName.toString());
        await Get.find<GlobalController>().getUserInfo();
        isChangeNameLoading.value = false;
        Get.find<GlobalController>().showSnackBar(title: ksSuccess.tr, message: response.message, color: cGreenColor, duration: 1000);
      } else {
        isChangeNameLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          Get.find<GlobalController>().showSnackBar(title: ksError.tr, message: response.message, color: cRedColor);
        } else {
          Get.find<GlobalController>().showSnackBar(title: ksError.tr, message: errorModel.errors[0].message, color: cRedColor);
        }
      }
    } catch (e) {
      isChangeNameLoading.value = false;
      ll('changeName error: $e');
    }
  }

  void checkCanChangeName() {
    if (firstNameEditingController.text != Get.find<GlobalController>().userFirstName.value ||
        lastNameEditingController.text != Get.find<GlobalController>().userLastName.value &&
            (firstNameEditingController.text.trim() != '' && lastNameEditingController.text.trim() != '')) {
      changeNameBottomSheetButtonState.value = true;
    } else {
      changeNameBottomSheetButtonState.value = false;
    }
  }
}
