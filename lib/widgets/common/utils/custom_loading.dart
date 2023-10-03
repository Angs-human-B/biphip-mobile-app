import 'package:bip_hip/utils/constants/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomLoadingAnimation extends StatelessWidget {
  const CustomLoadingAnimation({
    this.isTextVisible = true,
    Key? key,
  }) : super(key: key);

  final bool isTextVisible;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CupertinoActivityIndicator(radius: 20),
          if (isTextVisible) Text('${ksLoading.tr}...'),
        ],
      ),
    );
  }
}
