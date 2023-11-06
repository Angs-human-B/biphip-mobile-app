import 'package:bip_hip/utils/constants/imports.dart';

class BiddingWidget extends StatelessWidget {
  const BiddingWidget({super.key, required this.totalBids, required this.bidingAmount, required this.bidingOnPressed, required this.isPlaceBid});

  final int totalBids;
  final int bidingAmount;
  final VoidCallback bidingOnPressed;
  final bool isPlaceBid;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      color: cGreyBoxColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: k12Padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${ksTotalBids.tr} $totalBids, ${ksHighest.tr} \$$bidingAmount',
              style: regular12TextStyle(cSmallBodyTextColor),
            ),
            CustomElevatedButton(
              label: isPlaceBid ? ksPlaceABid.tr : ksSeeBidingInsights.tr,
              textStyle: regular14TextStyle(cBiddingColor),
              buttonHeight: 24,
              buttonWidth: isPlaceBid ? 100 : 150,
              onPressed: bidingOnPressed,
              borderColor: cBiddingColor,
              buttonColor: cWhiteColor,
              prefixIcon: BipHip.bidding,
              prefixIconColor: cBiddingColor,
            )
          ],
        ),
      ),
    );
  }
}
