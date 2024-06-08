import 'package:bip_hip/utils/constants/imports.dart';

class DashboardController extends GetxController {
  final Rx<DateTime> focuseDay = Rx<DateTime>(DateTime.now());
  final Rx<DateTime> days = Rx<DateTime>(DateTime.now());
}
