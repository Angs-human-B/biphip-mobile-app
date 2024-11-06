import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../widgets/common/utils/common_headertext.dart';

class ToggleButton extends StatefulWidget {
  String title;
  bool toggle;
  ToggleButton(this.title, {this.toggle = true,Key? key}) : super(key: key);

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HeaderText(widget.title),
        Switch(
          value: widget.toggle,
          activeTrackColor:Colors.green ,
          thumbColor: WidgetStateProperty.all(cWhiteColor),
          onChanged: (bool value) {
            setState(() {
              widget.toggle = value;
            });
          },
        ),
      ],
    );
  }
}
