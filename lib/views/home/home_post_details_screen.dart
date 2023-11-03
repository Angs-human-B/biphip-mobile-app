import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/home/home_page_widgets/post_upper_container.dart';

class HomePostDetailsScreen extends StatelessWidget {
  const HomePostDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: cBackgroundColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              hasBackButton: true,
              isCenterTitle: false,
              onBack: () {
                Get.back();
              },
              action: [
                Padding(
                  padding: const EdgeInsets.only(left: k50Padding, top: k0Padding),
                  child: SizedBox(
                      height: kAppBarSize,
                      width: width - 50,
                      child: const PostUpperContainer(userName: 'Wahid Murad', isCategorized: false, privacy: BipHip.world, postTime: '1hr')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
