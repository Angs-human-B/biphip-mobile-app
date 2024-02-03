import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class StoreHelper{
  final StoreController storeController = Get.find<StoreController>();
    Widget totalStoreShow() {
    if (storeController.totalStoreCount.value == 0) {
      return const SizedBox();
    } else {
      return Text(
        '${ksTotalStore.tr}: ${storeController.totalStoreCount.value}',
        style: semiBold14TextStyle(cBlackColor),
      );
    }
  }

}