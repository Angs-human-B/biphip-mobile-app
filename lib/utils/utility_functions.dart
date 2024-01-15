import 'dart:developer';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:bip_hip/widgets/common/utils/common_image_errorBuilder.dart';

void heightWidthKeyboardValue(context) {
  height = MediaQuery.of(context).size.height;
  width = MediaQuery.of(context).size.width;
  keyboardValue = MediaQuery.of(context).viewInsets.bottom;
}

double getPaddingTop(context) => MediaQuery.of(context).padding.top;

void unFocus(context) {
  FocusScope.of(context).unfocus();
}

void ll(message) {
  log(message.toString());
}

extension CapitalizeExtension on String {
  String get capitalizeFirstOfEach => split(" ").map((str) => str.capitalizeFirstOfEach).join(" ");
  bool get isValidEmail => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(this);
  bool get isValidUrl => RegExp(r'^www.([a-zA-Z0-9]+(-[a-zA-Z0-9]+)*)').hasMatch(this);
}

bool commonValidUrlCheck(regexValue, urlValue) {
  String pattern1 = "^$regexValue.([a-zA-Z0-9]+(-[a-zA-Z0-9]+)*)";
  String pattern2 = "^www.$regexValue.([a-zA-Z0-9]+(-[a-zA-Z0-9]+)*)";
  return (RegExp(pattern1).hasMatch(urlValue) || RegExp(pattern2).hasMatch(urlValue));
}

// show alert dialog
Future<dynamic> showAlertDialog({context, child}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (ctx) => child,
  );
}

bool isDeviceScreenLarge() {
  if (height > kSmallDeviceSizeLimit) {
    return true;
  } else {
    return false;
  }
}

String ordinal(int number) {
  switch (number) {
    case 1:
      return '${number}st';
    case 2:
      return '${number}nd';
    case 3:
      return '${number}rd';
    default:
      return '${number}th';
  }
}

Widget imageLoadingBuilder(context, child, loadingProgress) {
  if (loadingProgress == null) {
    return child;
  }
  return const CustomLoadingAnimation(
    isTextVisible: false,
  );
}

Widget imageLoadingBuilderCover(context, child, loadingProgress) {
  if (loadingProgress == null) {
    return child;
  }
  return Container(
    width: width,
    height: 150,
    color: cBlackColor,
    child: const CustomLoadingAnimation(
      isTextVisible: false,
    ),
  );
}

Widget imageErrorBuilderCover(context, error, stackTrace, icon, iconSize) {
  return CommonImageErrorBuilder(
    icon: icon,
    iconSize: iconSize,
  );
}

void unfocus(context) {
  FocusScope.of(context).unfocus();
}

dynamic checkNullOrStringNull(str) {
  if (str == null || str == 'null' || str == '' || str == 'NA') {
    return null;
  } else {
    return str;
  }
}
