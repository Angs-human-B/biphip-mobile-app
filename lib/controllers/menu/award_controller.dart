
import 'package:bip_hip/utils/constants/imports.dart';

class AwardController extends GetxController{
  final TextEditingController awardTextEditingController = TextEditingController();
  final RxBool isAwardSuffixVisible = RxBool(false);
   final RxInt selectedCatagoriesIndex = RxInt(0);
  final RxBool isCategoriesSelected = RxBool(false);
  resetAwardData(){
    selectedCatagoriesIndex.value =0;
    isCategoriesSelected.value=false;
  }
}