import 'package:bip_hip/utils/constants/imports.dart';

class DashboardAward extends StatelessWidget {
  const DashboardAward({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              title: ksAwardHistiry.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Column(
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}
