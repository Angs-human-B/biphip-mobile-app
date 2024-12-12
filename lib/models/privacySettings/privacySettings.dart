class PrivacySettingsModel {
  //default audience settings
  final String? defaultAudienceSetting;

  // How people will find you section

  final String? friendRequestSetting;
  final String? friendsListVisibility;
  final String? messageRequestSetting;
  final String? phoneNumberDeliveryPreference;
  final String? friendsOfFriendsDeliveryPreference;
  final String? publicDeliveryPreference;

  // Selfie
  final String? selfieVisibility;
  bool? storyArchiving;
  bool? allowOthersToShareYourPublicStoriesToTheirStory;

  // Poll
  final String? pollVisibility;
  bool? pollArchiving;
  bool? allowOthersToShareYourPublicPollsToTheirPoll;

  // Followers and public content
  final String? whoCanFollowMe;
  final String? whoCanSeeYourFollowers;
  final String? whoCanSeePeoplePagesListsYouFollow;
  final String? whoCanCommentOnYourPublicPosts;
  final String? publicPostNotifications;
  final String? publicProfileInfo;

  // Profile and tagging
  final String? whoCanPostOnYourProfile;
  final String? whoCanSeeWhatOthersPostOnYourProfile;
  final String? whoCanSeeWhatOthersPostOnYourProfileFriends;
  bool? allowOthersToShareYourPostsToTheirStories;
  bool? reviewPostsYoureTaggedInBeforeTheyAppearOnYourProfile;

  // Posts Section
  final String? whoCanSeeYourFuturePosts;
  final String? whoCanSeeYourPostStarBonus;

  // Reaction Preferences
   bool? hideNumberOfReactionsOnPostFromOthers;
   bool? hideNumberOfReactionsOnPostFromOwn;

  // Notification settings
  final NotificationsModel? notifications;

  // DarkMode settings
   bool? darkModeEnabled;

  // Language and Region settings
   String? languageYouWouldLikeToHavePostsTranslatedInto;
   List<dynamic>? languagesYouDontWantToBeOfferedTranslationsFor;
   List<dynamic>? languagesYouDontWantAutomaticallyTranslated;

  PrivacySettingsModel({
    this.defaultAudienceSetting,
    this.friendRequestSetting,
    this.friendsListVisibility,
    this.messageRequestSetting,
    this.phoneNumberDeliveryPreference,
    this.friendsOfFriendsDeliveryPreference,
    this.publicDeliveryPreference,
    this.selfieVisibility,
    this.storyArchiving,
    this.allowOthersToShareYourPublicStoriesToTheirStory,
    this.pollVisibility,
    this.pollArchiving,
    this.allowOthersToShareYourPublicPollsToTheirPoll,
    this.whoCanFollowMe,
    this.whoCanSeeYourFollowers,
    this.whoCanSeePeoplePagesListsYouFollow,
    this.whoCanCommentOnYourPublicPosts,
    this.publicPostNotifications,
    this.publicProfileInfo,
    this.whoCanPostOnYourProfile,
    this.whoCanSeeWhatOthersPostOnYourProfile,
    this.whoCanSeeWhatOthersPostOnYourProfileFriends,
    this.allowOthersToShareYourPostsToTheirStories,
    this.reviewPostsYoureTaggedInBeforeTheyAppearOnYourProfile,
    this.whoCanSeeYourFuturePosts,
    this.whoCanSeeYourPostStarBonus,
    this.hideNumberOfReactionsOnPostFromOthers,
    this.hideNumberOfReactionsOnPostFromOwn,
    this.notifications,
    this.darkModeEnabled,
    this.languageYouWouldLikeToHavePostsTranslatedInto,
    this.languagesYouDontWantToBeOfferedTranslationsFor,
    this.languagesYouDontWantAutomaticallyTranslated,
  });

  // Factory method to create a UserSettings object from JSON
  factory PrivacySettingsModel.fromJson(Map<String, dynamic> json) {
    return PrivacySettingsModel(
      defaultAudienceSetting: json['default_audience'],
      friendRequestSetting: json['friend_request_setting'],
      friendsListVisibility: json['friends_list_visibility'],
      messageRequestSetting: json['message_request_setting'],
      phoneNumberDeliveryPreference: json['phone_number_delivery_preference'],
      friendsOfFriendsDeliveryPreference: json['friends_of_friends_delivery_preference'],
      publicDeliveryPreference: json['public_delivery_preference'],
      selfieVisibility: json['selfie_visibility'],
      storyArchiving: json['story_archiving'],
      allowOthersToShareYourPublicStoriesToTheirStory:
      json['allow_others_to_share_your_public_stories_to_their_story'],
      pollVisibility: json['poll_visibility'],
      pollArchiving: json['poll_archiving'],
      allowOthersToShareYourPublicPollsToTheirPoll:
      json['allow_others_to_share_your_public_polls_to_their_poll'],
      whoCanFollowMe: json['who_can_follow_me'],
      whoCanSeeYourFollowers: json['who_can_see_your_followers'],
      whoCanSeePeoplePagesListsYouFollow: json['who_can_see_people_pages_lists_you_follow'],
      whoCanCommentOnYourPublicPosts: json['who_can_comment_on_your_public_posts'],
      publicPostNotifications: json['public_post_notifications'],
      publicProfileInfo: json['public_profile_info'],
      whoCanPostOnYourProfile: json['who_can_post_on_your_profile'],
      whoCanSeeWhatOthersPostOnYourProfile: json['who_can_see_what_others_post_on_your_profile'],
      whoCanSeeWhatOthersPostOnYourProfileFriends:
      json['who_can_see_what_others_post_on_your_profile_friends'],
      allowOthersToShareYourPostsToTheirStories:
      json['allow_others_to_share_your_posts_to_their_stories'],
      reviewPostsYoureTaggedInBeforeTheyAppearOnYourProfile:
      json['review_posts_youre_tagged_in_before_they_appear_on_your_profile'],
      whoCanSeeYourFuturePosts: json['who_can_see_your_future_posts'],
      whoCanSeeYourPostStarBonus: json['who_can_see_your_post_star_bonus'],
      hideNumberOfReactionsOnPostFromOthers: json['hide_number_of_reactions_on_post_from_others'],
      hideNumberOfReactionsOnPostFromOwn: json['hide_number_of_reactions_on_post_from_own'],
      darkModeEnabled: json['dark_mode_enabled'],
      languageYouWouldLikeToHavePostsTranslatedInto: json['language_you_would_like_to_have_posts_translated_into'],
      languagesYouDontWantToBeOfferedTranslationsFor: json['languages_you_dont_want_to_be_offered_translations_for'],
      languagesYouDontWantAutomaticallyTranslated: json['languages_you_dont_want_automatically_translated'],
      notifications: json['notifications'] != null
          ? NotificationsModel.fromJson(json['notifications'])
          : null,
    );
  }

  // Method to convert a UserSettings object to JSON
  Map<String, dynamic> toJson() {
    return {
      'default_audience': defaultAudienceSetting,
      'friend_request_setting': friendRequestSetting,
      'friends_list_visibility': friendsListVisibility,
      'message_request_setting': messageRequestSetting,
      'phone_number_delivery_preference': phoneNumberDeliveryPreference,
      'friends_of_friends_delivery_preference': friendsOfFriendsDeliveryPreference,
      'public_delivery_preference': publicDeliveryPreference,
      'selfie_visibility': selfieVisibility,
      'story_archiving': storyArchiving,
      'allow_others_to_share_your_public_stories_to_their_story':
      allowOthersToShareYourPublicStoriesToTheirStory,
      'poll_visibility': pollVisibility,
      'poll_archiving': pollArchiving,
      'allow_others_to_share_your_public_polls_to_their_poll':
      allowOthersToShareYourPublicPollsToTheirPoll,
      'who_can_follow_me': whoCanFollowMe,
      'who_can_see_your_followers': whoCanSeeYourFollowers,
      'who_can_see_people_pages_lists_you_follow': whoCanSeePeoplePagesListsYouFollow,
      'who_can_comment_on_your_public_posts': whoCanCommentOnYourPublicPosts,
      'public_post_notifications': publicPostNotifications,
      'public_profile_info': publicProfileInfo,
      'who_can_post_on_your_profile': whoCanPostOnYourProfile,
      'who_can_see_what_others_post_on_your_profile': whoCanSeeWhatOthersPostOnYourProfile,
      'who_can_see_what_others_post_on_your_profile_friends':
      whoCanSeeWhatOthersPostOnYourProfileFriends,
      'allow_others_to_share_your_posts_to_their_stories':
      allowOthersToShareYourPostsToTheirStories,
      'review_posts_youre_tagged_in_before_they_appear_on_your_profile':
      reviewPostsYoureTaggedInBeforeTheyAppearOnYourProfile,
      'who_can_see_your_future_posts': whoCanSeeYourFuturePosts,
      'who_can_see_your_post_star_bonus': whoCanSeeYourPostStarBonus,
      'hide_number_of_reactions_on_post_from_others': hideNumberOfReactionsOnPostFromOthers,
      'hide_number_of_reactions_on_post_from_own': hideNumberOfReactionsOnPostFromOwn,
      'dark_mode_enabled': darkModeEnabled,
    };
  }
}

class NotificationsModel {
  final NotificationTypeModel? kids;
  final NotificationTypeModel? post;
  final NotificationTypeModel? shop;
  final NotificationTypeModel? tags;
  final NotificationTypeModel? comments;
  final NotificationTypeModel? messages;
  final NotificationTypeModel? birthdays;
  final NotificationTypeModel? reminders;
  final NotificationTypeModel? groupChat;
  final NotificationTypeModel? marketplace;
  final NotificationTypeModel? friendRequest;
  final NotificationTypeModel? otherNotifications;
  final NotificationTypeModel? updatesFromFriends;
  final NotificationTypeModel? moreActivityAboutYou;

  NotificationsModel({
    this.kids,
    this.post,
    this.shop,
    this.tags,
    this.comments,
    this.messages,
    this.birthdays,
    this.reminders,
    this.groupChat,
    this.marketplace,
    this.friendRequest,
    this.otherNotifications,
    this.updatesFromFriends,
    this.moreActivityAboutYou,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      kids: json['kids'] != null
          ? NotificationTypeModel.fromJson(json['kids'])
          : null,
      post: json['post'] != null
          ? NotificationTypeModel.fromJson(json['post'])
          : null,
      shop: json['shop'] != null
          ? NotificationTypeModel.fromJson(json['shop'])
          : null,
      tags: json['tags'] != null
          ? NotificationTypeModel.fromJson(json['tags'])
          : null,
      comments: json['comments'] != null
          ? NotificationTypeModel.fromJson(json['comments'])
          : null,
      messages: json['messages'] != null
          ? NotificationTypeModel.fromJson(json['messages'])
          : null,
      birthdays: json['birthdays'] != null
          ? NotificationTypeModel.fromJson(json['birthdays'])
          : null,
      reminders: json['reminders'] != null
          ? NotificationTypeModel.fromJson(json['reminders'])
          : null,
      groupChat: json['group_chat'] != null
          ? NotificationTypeModel.fromJson(json['group_chat'])
          : null,
      marketplace: json['marketplace'] != null
          ? NotificationTypeModel.fromJson(json['marketplace'])
          : null,
      friendRequest: json['friend_request'] != null
          ? NotificationTypeModel.fromJson(json['friend_request'])
          : null,
      otherNotifications: json['other_notifications'] != null
          ? NotificationTypeModel.fromJson(json['other_notifications'])
          : null,
      updatesFromFriends: json['updates_from_friends'] != null
          ? NotificationTypeModel.fromJson(json['updates_from_friends'])
          : null,
      moreActivityAboutYou: json['more_activity_about_you'] != null
          ? NotificationTypeModel.fromJson(json['more_activity_about_you'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kids': kids?.toJson(),
      'post': post?.toJson(),
      'shop': shop?.toJson(),
      'tags': tags?.toJson(),
      'comments': comments?.toJson(),
      'messages': messages?.toJson(),
      'birthdays': birthdays?.toJson(),
      'reminders': reminders?.toJson(),
      'group_chat': groupChat?.toJson(),
      'marketplace': marketplace?.toJson(),
      'friend_request': friendRequest?.toJson(),
      'other_notifications': otherNotifications?.toJson(),
      'updates_from_friends': updatesFromFriends?.toJson(),
      'more_activity_about_you': moreActivityAboutYou?.toJson(),
    };
  }
}

class NotificationTypeModel {
  late  bool? push;
  late  bool? email;

  NotificationTypeModel({
    this.push,
    this.email,
  });

  factory NotificationTypeModel.fromJson(Map<String, dynamic> json) {
    return NotificationTypeModel(
      push: json['push'] as bool?,
      email: json['email'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'push': push,
      'email': email,
    };
  }
}

