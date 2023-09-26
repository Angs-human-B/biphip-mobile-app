import 'package:bip_hip/controllers/create_post_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class AddBrandPage extends StatelessWidget {
  AddBrandPage({super.key});

  final CreatePostController _createPostController = Get.find<CreatePostController>();

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
              appBarColor: cWhiteColor,
              title: "Add Brand",
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: h20),
                  child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () {
                      _createPostController.selectCategoryTextChange(context);
                    },
                    child: Text(
                      "Save",
                      style: medium14TextStyle(cPrimaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: SizedBox(
            height: height,
            width: width,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isDeviceScreenLarge() ? kH20sizedBox : kH10sizedBox,
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(kiLogoImageUrl),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
