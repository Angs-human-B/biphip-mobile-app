import 'package:bip_hip/utils/constants/imports.dart';

class BiddingWidget extends StatelessWidget {
  const BiddingWidget({super.key, required this.totalBids, required this.bidingAmount, required this.bidingOnPressed});

  final int totalBids;
  final int bidingAmount;
  final VoidCallback bidingOnPressed;

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
              'Total bids $totalBids, Highest \$$bidingAmount',
              style: regular12TextStyle(cSmallBodyTextColor),
            ),
            CustomElevatedButton(
              label: 'Place a Bid',
              textStyle: regular14TextStyle(cBiddingColor),
              buttonHeight: 24,
              buttonWidth: 100,
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
