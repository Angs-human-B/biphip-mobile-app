import 'package:bip_hip/utils/constants/imports.dart';

class BiddingWidget extends StatelessWidget {
  const BiddingWidget({super.key, required this.totalBids, this.yourBid, required this.bidingOnPressed, required this.isPlaceBid});

  final int totalBids;
  final int? yourBid;
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
            RichText(
              text: TextSpan(children: [
                TextSpan(text: '${ksTotalBids.tr} $totalBids', style: regular12TextStyle(cSmallBodyTextColor)),
                if (yourBid != null) TextSpan(text: ', ${ksYourBid.tr} \$$yourBid', style: regular12TextStyle(cSmallBodyTextColor)),
              ]),
            ),
            CustomElevatedButton(
              label: isPlaceBid ? (yourBid != null ? ksViewYourBid : ksPlaceABid.tr) : ksSeeBidingInsights.tr,
              textStyle: regular14TextStyle(cBiddingColor),
              buttonHeight: 24,
              buttonWidth: isPlaceBid ? (yourBid != null ? 120 : 100) : 150,
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
