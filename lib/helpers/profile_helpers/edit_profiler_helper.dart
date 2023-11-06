import 'package:bip_hip/controllers/auth/authentication_controller.dart';
import 'package:bip_hip/controllers/menu/profile_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class EditProfileHelper{
  final ProfileController _profileController = Get.find<ProfileController>();
  final AuthenticationController _authenticationController = Get.find<AuthenticationController>();
  final GlobalController _globalController = Get.find<GlobalController>();
}