import 'package:bip_hip/models/privacySettings/privacySettings.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class PrivacySettingsController extends GetxController {
  final ApiController apiController = ApiController();
  final SpController spController = SpController();
  final GlobalController globalController = Get.find<GlobalController>();
  int radioValue = 0;
  String? radioStringValue = '';
  final Rx<PrivacySettingsModel?> settingsPrivacyData = Rx<PrivacySettingsModel?>(null);
  final RxBool isPrivacySettingsLoading = RxBool(false);

  Future<void> getPrivacySettings() async {
    try {
      isPrivacySettingsLoading.value = true;
      String? token = await spController.getBearerToken();
      print(token);
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetPrivacySettings,
      ) as CommonDM;

      if (response.success == true) {
        print("&&&");
        // Map<String, dynamic> responseData = response.data["settings"] as Map<String, dynamic>;
        // print("responseData: $responseData");
        settingsPrivacyData.value = PrivacySettingsModel.fromJson(response.data);
        radioValue = getDefaultAudienceValueInt(settingsPrivacyData.value?.defaultAudienceSetting);
        radioStringValue = settingsPrivacyData.value!.defaultAudienceSetting;
        isPrivacySettingsLoading.value = false;
      } else {
        isPrivacySettingsLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(
            title: ksError.tr,
            message: response.message,
            color: cRedColor,
          );
        } else {
          globalController.showSnackBar(
            title: ksError.tr,
            message: errorModel.errors[0].message,
            color: cRedColor,
          );
        }
      }
    } catch (e) {
      isPrivacySettingsLoading.value = false;
      ll('getPrivacySettings error: $e');
    }
  }
  Future<void> updateSpecificPrivacySettings(String settingKey,dynamic settingValue) async {
    try {
      isPrivacySettingsLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        "setting_key" : settingKey,
        "setting_value" : settingValue
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPatch,
        token: token,
        url: kuUpdateSpecificPrivacySettings,
        body:body,
      ) as CommonDM;

      if (response.success == true) {
        settingsPrivacyData.value = PrivacySettingsModel.fromJson(response.data["settings"]);
        isPrivacySettingsLoading.value = false;
      } else {
        isPrivacySettingsLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(
            title: ksError.tr,
            message: response.message,
            color: cRedColor,
          );
        } else {
          globalController.showSnackBar(
            title: ksError.tr,
            message: errorModel.errors[0].message,
            color: cRedColor,
          );
        }
      }
    } catch (e) {
      isPrivacySettingsLoading.value = false;
      ll('updateSpecificPrivacySettings error: $e');
    }
  }

  String getPrivacySettingKey(String title) {
    switch (title) {
    // How people will find you section
      case "Who can send you friend requests?":
        return "friend_request_setting";
      case "Who can see your friends list?":
        return "friends_list_visibility";
      case "Chats":
        return "message_request_setting";
      case "For people with your phone number, deliver requests to:":
        return "phone_number_delivery_preference";
      case "For friends of friends on Bip-Hip, deliver requests to:":
        return "friends_of_friends_delivery_preference";
      case "For others on Messenger or Bip-Hip, deliver requests to:":
        return "public_delivery_preference";

    // Selfie Section
      case "Who can see your stories?":
        return "selfie_visibility";

    // Poll Section
      case "Who can see your Poll?":
        return "poll_visibility";

    // Followers and public content Section
      case "Who can follow me?":
        return "who_can_follow_me";
      case "Who can see your followers on your timeline?":
        return "who_can_see_your_followers";
      case "Who can see the people, Pages and lists you follow?":
        return "who_can_see_people_pages_lists_you_follow";
      case "Who can comment on your public posts?":
        return "who_can_comment_on_your_public_posts";
      case "Public post notifications":
        return "public_post_notifications";
      case "Public profile info":
        return "public_profile_info";

    // Profile and tagging Section
      case "Who can post on your profile?":
        return "who_can_post_on_your_profile";
      case "Who can see what others post on your profile?":
        return "who_can_see_what_others_post_on_your_profile";
      case "Who can see what others post on your profile Friends?":
        return "who_can_see_what_others_post_on_your_profile_friends";

    //Posts section
      case "Who can see your future posts?":
        return "who_can_see_your_future_posts";
      case "Who can see your post star bonus?":
        return "who_can_see_your_post_star_bonus";

    // Default case for unrecognized titles
      default:
        print(title);
        return "unknown";
    }
  }

  String getPrivacySettingValue(int optionsType, int selectedKey) {
    switch (optionsType) {
      case 0: // Option type 0
        switch (selectedKey) {
          case 0:
            return "everyone";
          case 1:
            return "friends_of_friends";
          default:
            return "everyone";
        }
      case 1: // Option type 1
        switch (selectedKey) {
          case 0:
            return "public";
          case 1:
            return "friends_and_family";
          case 2:
            return "family";
          case 3:
            return "friends";
          case 4:
            return "only_me";
          default:
            return "public";
        }
      case 2: // Option type 2
        switch (selectedKey) {
          case 0:
            return "chats";
          case 1:
            return "message_requests";
          case 2:
            return "dont_receive_request";
          default:
            return "chats";
        }
      default:
        return "invalid_option_type";
    }
  }
  int getDefaultAudienceValueInt(String? settingValue) {


    // Map the value to its corresponding integer
    switch (settingValue) {
      case "public":
        return 0;
      case "family":
        return 1;
      case "friends":
        return 2;
      case "friends_and_family":
        return 3;
      case "custom":
        return 4;
      default:
        return 0;
    }
  }

  int getPrivacySettingValueInt(Map<String, dynamic> privacySettingsJsonMap, String key) {
    if (!privacySettingsJsonMap.containsKey(key)) {
      return 0;
    }
    String? settingValue = privacySettingsJsonMap[key]?.toString();

    // Map the value to its corresponding integer
    switch (settingValue) {
      case "everyone":
        return 0;
      case "friends_of_friends":
        return 1;

      case "public":
        return 0;
      case "friends_and_family":
        return 1;
      case "family":
        return 2;
      case "friends":
        return 3;
      case "only_me":
        return 4;

      case "chats":
        return 0;
      case "message_requests":
        return 1;
      case "dont_receive_request":
        return 2;

      default:
        return 0;
    }
  }

  String getPrivacySettingValueText(String? settingValue) {

    switch (settingValue) {
      case "everyone":
        return "Everyone";
      case "friends_of_friends":
        return "Friends of friends";

      case "public":
        return "Public";
      case "friends_and_family":
        return "Friends and family";
      case "family":
        return "Family";
      case "friends":
        return "Friends";
      case "only_me":
        return "Only me";

      case "chats":
        return "Chats";
      case "message_requests":
        return "Message requests";
      case "dont_receive_request":
        return "Don't receive request";

      default:
        return "Undefined";
    }
  }
  NotificationTypeModel? getNotificationTypeFromTitle(String key) {
    switch (key) {
      case "Kids":
        return settingsPrivacyData.value?.notifications?.kids;
      case "Post":
        return settingsPrivacyData.value?.notifications?.post;
      case "Shop":
        return settingsPrivacyData.value?.notifications?.shop;
      case "Tags":
        return settingsPrivacyData.value?.notifications?.tags;
      case "Comments":
        return settingsPrivacyData.value?.notifications?.comments;
      case "Messages":
        return settingsPrivacyData.value?.notifications?.messages;
      case "Birthdays":
        return settingsPrivacyData.value?.notifications?.birthdays;
      case "Reminders":
        return settingsPrivacyData.value?.notifications?.reminders;
      case "Group chat":
        return settingsPrivacyData.value?.notifications?.groupChat;
      case "Marketplace":
        return settingsPrivacyData.value?.notifications?.marketplace;
      case "Friend request":
        return settingsPrivacyData.value?.notifications?.friendRequest;
      case "Other notifications":
        return settingsPrivacyData.value?.notifications?.otherNotifications;
      case "Updates from friends":
        return settingsPrivacyData.value?.notifications?.updatesFromFriends;
      case "More Activity About You":
        return settingsPrivacyData.value?.notifications?.moreActivityAboutYou;
    }
    return null;
  }

  String getActiveNotificationTypesFromTitle(String title) {
    String resolveNotificationTypes({required bool push, required bool email}) {
      if (push && email) {
        return "Push, Email";
      } else if (push) {
        return "Push";
      } else if (email) {
        return "Email";
      }
      return "None";
    }

    switch (title) {
      case "Kids":
        return resolveNotificationTypes(
          push: settingsPrivacyData.value?.notifications?.kids?.push ?? false,
          email: settingsPrivacyData.value?.notifications?.kids?.email ?? false,
        );
      case "Post":
        return resolveNotificationTypes(
          push: settingsPrivacyData.value?.notifications?.post?.push ?? false,
          email: settingsPrivacyData.value?.notifications?.post?.email ?? false,
        );
      case "Shop":
        return resolveNotificationTypes(
          push: settingsPrivacyData.value?.notifications?.shop?.push ?? false,
          email: settingsPrivacyData.value?.notifications?.shop?.email ?? false,
        );
      case "Tags":
        return resolveNotificationTypes(
          push: settingsPrivacyData.value?.notifications?.tags?.push ?? false,
          email: settingsPrivacyData.value?.notifications?.tags?.email ?? false,
        );
      case "Comments":
        return resolveNotificationTypes(
          push: settingsPrivacyData.value?.notifications?.comments?.push ?? false,
          email: settingsPrivacyData.value?.notifications?.comments?.email ?? false,
        );
      case "Messages":
        return resolveNotificationTypes(
          push: settingsPrivacyData.value?.notifications?.messages?.push ?? false,
          email: settingsPrivacyData.value?.notifications?.messages?.email ?? false,
        );
      case "Birthdays":
        return resolveNotificationTypes(
          push: settingsPrivacyData.value?.notifications?.birthdays?.push ?? false,
          email: settingsPrivacyData.value?.notifications?.birthdays?.email ?? false,
        );
      case "Reminders":
        return resolveNotificationTypes(
          push: settingsPrivacyData.value?.notifications?.reminders?.push ?? false,
          email: settingsPrivacyData.value?.notifications?.reminders?.email ?? false,
        );
      case "Group chat":
        return resolveNotificationTypes(
          push: settingsPrivacyData.value?.notifications?.groupChat?.push ?? false,
          email: settingsPrivacyData.value?.notifications?.groupChat?.email ?? false,
        );
      case "Marketplace":
        return resolveNotificationTypes(
          push: settingsPrivacyData.value?.notifications?.marketplace?.push ?? false,
          email: settingsPrivacyData.value?.notifications?.marketplace?.email ?? false,
        );
      case "Friend request":
        return resolveNotificationTypes(
          push: settingsPrivacyData.value?.notifications?.friendRequest?.push ?? false,
          email: settingsPrivacyData.value?.notifications?.friendRequest?.email ?? false,
        );
      case "Other notifications":
        return resolveNotificationTypes(
          push: settingsPrivacyData.value?.notifications?.otherNotifications?.push ?? false,
          email: settingsPrivacyData.value?.notifications?.otherNotifications?.email ?? false,
        );
      case "Updates from friends":
        return resolveNotificationTypes(
          push: settingsPrivacyData.value?.notifications?.updatesFromFriends?.push ?? false,
          email: settingsPrivacyData.value?.notifications?.updatesFromFriends?.email ?? false,
        );
      case "More Activity About You":
        return resolveNotificationTypes(
          push: settingsPrivacyData.value?.notifications?.moreActivityAboutYou?.push ?? false,
          email: settingsPrivacyData.value?.notifications?.moreActivityAboutYou?.email ?? false,
        );
      default:
        return "Unknown Key"; // Default when the key is not matched
    }
  }

  String getSettingKeyFromTitle(String title) {
    switch (title) {
      case "Kids":
        return "notifications.kids";
      case "Post":
        return "notifications.post";
      case "Shop":
        return "notifications.shop";
      case "Tags":
        return "notifications.tags";
      case "Comments":
        return "notifications.comments";
      case "Messages":
        return "notifications.messages";
      case "Birthdays":
        return "notifications.birthdays";
      case "Reminders":
        return "notifications.reminders";
      case "Group chat":
        return "notifications.group_chat";
      case "Marketplace":
        return "notifications.marketplace";
      case "Friend request":
        return "notifications.friend_request";
      case "Other Notifications":
        return "notifications.other_notifications";
      case "Updates from friends":
        return "notifications.updates_from_friends";
      case "More Activity About You":
        return "notifications.more_activity_about_you";
      default:
        return "unknown_key";
    }
  }

  final RxBool isLoginAlertStatusLoading = RxBool(false);
  final Rx<int?> selectedLoginAlertStatus = Rx<int?>(1);
  Future<void> getLoginAlertStatus() async {
    try {
      isLoginAlertStatusLoading.value = true;
      String? token = await spController.getBearerToken();
      print(token);
      var response = await apiController.commonApiCall(
        requestMethod: kGet,
        token: token,
        url: kuGetLoginAlertStatus,
      ) as CommonDM;

      if (response.success == true) {
        if(response.data["login_alert"]=="email"){
          selectedLoginAlertStatus.value=2;
        }else{
          selectedLoginAlertStatus.value=1;
        }
        isLoginAlertStatusLoading.value = false;
      } else {
        isLoginAlertStatusLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(
            title: ksError.tr,
            message: response.message,
            color: cRedColor,
          );
        } else {
          globalController.showSnackBar(
            title: ksError.tr,
            message: errorModel.errors[0].message,
            color: cRedColor,
          );
        }
      }
    } catch (e) {
      isLoginAlertStatusLoading.value = false;
      ll('getLoginAlertStatus error: $e');
    }
  }
  Future<void> postLoginAlert() async {
    try {
      isLoginAlertStatusLoading.value = true;
      String? token = await spController.getBearerToken();
      Map<String, dynamic> body = {
        "login_alert": selectedLoginAlertStatus.value==1 ? "in_app_notifications" : "email"
      };
      var response = await apiController.commonApiCall(
        requestMethod: kPost,
        token: token,
        url: kuPostLoginAlert,
        body:body,
      ) as CommonDM;

      if (response.success == true) {
        Get.back();
        globalController.showSnackBar(
          title: ksSuccess.tr,
          message: response.message,
          color: cGreenColor,
        );
        isLoginAlertStatusLoading.value = false;
      } else {
        isLoginAlertStatusLoading.value = false;
        ErrorModel errorModel = ErrorModel.fromJson(response.data);
        if (errorModel.errors.isEmpty) {
          globalController.showSnackBar(
            title: ksError.tr,
            message: response.message,
            color: cRedColor,
          );
        } else {
          globalController.showSnackBar(
            title: ksError.tr,
            message: errorModel.errors[0].message,
            color: cRedColor,
          );
        }
      }
    } catch (e) {
      isLoginAlertStatusLoading.value = false;
      ll('postLoginAlert error: $e');
    }
  }


}


