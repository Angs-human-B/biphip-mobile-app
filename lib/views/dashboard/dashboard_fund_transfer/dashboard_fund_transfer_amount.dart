import 'package:bip_hip/controllers/dashboard/dashboard_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_divider.dart';

class DashboardFundTransferAmount extends StatelessWidget {
  DashboardFundTransferAmount({super.key, this.userImage, this.userName, this.familyRelationStatus});
  final String? userImage, userName, familyRelationStatus;
  final DashboardController dashboardController = Get.find<DashboardController>();
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
              title: ksFundTransfer.tr,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kH20sizedBox,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Image.network(
                          userImage ?? "",
                          fit: BoxFit.cover,
                          width: h50,
                          height: h50,
                          loadingBuilder: imageLoadingBuilder,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(kiProfileDefaultImageUrl);
                          },
                        ),
                      ),
                      kW8sizedBox,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName ?? ksNA.tr,
                            style: semiBold20TextStyle(cBlackColor),
                          ),
                          kH8sizedBox,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                familyRelationStatus == null ? BipHip.friends : BipHip.relation,
                                size: kIconSize16,
                                color: familyRelationStatus == null ? cBlackColor : cRedColor,
                              ),
                              kW4sizedBox,
                              Text(
                                familyRelationStatus ?? ksFriend.tr,
                                style: regular16TextStyle(cSmallBodyTextColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  kH16sizedBox,
                  const CustomDivider(),
                  kH16sizedBox,
                  CustomModifiedTextField(
                    errorText: dashboardController.fundTransferErrorText.value,
                    onChanged: (text) {
                      dashboardController.dashboardFundTransferOnChanged();
                    },
                    prefixIcon: BipHip.giftNew,
                    suffixIconColor: cAmberAccentColor,
                    controller: dashboardController.fundTransferTextEditingController,
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 4,
                  ),
                  Text(
                    "${ksWhichAmountYouCanSend.tr}...",
                    style: regular10TextStyle(cIconColor),
                  ),
                  const Spacer(),
                  CustomElevatedButton(
                    label: ksConfirm.tr,
                    onPressed: dashboardController.isConfirmButtonEnabled.value
                        ? () {
                            Get.toNamed(krDashboardFundTransferOtp);
                          }
                        : null,
                    buttonWidth: width - 40,
                    buttonHeight: h32,
                    buttonColor: cPrimaryColor,
                    textStyle: semiBold14TextStyle(cWhiteColor),
                  ),
                  kH20sizedBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
