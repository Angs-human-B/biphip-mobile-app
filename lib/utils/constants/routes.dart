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
import 'package:bip_hip/views/create_post/add_kid.dart';
import 'package:bip_hip/views/create_post/create_post.dart';
import 'package:bip_hip/views/create_post/upload_media_list.dart';
import 'package:bip_hip/views/home/home_post_details.dart';
import 'package:bip_hip/views/home/home_post_details_screen.dart';
import 'package:bip_hip/views/home/homepage.dart';
import 'package:bip_hip/views/menu/family/add_family.dart';
import 'package:bip_hip/views/menu/family/family.dart';
import 'package:bip_hip/views/menu/friends/add_friend.dart';
import 'package:bip_hip/views/menu/friends/friends.dart';
import 'package:bip_hip/views/menu/kids/kids.dart';
import 'package:bip_hip/views/menu/profile/edit_about.dart';
import 'package:bip_hip/views/menu/profile/edit_page.dart';
import 'package:bip_hip/views/menu/profile/edit_bio.dart';
import 'package:bip_hip/views/menu/profile/edit_profile.dart';
import 'package:bip_hip/views/create_post/select_category.dart';
import 'package:bip_hip/views/menu/menu.dart';
import 'package:bip_hip/views/menu/settings/settings.dart';
import 'package:bip_hip/views/menu/photos/photo_details.dart';
import 'package:bip_hip/views/menu/photos/photo_preview.dart';
import 'package:bip_hip/views/menu/profile/photo_view.dart';
import 'package:bip_hip/views/menu/photos/photos.dart';
import 'package:bip_hip/views/menu/profile/profile.dart';
import 'package:bip_hip/views/menu/photos/gallery_photos.dart';
import 'package:bip_hip/views/menu/videos/gallery_videos.dart';
import 'package:bip_hip/views/menu/videos/video_details.dart';
import 'package:bip_hip/views/menu/videos/videos.dart';
import 'package:bip_hip/views/splash_and_intro/splash_screen.dart';
import 'package:get/get.dart';

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
const String krNotification = '/notification';
const String krChangePassword = '/change-password';
const String krChangeLanguage = '/change-language';
const String krHomePostDetails = '/home-post-details';
const String krHomePostDetailsScreen = '/home-post-details-screen';

const String krMenu = '/menu';
const String krProfile = '/profile';
const String krEditBio = '/edit-bio';
const String krEditAboutInfo = '/edit-about-info';
const String krEdit = '/edit';
const String krEditProfile = '/edit-profile';
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

const String krCreatePost = '/create-post';
const String krSelectCategory = '/create-post/select-category';
const String krUploadedImageListPage = '/create-post/uploaded-image-list';
const String krAddKid = '/create-post/select-category/add-kid';
//*newly Added for gallery photos and videos
const String krGalleryPhotos = '/gallery-photos';
const String krGalleryVideos = '/gallery-videos';
//*Kids
const String krKidsPage = '/kids-page';

List<GetPage<dynamic>>? routes = [
  // //* info:: auth screens
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

  // //* introduction screen
  // GetPage(name: krIntroductionScreen, page: () => IntroductionPage()),

  //* menu screen
  GetPage(name: krMenu, page: () => Menu(), transition: Transition.noTransition),
  GetPage(name: krProfile, page: () => Profile(), transition: Transition.noTransition),
  GetPage(name: krFriends, page: () => Friends(), transition: Transition.noTransition),
  GetPage(name: krFamily, page: () => Family(), transition: Transition.noTransition),
  GetPage(name: krEditProfile, page: () => EditProfile(), transition: Transition.noTransition),
  GetPage(name: krEditBio, page: () => EditBio(), transition: Transition.noTransition),
  GetPage(name: krPhotos, page: () => Photos(), transition: Transition.noTransition),
  GetPage(name: krPhotoDetails, page: () => PhotoDetails(), transition: Transition.noTransition),
  GetPage(name: krVideos, page: () => Videos(), transition: Transition.noTransition),
  GetPage(name: krVideoDetails, page: () => VideoDetails(), transition: Transition.noTransition),
  GetPage(name: krPhotoPreview, page: () => PhotoPreview(), transition: Transition.noTransition),
  GetPage(name: krEditAboutInfo, page: () => EditAboutInfo(), transition: Transition.noTransition),
  GetPage(name: krSettings, page: () => Settings(), transition: Transition.noTransition),
  GetPage(name: krEdit, page: () => EditPage(), transition: Transition.noTransition),
  GetPage(name: krAddFamily, page: () => AddFamily(), transition: Transition.noTransition),
  GetPage(name: krAddFriend, page: () => AddFriend(), transition: Transition.noTransition),
  GetPage(name: krViewPhoto, page: () => ViewPhoto(), transition: Transition.noTransition),

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
  GetPage(name: krHomePostDetailsScreen, page: () => HomePostDetailsScreen(), transition: Transition.noTransition),
  //*newly added for gallery image and videos
  GetPage(name: krGalleryPhotos, page: () => GalleryPhotos(), transition: Transition.noTransition),
  GetPage(name: krGalleryVideos, page: () => GalleryVideos(), transition: Transition.noTransition),
  //*Kids
  GetPage(name: krKidsPage, page: () => KidsPage(), transition: Transition.noTransition),
];
