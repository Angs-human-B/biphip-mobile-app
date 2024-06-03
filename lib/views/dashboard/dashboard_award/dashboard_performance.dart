import 'package:bip_hip/utils/constants/imports.dart';

class DashboardPerformance extends StatelessWidget {
  const DashboardPerformance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              title: ksPerformance.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
    );
  }
}