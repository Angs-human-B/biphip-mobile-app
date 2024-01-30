import 'package:bip_hip/controllers/menu/store_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/views/menu/kids/add_kid_basic_info.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:flutter_svg/svg.dart';

class AddStoreDocuments extends StatelessWidget {
  AddStoreDocuments({super.key});
  final StoreController storeController = Get.find<StoreController>();

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
              title: ksAddStore.tr,
              hasBackButton: false,
              leadingWidth: 80,
              leadingWidget: Center(
                child: InkWell(
                  onTap: () {
                    unFocus(context);
                    Get.back();
                  },
                  child: Text(
                    ksPrevious.tr,
                    style: semiBold14TextStyle(cPrimaryColor),
                  ),
                ),
              ),
              isCenterTitle: true,
              onBack: () {},
              action: [
                Padding(
                  padding: const EdgeInsets.only(right: h20),
                  child: TextButton(
                    style: kTextButtonStyle,
                    onPressed: () {
                      unFocus(context);
                      Get.toNamed(krAddStoreUploadImage);
                    },
                    child: Text(
                      ksSkip.tr,
                      style: medium14TextStyle(cPrimaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const CustomDivider(
                  thickness: 1,
                ),
                KidTopTitleSubtitleAndCircularProgressBar(
                  title: ksDocuments.tr,
                  subTitle: ksElevateBusinessImageAndDocument.tr,
                  circularCenterText: ks4of5.tr,
                  percent: 0.8,
                ),
                kH16sizedBox,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                  child: CustomDivider(
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding).copyWith(top: k16Padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kH16sizedBox,
                      Text(
                        ksBusinessIdentificationNumber.tr,
                        style: semiBold16TextStyle(cBlackColor),
                      ),
                      kH8sizedBox,
                      CustomModifiedTextField(
                        controller: storeController.businessIdentificationNumberController,
                        hint: ksBIN.tr,
                        onChanged: (text) {},
                        onSubmit: (text) {},
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        maxLength: 15,
                      ),
                      kH8sizedBox,
                      Text(
                        ksLegalPapers.tr,
                        style: semiBold16TextStyle(cBlackColor),
                      ),
                      kH8sizedBox,
                      Text(
                        ksLegalPapersLicenseOrImage.tr,
                        style: regular14TextStyle(cSmallBodyTextColor),
                      ),
                      kH8sizedBox,
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: width - 40,
                          height: 140,
                          decoration: BoxDecoration(
                            color: cInputFieldColor,
                            borderRadius: BorderRadius.circular(k8BorderRadius),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                kiUploadImage,
                                height: 40,
                              ),
                              kH8sizedBox,
                              Text(
                                ksUploadImage,
                                style: semiBold16TextStyle(cPrimaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                kH100sizedBox,
                CustomElevatedButton(
                  buttonWidth: width - 40,
                  buttonHeight: h40,
                  label: ksNext.tr,
                  onPressed: () {
                    unFocus(context);
                    Get.toNamed(krAddStoreUploadImage);
                  },
                  textStyle: semiBold16TextStyle(cWhiteColor),
                ),
                kH30sizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
