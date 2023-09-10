

import 'package:bip_hip/utils/constants/imports.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final ValueChanged<String>? onSubmit;
  final ValueChanged<String> onChange;
  final ValueChanged<String>? onCompleted;

  const OtpTextField({
    required this.controller,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.onSubmit,
    required this.onChange,
    this.onCompleted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      autoDismissKeyboard: false,
      textStyle: semiBold18TextStyle(cBlackColor),
      autoFocus: true,
      autoDisposeControllers: false,
      controller: controller,
      useHapticFeedback: true,
      animationDuration: const Duration(milliseconds: 100),
      showCursor: false,
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      appContext: context,
      length: 4,
      onSubmitted: onSubmit,
      onChanged: onChange,
      onCompleted: onCompleted,
      pinTheme: PinTheme(
        borderRadius: BorderRadius.circular(k4BorderRadius),
        activeFillColor: cGreyBoxColor,
        inactiveFillColor: cGreyBoxColor,
        shape: PinCodeFieldShape.box,
        fieldHeight: 50,
        fieldWidth: 65,
        inactiveColor: cGreyBoxColor,
        activeColor: cGreyBoxColor,
        selectedColor: cGreyBoxColor,
        selectedFillColor: cGreyBoxColor,
      ),
    );
  }
}
