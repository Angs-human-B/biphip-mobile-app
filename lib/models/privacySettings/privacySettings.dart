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
  final bool? storyArchiving;
  final bool? allowOthersToShareYourPublicStoriesToTheirStory;

  // Poll
  final String? pollVisibility;
  final bool? pollArchiving;
  final bool? allowOthersToShareYourPublicPollsToTheirPoll;

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
  final bool? allowOthersToShareYourPostsToTheirStories;
  final bool? reviewPostsYoureTaggedInBeforeTheyAppearOnYourProfile;

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
    };
  }
}
