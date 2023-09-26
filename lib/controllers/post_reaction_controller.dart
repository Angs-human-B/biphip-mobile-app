import 'package:bip_hip/utils/constants/imports.dart';

class PostReactionController extends GetxController {
  final RxInt selectedBidIndex = RxInt(-1);
  final RxInt selectedGiftIndex = RxInt(-1);
  final TextEditingController bidingTextEditingController = TextEditingController();
  final TextEditingController giftTextEditingController = TextEditingController();
  final RxBool isPackageSelected = RxBool(false);
  final Rx<Map?> selectedPackage = Rx<Map?>(null);
}
