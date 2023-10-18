import 'package:bip_hip/utils/constants/imports.dart';

class FamilyController extends GetxController {
  final ApiController _apiController = ApiController();
  final SpController _spController = SpController();
  final GlobalController _globalController = Get.find<GlobalController>();
  //*Scroll controller for pagination
  final ScrollController friendListScrollController = ScrollController();
  //*Friend List Api Call
  final Rx<String?> friendListSubLink = Rx<String?>(null);
  final RxBool friendListScrolled = RxBool(false);
  final RxBool isFriendListLoading = RxBool(false);
}
