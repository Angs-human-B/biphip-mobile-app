//* info:: auth screens
import 'package:bip_hip/views/auth/forget_password/forgot_password_screen.dart';
import 'package:bip_hip/views/auth/forget_password/reset_password_screen.dart';
import 'package:bip_hip/views/auth/login/login.dart';
import 'package:bip_hip/views/auth/register/otp_verification.dart';
import 'package:bip_hip/views/auth/onboarding/picture_upload_screen.dart';
import 'package:bip_hip/views/auth/register/register.dart';
import 'package:bip_hip/views/auth/onboarding/select_interest.dart';
import 'package:bip_hip/views/auth/onboarding/select_profession.dart';
import 'package:bip_hip/views/auth/register/set_password.dart';
import 'package:bip_hip/views/auth/login/saved_user_login.dart';
import 'package:bip_hip/views/auth/register/select_birthday.dart';
import 'package:bip_hip/views/auth/register/select_gender.dart';
import 'package:bip_hip/views/auth/register/set_email.dart';
import 'package:bip_hip/views/dashboard/dashboard_overview/dashboard_overview.dart';
import 'package:bip_hip/views/dashboard/dashboard_overview/dashboard_overview_audience.dart';
import 'package:bip_hip/views/dashboard/dashboard_overview/dashboard_overview_content.dart';
import 'package:bip_hip/views/dashboard/dashboard_fund_transfer/dashboard_fund_transfer.dart';
import 'package:bip_hip/views/dashboard/dashboard_fund_transfer/dashboard_fund_transfer_details.dart';
import 'package:bip_hip/views/dashboard/dashboard_fund_transfer/dashboard_fund_transfer_otp.dart';
import 'package:bip_hip/views/dashboard/dashboard_fund_transfer/dashboard_select_people.dart';
import 'package:bip_hip/views/dashboard/dashboard_donation/dashboard_donated_post.dart';
import 'package:bip_hip/views/dashboard/dashboard_donation/dashboard_donation.dart';
import 'package:bip_hip/views/dashboard/dashboard_check_in_calender.dart';
import 'package:bip_hip/views/dashboard/dashboard_gift/dashboard_gift.dart';
import 'package:bip_hip/views/dashboard/dashboard_gift/dashboard_gift_earned.dart';
import 'package:bip_hip/views/dashboard/dashboard_award/dashboard_all_awards.dart';
import 'package:bip_hip/views/dashboard/dashboard_award/dashboard_award.dart';
import 'package:bip_hip/views/dashboard/dashboard_award/dashboard_performance.dart';
import 'package:bip_hip/views/dashboard/dashboard_payouts/dashboard_payout_withdraw.dart';
import 'package:bip_hip/views/dashboard/dashboard_payouts/dashboard_payouts.dart';
import 'package:bip_hip/views/dashboard/dashboard_payouts/payout_settings/payout_add_crypto.dart';
import 'package:bip_hip/views/dashboard/dashboard_payouts/payout_settings/payout_add_debit_card.dart';
import 'package:bip_hip/views/dashboard/dashboard_payouts/payout_settings/payout_business_info.dart';
import 'package:bip_hip/views/dashboard/dashboard_payouts/payout_settings/payout_manual_link_bank_account.dart';
import 'package:bip_hip/views/dashboard/dashboard_payouts/payout_settings/payout_nid_verification.dart';
import 'package:bip_hip/views/dashboard/dashboard_payouts/payout_settings/payout_passport_verification.dart';
import 'package:bip_hip/views/dashboard/dashboard_payouts/payout_settings/payout_student_id_verification.dart';
import 'package:bip_hip/views/dashboard/dashboard_payouts/payout_settings/payout_tax_info.dart';
import 'package:bip_hip/views/dashboard/dashboard_payouts/payout_settings/payout_bankaccount_tax_passport_info_view.dart';
import 'package:bip_hip/views/dashboard/dashboard_star/dashboard_star.dart';
import 'package:bip_hip/views/dashboard/dashboard_star/dashboard_star_history.dart';
import 'package:bip_hip/views/dashboard/dashboard_quiz.dart';
import 'package:bip_hip/views/home/common_gift_view_screen.dart';
import 'package:bip_hip/views/marketplace/marketplace_bidding_page.dart';
import 'package:bip_hip/views/marketplace/marketplace_buying/marketplace_buying_page.dart';
import 'package:bip_hip/views/marketplace/marketplace_notification.dart';
import 'package:bip_hip/views/marketplace/marketplace_account.dart';
import 'package:bip_hip/views/marketplace/marketplace_page.dart';
import 'package:bip_hip/views/marketplace/marketplace_categories_page.dart';
import 'package:bip_hip/views/marketplace/marketplace_recent_activity.dart';
import 'package:bip_hip/views/marketplace/marketplace_selling/marketplace_mark_sold_page.dart';
import 'package:bip_hip/views/marketplace/marketplace_selling/marketplace_selling_page.dart';
import 'package:bip_hip/views/marketplace/marketplace_selling/marketplace_your_listing_page.dart';
import 'package:bip_hip/views/marketplace/marketplace_view_listing_page.dart';
import 'package:bip_hip/views/menu/awards/awards_details_page.dart';
import 'package:bip_hip/views/menu/awards/awards_page.dart';
import 'package:bip_hip/views/menu/badges/all_badges.dart';
import 'package:bip_hip/views/menu/badges/badges_star_page.dart';
import 'package:bip_hip/views/menu/badges/purchase_star.dart';
import 'package:bip_hip/views/menu/birthday/birthday_page.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/edit_kid_profile.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_add_language.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_edit_about.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_edit_bio.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_edit_page.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_photo_preview.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_photo_view.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/kid_profile.dart';
import 'package:bip_hip/views/menu/kids/kid_profile/select_hobbies_page.dart';
import 'package:bip_hip/views/menu/pendent/all_pendent.dart';
import 'package:bip_hip/views/menu/pendent/pendent_page.dart';
import 'package:bip_hip/views/home/quiz/my_quiz.dart';
import 'package:bip_hip/views/home/quiz/quiz_page.dart';
import 'package:bip_hip/views/menu/photos/create_album.dart';
import 'package:bip_hip/views/menu/photos/create_album_location.dart';
import 'package:bip_hip/views/menu/photos/create_album_upload_image_list.dart';
import 'package:bip_hip/views/menu/profile/edit_about/add_language.dart';
import 'package:bip_hip/views/menu/profile/edit_about/relationship_section.dart';
import 'package:bip_hip/views/menu/profile/edit_basic_info.dart';
import 'package:bip_hip/views/menu/selfie/select_people_page.dart';
import 'package:bip_hip/views/menu/selfie/selfie_page.dart';
import 'package:bip_hip/views/menu/selfie/selfie_privacy_page.dart';
import 'package:bip_hip/views/menu/selfie/selfie_view_page.dart';
import 'package:bip_hip/views/menu/settings/DarkMode/dark_mode_page.dart';
import 'package:bip_hip/views/menu/settings/how%20people%20will%20find%20you/how_people_will_find_you_page.dart';
import 'package:bip_hip/views/menu/settings/languageAndRegion/language_and_region_page.dart';
import 'package:bip_hip/views/menu/store/add_store_basic_info.dart';
import 'package:bip_hip/views/menu/store/add_store_contact_info.dart';
import 'package:bip_hip/views/menu/store/add_store_documents.dart';
import 'package:bip_hip/views/menu/store/add_store_social_links.dart';
import 'package:bip_hip/views/menu/store/add_store_upload_image.dart';
import 'package:bip_hip/views/menu/store/store.dart';
import 'package:bip_hip/views/menu/kids/add_kid_basic_info.dart';
import 'package:bip_hip/views/menu/kids/add_kid_contact_info.dart';
import 'package:bip_hip/views/menu/kids/add_kid_social_links.dart';
import 'package:bip_hip/views/menu/kids/add_kid_upload_image.dart';
import 'package:bip_hip/views/menu/store/store_profile/edit_store_about.dart';
import 'package:bip_hip/views/menu/store/store_profile/edit_store_bio.dart';
import 'package:bip_hip/views/menu/store/store_profile/edit_store_profile.dart';
import 'package:bip_hip/views/menu/store/store_profile/edit_store_profile/edit_store_bin.dart';
import 'package:bip_hip/views/menu/store/store_profile/edit_store_profile/edit_store_category.dart';
import 'package:bip_hip/views/menu/store/store_profile/edit_store_profile/edit_store_email.dart';
import 'package:bip_hip/views/menu/store/store_profile/edit_store_profile/edit_store_location.dart';
import 'package:bip_hip/views/menu/store/store_profile/edit_store_profile/edit_store_payment.dart';
import 'package:bip_hip/views/menu/store/store_profile/edit_store_profile/edit_store_phone_number.dart';
import 'package:bip_hip/views/menu/store/store_profile/edit_store_profile/edit_store_privacy_link.dart';
import 'package:bip_hip/views/menu/store/store_profile/edit_store_profile/edit_store_qr_code.dart';
import 'package:bip_hip/views/menu/store/store_profile/edit_store_profile/edit_store_social_link.dart';
import 'package:bip_hip/views/menu/store/store_profile/store_add_legal_document.dart';
import 'package:bip_hip/views/menu/store/store_profile/store_profile.dart';
import 'package:bip_hip/views/menu/store/store_profile/store_review.dart';
import 'package:bip_hip/views/menu/store/widgets/store_photo_preview.dart';
import 'package:bip_hip/views/menu/store/widgets/store_photo_view.dart';
import 'package:bip_hip/views/message/call_screen.dart';
import 'package:bip_hip/views/message/inbox.dart';
import 'package:bip_hip/views/notification/notification_page.dart';
import 'package:bip_hip/views/message/message_screen.dart';
import 'package:bip_hip/views/message/ringing_screen.dart';
import 'package:bip_hip/views/post/add_kid.dart';
import 'package:bip_hip/views/post/create_post.dart';
import 'package:bip_hip/views/post/upload_media_list.dart';
import 'package:bip_hip/views/home/home_post_details.dart';
import 'package:bip_hip/views/home/homepage.dart';
import 'package:bip_hip/views/menu/family/add_family.dart';
import 'package:bip_hip/views/menu/family/family.dart';
import 'package:bip_hip/views/menu/friends/add_friend.dart';
import 'package:bip_hip/views/menu/friends/friends.dart';
import 'package:bip_hip/views/menu/kids/edit_kid.dart';
import 'package:bip_hip/views/menu/kids/kids.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';
import 'package:bip_hip/views/menu/profile/edit_page.dart';
import 'package:bip_hip/views/menu/profile/edit_bio.dart';
import 'package:bip_hip/views/menu/profile/edit_profile.dart';
import 'package:bip_hip/views/post/select_category.dart';
import 'package:bip_hip/views/menu/menu.dart';
import 'package:bip_hip/views/menu/photos/photo_details.dart';
import 'package:bip_hip/views/menu/photos/photo_preview.dart';
import 'package:bip_hip/views/menu/profile/photo_view.dart';
import 'package:bip_hip/views/menu/profile/profile.dart';
import 'package:bip_hip/views/menu/photos/gallery_photos.dart';
import 'package:bip_hip/views/menu/videos/gallery_videos.dart';
import 'package:bip_hip/views/menu/videos/video_details.dart';
import 'package:bip_hip/views/menu/videos/videos.dart';
import 'package:bip_hip/views/intro/splash_screen.dart';
import 'package:bip_hip/views/profile_view/profile_view.dart';
import 'package:bip_hip/views/profile_view/profile_view_about.dart';
import 'package:bip_hip/views/profile_view/profile_view_family.dart';
import 'package:bip_hip/views/profile_view/profile_view_follower.dart';
import 'package:bip_hip/views/profile_view/profile_view_friend.dart';
import 'package:bip_hip/views/profile_view/store_review/profile_view_create_review.dart';
import 'package:bip_hip/views/search/search.dart';
import 'package:get/get.dart';

import '../../views/menu/settings/ReactionPreferences/reaction_preferences.dart';
import '../../views/menu/settings/change password/password_and_security_page.dart';
import '../../views/menu/settings/default audience/default_audience_page.dart';
import '../../views/menu/settings/personal details/profile_details_page.dart';
import '../../views/menu/settings/settings.dart';


const String krSplashScreen = '/splash-screen';
const String krIntroductionScreen = '/introduction-screen';

const String krLogin = '/login';
const String krSavedUserLogin = '/saved-user-login';
const String krRegister = '/register';
const String krSelectBirthday = '/birthday';
const String krSelectGender = '/gender';
const String krSetEmail = '/set-email';
const String krSelectProfession = '/select-profession';
const String krSelectInterest = '/select-interest';
const String krUploadPicture = '/upload-picture';
const String krForgotPassword = '/forgot-password';
const String krResetPass = '/reset-pass';
const String krSetNewPass = '/set-new-pass';
const String krOTP = '/otp-verify';

const String krHome = '/home';
const String krChangePassword = '/change-password';
const String krChangeLanguage = '/change-language';
const String krHomePostDetails = '/home-post-details';
const String krGiftView = "/gift-view";

const String krMenu = '/menu';
const String krProfile = '/profile';
const String krEditBio = '/edit-bio';
const String krEditAboutInfo = '/edit-about-info';
const String krEdit = '/edit';
const String krEditProfile = '/edit-profile';
const String krEditRelationship = '/edit-relationship';
const String krEditBasicInfo = '/edit-basic-info';
const String krPhotoPreview = '/photo-preview';
const String krFriends = '/friends';
const String krAddFriend = '/add-friend';
const String krFamily = '/family';
const String krAddFamily = '/add-family';
const String krPhotos = '/photos';
const String krPhotoDetails = '/photo-details';
const String krViewPhoto = '/view-photo';
const String krVideos = '/videos';
const String krVideoDetails = '/video-details';
const String krSettings = '/settings';
const String krProfileDetails = '/profile-details';
const String krAddLanguage = '/add-language';

const String krCreatePost = '/create-post';
const String krSelectCategory = '/create-post/select-category';
const String krUploadedImageListPage = '/create-post/uploaded-image-list';
const String krAddKid = '/create-post/select-category/add-kid';
//*newly Added for gallery photos and videos
const String krGalleryPhotos = '/gallery-photos';
const String krGalleryVideos = '/gallery-videos';
const String krCreateAlbum = '/create-album';
const String krCreateAlbumLocation = '/create-album-add-location';
const String krCreateAlbumUploadImageList = '/create-album-upload-image-list';
//*Kids
const String krKidsPage = '/kids-page';
const String krEditKidPage = '/edit-kids-page';
const String krAddKidBasicInfo = '/add-kid-basic-info';
const String krAddKidContactInfo = '/add-kid-contact-info';
const String krAddKidSocialLinks = '/add-kid-social-links';
const String krAddKidUploadImage = '/add-kid-upload-image';

//*Quiz
const String krQuizPage = '/quiz-page';
const String krMyQuiz = '/my-quiz';

//*Store
const String krStore = '/store-page';
const String krAddStoreBasicInfo = '/add-store-basic-info';
const String krAddStoreContactInfo = '/add-store-contact-info';
const String krAddStoreSocialLinks = '/add-store-social-links';
const String krAddStoreDocuments = '/add-store-documents';
const String krAddStoreUploadImage = '/add-store-upload-image';
//*Pendent
const String krPendentPage = '/pendent-page';
const String krAllPendent = '/all-pendent';
//*Badges
const String krBadgesStarPage = '/badges-star-page';
const String krAllBadges = '/all-badges';
const String krPurchaseStar = '/purchase-star';
//* Birthday
const String krBirthdayPage = '/birthday-page';

//* Kid profile
const String krKidProfile = '/kid-profile';
const String krEditKidProfile = '/edit-kid-profile';
const String krKidPhotoPreview = '/kid-photo-profile';
const String krKidPhotoView = '/kid-photo-view';
const String krKidEditBio = '/kid-edit-bio';
const String krKidEditAboutInfo = '/kid-edit-about-info';
const String krSelectHobbiesPage = '/select-hobbies-page';
const String krKidEditPage = '/kid-edit-page';
const String krKidEditRelation = '/kid-edit-relation';
const String krKidAddLanguage = '/kid-add-language';
//*Awards
const String krAwardsPage = '/awards-page';
const String krAwardDetailsPage = '/award-details-page';
//* Search
const String krSearchPage = "/search-page";

//*Store profile
const String krStoreProfile = '/store-profile';
const String krEditStoreProfile = '/edit-store-profile';
const String krStoreEditAbout = '/store-edit-about';
const String krEditStorePhoneNumber = '/edit-store-phone-number';
const String krEditStoreEmail = '/edit-store-email';
const String krEditStorePrivacyLink = '/edit-store-privacy-link';
const String krEditStoreQrCode = '/edit-store-qr-code';
const String krEditStoreBIN = '/edit-store-bin';
const String krEditStoreLocation = '/edit-store-location';
const String krEditStoreCategory = '/edit-store-category';
const String krEditStoreSocialLink = '/edit-store-social-link';
const String krEditStorePayment = '/edit-store-payment';
const String krStoreAddLegalDocument = '/store-add-legal-document';
const String krStoreEditBio = '/store-edit-bio';
const String krStoreReview = '/store-review';
const String krStorePhotoPreview = '/store-photo-preview';
const String krStorePhotoView = '/store-photo-view';

//*Selfie
const String krSelfiePage = "/selfie-page";
const String krSelfiePrivacyPage = "/selfie-privacy-page";
const String krSelectPeoplePage = "/select-people-page";
const String krSelfieViewPage = "/selfie-view-page";

//* Messenger
const String krInbox = "/inbox";
//*Marketplace
const String krMarketPlacePage = "/marketplace-page";
const String krMarketPlaceCategoriesPage = "/marketplace-categories-page";
const String krMarketPlaceViewListingPage = "/marketplace-view-listing-page";
const String krMarketPlaceAccount = "/marketplace-account";
const String krMarketPlaceNotification = "/marketplace-notification";
const String krMarketPlaceRecentActivity = "/marketplace-recent-activity";
const String krMarketPlaceBiddingPage = "/marketplace-bidding-page";
const String krMarketPlaceSellingPage = "/marketplace-selling-page";
const String krMarketPlaceYourListingPage = "/marketplace-your-listing-page";
const String krMarketPlaceMarkSoldPage = "/marketplace-mark-sold-page";
const String krMarketPlaceBuyingPage = "/marketplace-buying-page";

//*chat
const String krMessages = "/messages";
const String krCallScreen = '/call-screen';
const String krRingingScreen = '/ringing-screen';

 //*Notification
 const String krNotificationPage = "/notification-page";

 //*Dashboard
 const String krDashboardOverview = "/dashboard-overview";
 const String krDashboardOverviewContent = "/dashboard-overview-content";
 const String krDashboardOverviewAudience = "/dashboard-overview-audience";
 const String krDashboardFundTransfer = "/dashboard-fund-transfer";
 const String krDashboardFundTransferDetails = "/dashboard-fund-transfer-details";
 const String krDashboardSelectPeople = "/dashboard-select-people";
 const String krDashboardFundTransferOtp = "/dashboard-fund-transfer-otp";
 const String krDashboardDonation = "/dashboard-donation";
 const String krDashboardDonatedPost = "/dashboard-donated-post";
 const String krDashboardCheckInCalender = "/dashboard-check-in-calender";
 const String krDashboardGift = "/dashboard-gift";
 const String krDashboardGiftEarned = "/dashboard-gift-earned";
 const String krDashboardStar = "/dashboard-star";
 const String krDashboardStarHistory = "/dashboard-star-history";
 const String krDashboardAward = "/dashboard-award";
 const String krDashboardAllAwards = "/dashboard-all-awards";
 const String krDashboardPerformance = "/dashboard-performance";
 const String krDashboardQuiz = "/dashboard-quiz";
 const String krDashboardPayout = "/dashboard-payout";
 const String krDshboardPayoutWithdraw = "/dashboard-payout-withdraw";
 //* payout settings
 const String krPayoutManualLinkBankAccount = "/payout-manual-link-bank-account";
 const String krPayoutAddCrypto = "/payout-add-crypto";
 const String krPayoutAddDebitCard = "/payout-add-debit-card";
 const String krPayoutTaxInfo = "/payout-tax-info";
 const String krPayoutPassportVerification = "/payout-passport-verification";
 const String krPayoutNidVerification = "/payout-nid-verification";
 const String krPayoutStudentIdVerification = "/payout-student-id-verification";
 const String krPayoutBankAccountTaxPassportInfoView = "/payout-tax-info-view";
 const String krPayoutBusinessInfo = "/payout-business-info";
 
 //* Profile view
 const String krProfileView = "/profile-view";
 const String krProfileViewAbout = "/profile-view-about";
 const String krProfileViewFriend = "/profile-view-friend";
 const String krProfileViewFamily = "/profile-view-family";
 const String krProfileViewFollower = "/profile-view-follower";
 const String krProfileViewCreateReview = "/profile-view-create-review";

//* Settings
const String krProfileDetailsPage = "/profile-details-page";
const String krPasswordAndSecurity = "/password-and-security";
const String krDefaultAudience = "/default-audience";
const String krReactionPreferences = "/reaction-preferences";
const String krDarkMode = "/dark-mode";
const String krLanguageAndRegion = "/language-and-region";
const String krHowPeopleWillFindYou = "/how_people_will_find_you_page.dart";
// const String krProfileViewFriend = "/profile-view-friend";
// const String krProfileViewFamily = "/profile-view-family";
// const String krProfileViewFollower = "/profile-view-follower";
// const String krProfileViewCreateReview = "/profile-view-create-review";

List<GetPage<dynamic>>? routes = [
  //* info:: auth screens
  GetPage(name: krLogin, page: () => Login(), transition: Transition.noTransition),
  GetPage(name: krSavedUserLogin, page: () => SavedUserLogin(), transition: Transition.noTransition),
  GetPage(name: krRegister, page: () => Register(), transition: Transition.noTransition),
  GetPage(name: krSelectBirthday, page: () => SelectBirthday(), transition: Transition.noTransition),
  GetPage(name: krSelectGender, page: () => SelectGender(), transition: Transition.noTransition),
  GetPage(name: krSetEmail, page: () => SetEmail(), transition: Transition.noTransition),
  GetPage(name: krSetNewPass, page: () => SetPassword(), transition: Transition.noTransition),
  GetPage(name: krSelectProfession, page: () => SelectProfessionScreen(), transition: Transition.noTransition),
  GetPage(name: krSelectInterest, page: () => SelectInterestScreen(), transition: Transition.noTransition),
  GetPage(name: krUploadPicture, page: () => PictureUploadScreen(), transition: Transition.noTransition),
  GetPage(name: krForgotPassword, page: () => ForgotPasswordScreen(), transition: Transition.noTransition),
  GetPage(name: krResetPass, page: () => ResetPasswordScreen(), transition: Transition.noTransition),
  GetPage(name: krOTP, page: () => OTPVerifyScreen(), transition: Transition.noTransition),

  //* introduction screen

  //* menu screen
  GetPage(name: krMenu, page: () => Menu(), transition: Transition.noTransition),
  GetPage(name: krProfile, page: () => Profile(), transition: Transition.noTransition),
  GetPage(name: krFriends, page: () => Friends(), transition: Transition.noTransition),
  GetPage(name: krFamily, page: () => Family(), transition: Transition.noTransition),
  GetPage(name: krEditProfile, page: () => EditProfile(), transition: Transition.noTransition),
  GetPage(name: krEditBio, page: () => EditBio(), transition: Transition.noTransition),
  GetPage(name: krPhotoDetails, page: () => PhotoDetails(), transition: Transition.noTransition),
  GetPage(name: krVideos, page: () => Videos(), transition: Transition.noTransition),
  GetPage(name: krVideoDetails, page: () => VideoDetails(), transition: Transition.noTransition),
  GetPage(name: krPhotoPreview, page: () => PhotoPreview(), transition: Transition.noTransition),
  GetPage(name: krEditAboutInfo, page: () => EditAboutInfo(), transition: Transition.noTransition),
  GetPage(name: krSettings, page: () => Settings(), transition: Transition.noTransition),
  GetPage(name: krProfileDetails, page: () => ProfileDetailsPage(), transition: Transition.noTransition),
  GetPage(name: krEdit, page: () => EditPage(), transition: Transition.noTransition),
  GetPage(name: krAddFamily, page: () => AddFamily(), transition: Transition.noTransition),
  GetPage(name: krAddFriend, page: () => AddFriend(), transition: Transition.noTransition),
  GetPage(name: krViewPhoto, page: () => ViewPhoto(), transition: Transition.noTransition),
  GetPage(name: krEditRelationship, page: () => EditRelationshipPage(), transition: Transition.noTransition),
  GetPage(name: krEditBasicInfo, page: () => EditBasicInfoPage(), transition: Transition.noTransition),
  GetPage(name: krAddLanguage, page: () => AddLanguagePage(), transition: Transition.noTransition),

  //* info:: other screens
  GetPage(name: krSplashScreen, page: () => const SplashScreen(), transition: Transition.noTransition),

  //* create post
  GetPage(name: krCreatePost, page: () => CreatePost(), transition: Transition.downToUp),
  GetPage(name: krSelectCategory, page: () => SelectCategory(), transition: Transition.downToUp),
  GetPage(name: krUploadedImageListPage, page: () => UploadImageListPage(), transition: Transition.rightToLeft),
  GetPage(name: krAddKid, page: () => AddKidPage(), transition: Transition.noTransition),

  //* home
  GetPage(name: krHome, page: () => HomePage(), transition: Transition.noTransition),
  GetPage(name: krHomePostDetails, page: () => HomePostDetails(), transition: Transition.noTransition),
  GetPage(name: krGiftView, page: () => CommonGiftViewScreen(), transition: Transition.downToUp),
  //*newly added for gallery image and videos
  GetPage(name: krGalleryPhotos, page: () => GalleryPhotos(), transition: Transition.noTransition),
  GetPage(name: krGalleryVideos, page: () => GalleryVideos(), transition: Transition.noTransition),
  GetPage(name: krCreateAlbum, page: () => CreateAlbum(), transition: Transition.noTransition),
  GetPage(name: krCreateAlbumLocation, page: () => CreateAlbumLocation(), transition: Transition.noTransition),
  GetPage(name: krCreateAlbumUploadImageList, page: () => CreateAlbumUploadImageList(), transition: Transition.noTransition),
  //*Kids
  GetPage(name: krKidsPage, page: () => KidsPage(), transition: Transition.noTransition),
  GetPage(name: krEditKidPage, page: () => EditKidPage(), transition: Transition.noTransition),
  GetPage(name: krAddKidBasicInfo, page: () => AddKidBasicInfo(), transition: Transition.noTransition),
  GetPage(name: krAddKidContactInfo, page: () => AddKidContactInfo(), transition: Transition.noTransition),
  GetPage(name: krAddKidSocialLinks, page: () => AddKidSocialLinks(), transition: Transition.noTransition),
  GetPage(name: krAddKidUploadImage, page: () => AddKidUploadImage(), transition: Transition.noTransition),
  //*Store
  GetPage(name: krStore, page: () => StorePage(), transition: Transition.noTransition),
  GetPage(name: krAddStoreBasicInfo, page: () => AddStoreBasicInfo(), transition: Transition.noTransition),
  GetPage(name: krAddStoreContactInfo, page: () => AddStoreContactInfo(), transition: Transition.noTransition),
  GetPage(name: krAddStoreSocialLinks, page: () => AddStoreSocialLinks(), transition: Transition.noTransition),
  GetPage(name: krAddStoreDocuments, page: () => AddStoreDocuments(), transition: Transition.noTransition),
  GetPage(name: krAddStoreUploadImage, page: () => AddStoreUploadImage(), transition: Transition.noTransition),
  //*Pendent
  GetPage(name: krPendentPage, page: () => PendentPage(), transition: Transition.noTransition),
  GetPage(name: krAllPendent, page: () => AllPendent(), transition: Transition.noTransition),
  //*Badges
  GetPage(name: krBadgesStarPage, page: () => BadgesStarPage(), transition: Transition.noTransition),
  GetPage(name: krAllBadges, page: () => AllBadges(), transition: Transition.noTransition),
  GetPage(name: krPurchaseStar, page: () => PurchaseStar(), transition: Transition.noTransition),
  //*Quiz
  GetPage(name: krQuizPage, page: () => QuizPage(), transition: Transition.noTransition),
  GetPage(name: krMyQuiz, page: () => MyQuiz(), transition: Transition.noTransition),
  //*Birthday
  GetPage(name: krBirthdayPage, page: () => BirthdayPage(), transition: Transition.noTransition),
  //*Kid profile
  GetPage(name: krKidProfile, page: () => KidProfile(), transition: Transition.noTransition),
  GetPage(name: krEditKidProfile, page: () => EditKidProfile(), transition: Transition.noTransition),
  GetPage(name: krKidPhotoPreview, page: () => KidPhotoPreview(), transition: Transition.noTransition),
  GetPage(name: krKidPhotoView, page: () => KidPhotoView(), transition: Transition.noTransition),
  GetPage(name: krKidEditBio, page: () => KidEditBio(), transition: Transition.noTransition),
  GetPage(name: krKidEditAboutInfo, page: () => KidEditAboutInfo(), transition: Transition.noTransition),
  GetPage(name: krSelectHobbiesPage, page: () => SelectHobbiesPage(), transition: Transition.noTransition),
  GetPage(name: krKidEditPage, page: () => KidEditPage(), transition: Transition.noTransition),
  GetPage(name: krKidEditRelation, page: () => KidEditRelationPage(), transition: Transition.noTransition),
  GetPage(name: krKidAddLanguage, page: () => KidAddLanguagePage(), transition: Transition.noTransition),
  //* Awards
  GetPage(name: krAwardsPage, page: () => AwardsPage(), transition: Transition.noTransition),
  GetPage(name: krAwardDetailsPage, page: () => AwardDetailsPage(), transition: Transition.noTransition),
  //* Search
  GetPage(name: krSearchPage, page: () => SearchPage(), transition: Transition.noTransition),

  //*Store profile
  GetPage(name: krStoreProfile, page: () => StoreProfile(), transition: Transition.noTransition),
  GetPage(name: krEditStoreProfile, page: () => EditStoreProfile(), transition: Transition.noTransition),
  GetPage(name: krStoreEditAbout, page: () => StoreEditAbout(), transition: Transition.noTransition),
  GetPage(name: krEditStorePhoneNumber, page: () => EditStorePhoneNumber(), transition: Transition.noTransition),
  GetPage(name: krEditStoreEmail, page: () => EditStoreEmail(), transition: Transition.noTransition),
  GetPage(name: krEditStorePrivacyLink, page: () => EditStorePrivacyLink(), transition: Transition.noTransition),
  GetPage(name: krEditStoreQrCode, page: () => EditStoreQrCode(), transition: Transition.noTransition),
  GetPage(name: krEditStoreBIN, page: () => EditStoreBIN(), transition: Transition.noTransition),
  GetPage(name: krEditStoreLocation, page: () => EditStoreLocation(), transition: Transition.noTransition),
  GetPage(name: krEditStoreCategory, page: () => EditStoreCategory(), transition: Transition.noTransition),
  GetPage(name: krEditStoreSocialLink, page: () => EditStoreSocialLink(), transition: Transition.noTransition),
  GetPage(name: krEditStorePayment, page: () => EditStorePayment(), transition: Transition.noTransition),
  GetPage(name: krStoreAddLegalDocument, page: () => StoreAddLegalDocument(), transition: Transition.noTransition),
  GetPage(name: krStoreEditBio, page: () => StoreEditBio(), transition: Transition.noTransition),
  GetPage(name: krStoreReview, page: () => StoreReview(), transition: Transition.noTransition),
  GetPage(name: krStorePhotoPreview, page: () => StorePhotoPreview(), transition: Transition.noTransition),
  GetPage(name: krStorePhotoView, page: () => StorePhotoView(), transition: Transition.noTransition),

  //* Messenger
  GetPage(name: krInbox, page: () => Inbox(), transition: Transition.rightToLeft),
  //*Marketplace
  GetPage(name: krMarketPlacePage, page: () => MarketplacePage(), transition: Transition.noTransition),
  GetPage(name: krMarketPlaceCategoriesPage, page: () => MarketPlaceCategoriesPage(), transition: Transition.noTransition),
  GetPage(name: krMarketPlaceViewListingPage, page: () => MarketPlaceViewListingPage(), transition: Transition.noTransition),
  GetPage(name: krMarketPlaceAccount, page: () => MarketPlaceAccount(), transition: Transition.noTransition),
  GetPage(name: krMarketPlaceNotification, page: () => MarketPlaceNotification(), transition: Transition.noTransition),
  GetPage(name: krMarketPlaceRecentActivity, page: () => MarketPlaceRecentActivity(), transition: Transition.noTransition),
  GetPage(name: krMarketPlaceBiddingPage, page: () => MarketPlaceBiddingPage(), transition: Transition.noTransition),
  GetPage(name: krMarketPlaceSellingPage, page: () => MarketPlaceSellingPage(), transition: Transition.noTransition),
  GetPage(name: krMarketPlaceYourListingPage, page: () => MarketPlaceYourListingPage(), transition: Transition.noTransition),
  GetPage(name: krMarketPlaceMarkSoldPage, page: () => MarketPlaceMarkSoldPage(), transition: Transition.noTransition),
  GetPage(name: krMarketPlaceBuyingPage, page: () => MarketPlaceBuyingPage(), transition: Transition.noTransition),

  //*Notification
  GetPage(name: krNotificationPage, page: () => NotificationPage(), transition: Transition.noTransition),
  GetPage(name: krMessages, page: () => MessageScreen(), transition: Transition.noTransition),
  //*Selfie
  GetPage(name: krSelfiePage, page: () => SelfiePage(), transition: Transition.noTransition),
  GetPage(name: krSelfiePrivacyPage, page: () => SelfiePrivacyPage(), transition: Transition.noTransition),
  GetPage(name: krSelectPeoplePage, page: () => SelectPeoplePage(), transition: Transition.noTransition),
   GetPage(name: krCallScreen, page: () => CallScreen(), transition: Transition.noTransition),
  GetPage(name: krRingingScreen, page: () => RingingScreen(), transition: Transition.noTransition),
  GetPage(name: krSelfieViewPage, page: () => SelfieViewPage(), transition: Transition.noTransition),

  //*Dashboard
  //*Dashboard payouts
  GetPage(name: krDashboardOverview, page: () => DashboardOverview(), transition: Transition.noTransition),
  GetPage(name: krDashboardOverviewContent, page: () => DashboardOverviewContent(), transition: Transition.noTransition),
  GetPage(name: krDashboardOverviewAudience, page: () => DashboardOverviewAudience(), transition: Transition.noTransition),
  GetPage(name: krDashboardFundTransfer, page: () => DashboardFundTransfer(), transition: Transition.noTransition),
  GetPage(name: krDashboardFundTransferDetails, page: () => DashboardFundTransferDetails(), transition: Transition.noTransition),
  GetPage(name: krDashboardSelectPeople, page: () => DashboardSelectPeople(), transition: Transition.noTransition),
  GetPage(name: krDashboardFundTransferOtp, page: () => DashboardFundTransferOtp(), transition: Transition.noTransition),
  GetPage(name: krDashboardDonation, page: () => DashboardDonation(), transition: Transition.noTransition),
  GetPage(name: krDashboardDonatedPost, page: () => DashboardDonatedPost(), transition: Transition.noTransition),
  GetPage(name: krDashboardCheckInCalender, page: () => DashboardCheckInCalender(), transition: Transition.noTransition),
  GetPage(name: krDashboardGift, page: () => DashboardGift(), transition: Transition.noTransition),
  GetPage(name: krDashboardGiftEarned, page: () => DashboardGiftEarned(), transition: Transition.noTransition),
  GetPage(name: krDashboardStar, page: () => DashboardStar(), transition: Transition.noTransition),
  GetPage(name: krDashboardStarHistory, page: () => DashboardStarHistory(), transition: Transition.noTransition),
  GetPage(name: krDashboardAward, page: () => DashboardAward(), transition: Transition.noTransition),
  GetPage(name: krDashboardAllAwards, page: () => DashboardAllAwards(), transition: Transition.noTransition),
  GetPage(name: krDashboardPerformance, page: () => DashboardPerformance(), transition: Transition.noTransition),
  GetPage(name: krDashboardQuiz, page: () => DashboardQuiz(), transition: Transition.noTransition),
  GetPage(name: krDashboardPayout, page: () => DashboardPayouts(), transition: Transition.noTransition),
  GetPage(name: krDshboardPayoutWithdraw, page: () => DashboardPayoutWithdraw(), transition: Transition.noTransition),
  //* payout settings
  GetPage(name: krPayoutManualLinkBankAccount, page: () => PayoutManualLinkBankAccount(), transition: Transition.noTransition),
  GetPage(name: krPayoutAddCrypto, page: () => PayoutAddCrypto(), transition: Transition.noTransition),
  GetPage(name: krPayoutAddDebitCard, page: () => PayoutAddDebitCard(), transition: Transition.noTransition),
  GetPage(name: krPayoutTaxInfo, page: () => PayoutTaxInfo(), transition: Transition.noTransition),
  GetPage(name: krPayoutPassportVerification, page: () => PayoutPassportVerification(), transition: Transition.noTransition),
  GetPage(name: krPayoutNidVerification, page: () => PayoutNidVerification(), transition: Transition.noTransition),
  GetPage(name: krPayoutStudentIdVerification, page: () => PayoutStudentIdVerification(), transition: Transition.noTransition),
  GetPage(name: krPayoutBankAccountTaxPassportInfoView, page: () => PayoutBankAccountTaxPassportInfoView(), transition: Transition.noTransition),
  GetPage(name: krPayoutBusinessInfo, page: () => PayoutBusinessInfo(), transition: Transition.noTransition),
  //* Profile view
  GetPage(name: krProfileView, page: () => ProfileView(), transition: Transition.noTransition),
  GetPage(name: krProfileViewAbout, page: () => ProfileViewAbout(), transition: Transition.noTransition),
  GetPage(name: krProfileViewFriend, page: () => ProfileViewFriend(), transition: Transition.noTransition),
  GetPage(name: krProfileViewFamily, page: () => ProfileViewFamily(), transition: Transition.noTransition),
  GetPage(name: krProfileViewFollower, page: () => ProfileViewFollower(), transition: Transition.noTransition),
  GetPage(name: krProfileViewCreateReview, page: () => ProfileViewCreateReview(), transition: Transition.noTransition),

  //* Settings
  GetPage(name: krProfileDetailsPage, page: () => const ProfileDetailsPage(), transition: Transition.noTransition),
  GetPage(name: krPasswordAndSecurity, page: () => const PasswordAndSecurity(), transition: Transition.noTransition),
  GetPage(name: krDefaultAudience, page: () => const DefaultAudience(), transition: Transition.noTransition),
  GetPage(name: krReactionPreferences, page: () => const ReactionPreferences(), transition: Transition.noTransition),
  GetPage(name: krDarkMode, page: () => const DarkModePage(), transition: Transition.noTransition),
  GetPage(name: krLanguageAndRegion, page: () => const LanguageAndRegion(), transition: Transition.noTransition),
  GetPage(name: krHowPeopleWillFindYou, page: () => const HowPeopleWillFindYou(), transition: Transition.noTransition),

];
