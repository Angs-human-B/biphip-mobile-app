
import 'package:bip_hip/utils/constants/imports.dart';

class AllSearchController extends GetxController{
  final TextEditingController searchTextEditingController = TextEditingController();
  final List filterTypeList = ["All","Posts","People","Photos","Videos","Sell Posts","Kids","News"];
  final RxInt selectedFilterIndex = RxInt(0);
  final RxBool isFilterSelected = RxBool(false);
}