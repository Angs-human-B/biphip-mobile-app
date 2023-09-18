import 'package:bip_hip/utils/constants/imports.dart';

class CustomChoiceChips extends StatelessWidget {
  const CustomChoiceChips({super.key, required this.label, required this.isSelected, this.onSelected});

  final String label;
  final bool isSelected;
  final Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        label,
        style: regular14TextStyle(isSelected ? cPrimaryColor : cBlackColor),
      ),
      selectedColor: cPrimaryTint3Color,
      disabledColor: cWhiteColor,
      onSelected: onSelected,
      backgroundColor: cWhiteColor,
      showCheckmark: false,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: k100CircularBorderRadius,
      ),
      side: BorderSide(
        color: isSelected ? cPrimaryColor : cLineColor,
      ),
      selected: isSelected,
    );
  }
}
