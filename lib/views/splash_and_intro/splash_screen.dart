import 'package:bip_hip/utils/constants/colors.dart';
import 'package:bip_hip/utils/constants/const.dart';
import 'package:bip_hip/utils/constants/strings.dart';
import 'package:bip_hip/utils/constants/styles.dart';
import 'package:bip_hip/utils/constants/urls.dart';
import 'package:bip_hip/utils/utility_functions.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    heightWidthKeyboardValue(context);
    return Scaffold(
      backgroundColor: cWhiteColor,
      body: SizedBox(
        height: height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                kiLogoImageUrl,
                height: 80,
                width: 80,
              ),
              kH8sizedBox,
              Text(
                ksBipHip,
                style: semiBold20TextStyle(cPrimaryColor).copyWith(fontSize: h26),
              )
            ],
          ),
        ),
      ),
    );
  }
}
