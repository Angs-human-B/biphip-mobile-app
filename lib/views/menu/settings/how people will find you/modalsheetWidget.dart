import 'package:bip_hip/widgets/common/utils/common_divider.dart';
import 'package:bip_hip/widgets/common/utils/common_headertext.dart';
import 'package:bip_hip/widgets/common/utils/common_simple_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../controllers/settings/settings_controller.dart';
import '../../../../models/privacySettings/privacySettings.dart';
import '../../../../utils/constants/imports.dart';

class ModalSheetWidget extends StatefulWidget {
  final String title;
  final String description;
  final int optionsType;
  final PrivacySettingsModel privacySettingsModel;

  ModalSheetWidget(
      this.title,
      this.description,
      this.optionsType,
      this.privacySettingsModel, {
        Key? key,
      }) : super(key: key);

  @override
  State<ModalSheetWidget> createState() => _ModalSheetWidgetState();
}

class _ModalSheetWidgetState extends State<ModalSheetWidget> {
  final PrivacySettingsController privacySettingsController = Get.find<PrivacySettingsController>();

  int friendRequestSelection = 0; // Tracks the selected option in FriendsRequestType
  int friendsListSelected = 0; // Tracks the selected option in FriendsListType
  int messageRequestSelected = 0; // Tracks the selected option in MessageRequestType

  @override
  void initState() {
    super.initState();
    initializeSelection();
  }

  void initializeSelection() {
    if(widget.optionsType==0){
      friendRequestSelection=privacySettingsController.getPrivacySettingValueInt(widget.privacySettingsModel.toJson(),privacySettingsController.getPrivacySettingKey(widget.title));
    }
    if(widget.optionsType==1){
      friendsListSelected=privacySettingsController.getPrivacySettingValueInt(widget.privacySettingsModel.toJson(),privacySettingsController.getPrivacySettingKey(widget.title));
    }
    else{
      messageRequestSelected=privacySettingsController.getPrivacySettingValueInt(widget.privacySettingsModel.toJson(),privacySettingsController.getPrivacySettingKey(widget.title));
    }
    // privacySettingsController.getPrivacySettingValueInt(widget.privacySettingsModel.toJson(),privacySettingsController.getPrivacySettingKey(widget.title));
    // switch (widget.privacySettingsModel.friendRequestSetting) {
    //   case "everyone":
    //     friendRequestSelection = 0;
    //     break;
    //   case "friends_of_friends":
    //     friendRequestSelection = 1;
    //     break;
    //   default:
    //     friendRequestSelection = 0; // Default to "everyone"
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: cLineColor,
                  borderRadius: k4CircularBorderRadius,
                ),
                height: 5,
                width: MediaQuery.of(context).size.width * .1,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(BipHip.circleCrossNew, color: Colors.black45),
                ),
                Normalext(
                  "Edit Audience",
                  fontSize: 35.sp,
                  weight: FontWeight.bold,
                ),
                GestureDetector(
                  onTap: () {
                    // if (widget.title == "Who can send you friend requests?") {
                    //   String settingValue = friendRequestSelection == 0 ? "everyone" : "friends_of_friends";
                    //   privacySettingsController.updateSpecificPrivacySettings("friend_request_setting", settingValue);
                    // }
                    if(widget.optionsType==0){
                      String settingValue = privacySettingsController.getPrivacySettingValue(0,friendRequestSelection);
                      privacySettingsController.updateSpecificPrivacySettings(privacySettingsController.getPrivacySettingKey(widget.title), settingValue);
                    }
                    else if(widget.optionsType==1){
                      String settingValue = privacySettingsController.getPrivacySettingValue(1,friendsListSelected);
                      privacySettingsController.updateSpecificPrivacySettings(privacySettingsController.getPrivacySettingKey(widget.title), settingValue);
                    }
                    else{
                      String settingValue = privacySettingsController.getPrivacySettingValue(2,messageRequestSelected);
                      privacySettingsController.updateSpecificPrivacySettings(privacySettingsController.getPrivacySettingKey(widget.title), settingValue);
                    }
                    Get.back();
                  },
                  child: Normalext(
                    "Done",
                    color: Colors.blue,
                    fontSize: 28.sp,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const CustomDivider(thickness: 1),
            const SizedBox(height: 20),
            HeaderText(widget.title),
            Normalext(widget.description, txtAlign: TextAlign.start, fontSize: 25.sp),
            const SizedBox(height: 20),
            if (widget.optionsType == 0)
              buildFriendRequestOptions()
            else if (widget.optionsType == 1)
              FriendsList()
            else
              MessageRequest(),
          ],
        ),
      ),
    );
  }

  Widget buildFriendRequestOptions() {
    return Column(
      children: [
        buildOptionRow(
          icon: BipHip.world,
          title: "Everyone",
          description: "Anyone on or off BipHip",
          value: 0,
        ),
        const SizedBox(height: 20),
        buildOptionRow(
          icon: BipHip.friends,
          title: "Friends of friends",
          description: "Your friends on BipHip",
          value: 1,
        ),
      ],
    );
  }

  Widget FriendsList() {
    return Column(
      children: [
        _buildRadioOption(
          icon: BipHip.world,
          title: "Public",
          subtitle: "Anyone on or off BipHip",
          value: 0,
          groupValue: friendsListSelected,
          onChanged: (value) {
            setState(() {
              friendsListSelected = value!;
              print("FriendsList Selected: $friendsListSelected");
            });
          },
        ),
        SizedBox(height: 20),
        _buildRadioOption(
          icon: BipHip.friends,
          title: "Friends & Family",
          subtitle: "Your friends on BipHip",
          value: 1,
          groupValue: friendsListSelected,
          onChanged: (value) {
            setState(() {
              friendsListSelected = value!;
              print("FriendsList Selected: $friendsListSelected");
            });
          },
        ),
        SizedBox(height: 20),
        _buildRadioOption(
          icon: BipHip.friends,
          title: "Family",
          subtitle: "Your family on BipHip",
          value: 2,
          groupValue: friendsListSelected,
          onChanged: (value) {
            setState(() {
              friendsListSelected = value!;
              print("FriendsList Selected: $friendsListSelected");
            });
          },
        ),
        SizedBox(height: 20),
        _buildRadioOption(
          icon: BipHip.friends,
          title: "Friends",
          subtitle: "Your friends on BipHip",
          value: 3,
          groupValue: friendsListSelected,
          onChanged: (value) {
            setState(() {
              friendsListSelected = value!;
              print("FriendsList Selected: $friendsListSelected");
            });
          },
        ),
        SizedBox(height: 20),
        _buildRadioOption(
          icon: BipHip.lock,
          title: "Only Me",
          subtitle: "Add your family",
          value: 4,
          groupValue: friendsListSelected,
          onChanged: (value) {
            setState(() {
              friendsListSelected = value!;
              print("FriendsList Selected: $friendsListSelected");
            });
          },
        ),
      ],
    );
  }

  Widget MessageRequest() {
    return Column(
      children: [
        _buildRadioOption(
          icon: BipHip.world,
          title: "Chat",
          subtitle: "You want messages in your chat",
          value: 0,
          groupValue: messageRequestSelected,
          onChanged: (value) {
            setState(() {
              messageRequestSelected = value!;
              print("MessageRequest Selected: $messageRequestSelected");
            });
          },
        ),
        SizedBox(height: 20),
        _buildRadioOption(
          icon: BipHip.friends,
          title: "Message requests",
          subtitle: "You get only message requests",
          value: 1,
          groupValue: messageRequestSelected,
          onChanged: (value) {
            setState(() {
              messageRequestSelected = value!;
              print("MessageRequest Selected: $messageRequestSelected");
            });
          },
        ),
        SizedBox(height: 20),
        _buildRadioOption(
          icon: BipHip.friends,
          title: "Don’t receive requests",
          subtitle: "You don’t receive any message requests",
          value: 2,
          groupValue: messageRequestSelected,
          onChanged: (value) {
            setState(() {
              messageRequestSelected = value!;
              print("MessageRequest Selected: $messageRequestSelected");
            });
          },
        ),
      ],
    );
  }

  Widget buildOptionRow({
    required IconData icon,
    required String title,
    required String description,
    required int value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(icon, size: 35.sp),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderText(title),
                Normalext(description, color: Colors.grey),
              ],
            ),
          ],
        ),
        Radio<int>(
          value: value,
          groupValue: friendRequestSelection,
          onChanged: (int? newValue) {
            setState(() {
              friendRequestSelection = newValue ?? 0;
            });
          },
        ),
      ],
    );
  }
  Widget _buildRadioOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required int value,
    required int groupValue,
    required Function(int?) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(icon, size: 35.sp),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderText(title),
                Normalext(subtitle, color: Colors.grey,fontSize: 26.sp),
              ],
            ),
          ],
        ),
        Radio<int>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

