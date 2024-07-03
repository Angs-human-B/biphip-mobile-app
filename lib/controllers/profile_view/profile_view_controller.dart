import 'package:bip_hip/utils/constants/imports.dart';

class ProfileViewController extends GetxController {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();
  

    final RxInt interestCatagoriesIndex = RxInt(0);
    final RxInt profileSelectedTabIndex = RxInt(0);

}