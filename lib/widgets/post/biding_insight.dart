import 'package:bip_hip/utils/constants/imports.dart';

class BidingInsight extends StatelessWidget {
  const BidingInsight({super.key, required this.highest, required this.lowest});

  final int highest;
  final int lowest;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h60,
      decoration: BoxDecoration(color: cPrimaryTint2Color, borderRadius: k8CircularBorderRadius),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 83,
            height: 46,
            child: Row(
              children: [
                const Icon(
                  Icons.trending_up,
                  color: cGreenColor,
                ),
                kW4sizedBox,
                Column(
                  children: [
                    Text(
                      '\$$highest',
                      style: regular20TextStyle(cBlackColor),
                    ),
                    kH4sizedBox,
                    Text(
                      ksHighest.tr,
                      style: regular12TextStyle(cBlackColor),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: k12Padding),
            child: Container(
              width: 1,
              height: 37,
              color: cWhiteColor,
            ),
          ),
          SizedBox(
            width: 83,
            height: 46,
            child: Row(
              children: [
                const Icon(
                  Icons.trending_down,
                  color: cRedColor,
                ),
                kW4sizedBox,
                Column(
                  children: [
                    Text(
                      '\$$lowest',
                      style: regular20TextStyle(cBlackColor),
                    ),
                    kH4sizedBox,
                    Text(
                      ksLowest.tr,
                      style: regular12TextStyle(cBlackColor),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
