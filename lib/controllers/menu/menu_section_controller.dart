import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/models/menu/profile/common_list_models.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class MenuSectionController extends GetxController {
  final SpController _spController = SpController();
  final ApiController _apiController = ApiController();
  final ProfileController _profileController = Get.find<ProfileController>();

  final RxBool isSupportButtonPressed = RxBool(false);
  final RxBool isSettingButtonPressed = RxBool(false);
  List shortcutButtonContent = [
    {'text': 'Friend', 'icon': BipHip.friends},
    {'text': 'Family', 'icon': BipHip.addFamily},
    {'text': 'Images', 'icon': BipHip.imageFile},
    {'text': 'Videos', 'icon': BipHip.playNew},
    {'text': 'Stars', 'icon': BipHip.giftNew},
    {'text': 'Badges', 'icon': BipHip.badgesFill},
    {'text': 'Earnings', 'icon': BipHip.earnings},
    {'text': 'Kids', 'icon': BipHip.kids},
    {'text': 'Shop', 'icon': BipHip.shopFill},
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
  //* name change API Implementation
  RxBool isChangeNameLoading = RxBool(false);
  Future<void> changeName() async {
    try {
      isChangeNameLoading.value = true;
      String? token = await _spController.getBearerToken();
      Map<String, dynamic> body = {
        'first_name': firstNameEditingController.text.trim(),
        'last_name': lastNameEditingController.text.trim(),
      };
      var response = await _apiController.commonApiCall(
        requestMethod: kPost,
        url: kuUpdateUserFullName,
        body: body,
        token: token,
      ) as CommonDM;

      if (response.success == true) {
        ll(response.data);
        _profileController.commonUserLayeredData.value = CommonUserDataModel.fromJson(response.data);
        _profileController.userData.value = _profileController.commonUserLayeredData.value!.user;
        var rememberMe = await _spController.getRememberMe();
        if (rememberMe == true) {
          await _spController.saveUserList({
            "email": _profileController.userData.value!.email.toString(),
            "name": _profileController.userData.value!.fullName.toString(),
            "first_name": _profileController.userData.value!.firstName.toString(),
            "last_name": _profileController.userData.value!.lastName.toString(),
            "image_url": _profileController.userData.value!.profilePicture.toString(),
            "token": token.toString(),
          });
        }
        await _spController.saveUserFirstName(_profileController.userData.value!.firstName.toString());
        await _spController.saveUserLastName(_profileController.userData.value!.lastName.toString());
        await _spController.saveUserName(_profileController.userData.value!.fullName.toString());
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
}
