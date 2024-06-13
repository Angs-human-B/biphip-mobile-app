/*
|--------------------------------------------------------------------------
| //! api endpoints
|--------------------------------------------------------------------------
*/

//---------------------------------------
//* common api
//---------------------------------------

const String kuGetAllProfessions = '/mobile/get-all-professions'; //DONE
const String kuGetAllInterests = '/mobile/get-all-interests'; //DONE
const String kuGetAllLinkTypes = '/mobile/get-all-link-types'; //DONE
const String kuGetAllRelationShips = '/mobile/get-all-relationships'; //DONE
const String kuGetAllGenders = '/mobile/get-all-genders'; //DONE
const String kuGetAllCities = '/mobile/get-all-cities'; //DONE
const String kuGetAllSchools = '/mobile/get-all-schools'; //DONE
const String kuGetAllCompanies = '/mobile/get-all-companies'; //DONE
const String kuGetAllDegrees = '/mobile/get-all-degrees';
const String kuGetAllPositions = '/mobile/get-all-positions'; //DONE
const String kuGetAllPostCatagories = '/mobile/get-all-post-categories'; //DONE
const String kuGetAllKidList = '/mobile/user/get-all-kids'; //DONE
const String kuGetALlLanguageList = '/mobile/get-all-languages'; //DONE

//---------------------------------------
//* authentication story
//---------------------------------------

const String kuLogin = '/mobile/login';
const String kuRegistration = '/mobile/signup';
const String kuSocialLogIn = '/mobile/social-login';
const String kuRegistrationVerifyOTP = '/mobile/user/verify-email-otp';
const String kuRegistrationResendOTP = '/mobile/resend-otp';
const String kuForgetPassword = '/mobile/forgot-password';
const String kuForgetPasswordVerifyOTP = '/mobile/verify-forgot-password-otp';
const String kuForgetPasswordResendOTP = '/mobile/resend-forgot-password-otp';
const String kuResetPassword = '/mobile/user/reset-password';
const String kuLogOut = '/mobile/logout';

//---------------------------------------
//* profile story
//---------------------------------------

const String kuGetProfileOverView = '/mobile/user/get-profile-overview'; //DONE
const String kuGetPostsByCategoryId = '/user/get-posts-by-category-id';

//* Address/Places
const String kuGetAllPlaces = '/mobile/user/get-all-places'; //? NOT NEEDED
const String kuSetHomeTown = '/mobile/user/set-hometown'; //DONE
const String kuSetCurrentCity = '/mobile/user/set-current-city'; //DONE
const String kuOtherCity = '/mobile/user/store-city'; //DONE
const String kuUpdateCity = '/mobile/user/update-city'; //DONE
const String kuDeleteCity = '/mobile/user/delete-city'; //DONE

//* Work and Education
const String kuGetWorkAndEducation = '/mobile/user/get-work-and-education'; //? NOT NEEDED
const String kuStoreSchool = '/mobile/user/store-school'; //DONE
const String kuUpdateSchool = '/mobile/user/update-school'; //DONE
const String kuDeleteSchool = '/mobile/user/delete-school'; //DONE
const String kuStoreCollege = '/mobile/user/store-college'; //DONE
const String kuUpdateCollege = '/mobile/user/update-college'; //DONE
const String kuDeleteCollege = '/mobile/user/delete-college'; //DONE
const String kuStoreWork = '/mobile/user/store-work'; //DONE
const String kuUpdateWork = '/mobile/user/update-work'; //DONE
const String kuDeleteWork = '/mobile/user/delete-work'; //DONE

//* Contact & Basic Info
const String kuGetContactAndBasicInfo = '/mobile/user/get-contacts-and-basic-info'; //? NOT NEEDED
const String kuStoreContact = '/mobile/user/store-contact'; //DONE
const String kuUpdateContact = '/mobile/user/update-contact'; //DONE
const String kuDeleteContact = '/mobile/user/delete-contact'; //DONE
const String kuStoreLink = '/mobile/user/store-link'; //DONE
const String kuUpdateLink = '/mobile/user/update-link'; //DONE
const String kuDeleteLink = '/mobile/user/delete-link'; //DONE
const String kuUpdateDateOfBirth = '/mobile/user/update-date-of-birth'; //DONE
const String kuUpdateBio = '/mobile/user/update-bio'; //DONE
const String kuUpdateLanguages = '/mobile/user/update-languages';
const String kuUpdateUserFullName = '/mobile/user/update-full-name'; //DONE

//* About Section
const String kuSetGeneralSetting = '/mobile/user/store-user-setting';
const String kuGetGeneralSetting = '/mobile/user/get-user-setting';

//* Profile and Cover Photo
const String kuSetProfilePicture = '/mobile/user/store-profile-picture';
const String kuSetCoverPhoto = '/user/store-cover-photo';
//*Photos & Albums
const String kuAlbumList = '/mobile/user/get-my-image-albums';
const String kuImageDetails = '/mobile/user/get-image-details';
const String kuImageMakeProfilePicture = '/mobile/user/image-make-profile-picture';
const String kuImageMakeCoverPhoto = '/mobile/user/image-make-cover-photo';
const String kuDeleteImage = '/mobile/user/delete-image';
const String kuDownloadImage = '/mobile/user/download-image';
const String kuUpdateImageDescription = '/mobile/user/update-image-description';
const String kuCreateAlbum = '/mobile/user/store-image-album';
const String kuUpdateAlbum = '/mobile/user/update-image-album';
const String kuDeleteAlbum = '/mobile/user/delete-image-album';

//---------------------------------------
//* Friends and Family
//---------------------------------------

const String kuCommonUserSearch = '/mobile/user/search-users';

//* friends
const String kuGetFriendList = '/mobile/user/friends';
const String kuGetFriendRequestSendList = '/mobile/user/my-requests';
const String kuGetFriendRequestReceiveList = '/mobile/user/my-friend-requests';
const String kuSendFriendRequest = '/mobile/user/send-friend-request';
const String kuCancelFriendRequest = '/mobile/user/cancel-friend-request';
const String kuAcceptFriendRequest = '/mobile/user/accept-friend-request';
const String kuRejectFriendRequest = '/mobile/user/reject-friend-request';
const String kuFollowUser = '/mobile/user/follow-user';
const String kuUnFollowUser = '/mobile/user/unfollow-user';
const String kuUnFriendUser = '/mobile/user/unfriend-user';

//* family
const String kuGetFamilyList = '/mobile/user/families';
const String kuGetFamilyRequestReceiveList = '/mobile/user/family-request-receive-list';
const String kuGetFamilyRequestSendList = '/mobile/user/family-request-send-list';
const String kuSendFamilyRequest = '/mobile/user/send-family-request';
const String kuCancelFamilyRequest = '/mobile/user/cancel-family-request';
const String kuAcceptFamilyRequest = '/mobile/user/accept-family-request';
const String kuRejectFamilyRequest = '/mobile/user/reject-family-request';
const String kuBlockUser = '/user/block-user';
const String kuUnblockUser = '/user/unblock-user';

//* Family Relation Status
const String kuGetAllFamilyRelations = '/mobile/get-all-family-relations';
//*Friend Search
const String kuGetSearchFriends = '/mobile/user/search-friends';

//---------------------------------------
//* Create Post
//---------------------------------------

const String kuAddKid = '/mobile/user/store-kid';
const String kuAddStore = '/mobile/user/store-store';
const String kuCreatePost = '/mobile/user/store-post';
const String kuGetStores = '/mobile/user/get-all-stores';
const String kuGetCreatePost = '/mobile/user/create-post';
const String kuSharePost = '/mobile/user/share-post';

//---------------------------------------
//* Home page
//---------------------------------------

const String kuGetAllPosts = '/mobile/user/get-all-posts';
const String kuGetPostData = '/mobile/user/get-post';
const String kuGetTimelinePostData = '/mobile/user/get-my-timeline-posts';

//*Selfie
const String kuGetFriendSelfie = '/mobile/user/selfie/get-friend-selfies';
const String kuStoreSelfie = '/mobile/user/selfie/store-selfie';
const String kuDeleteSelfie = '/mobile/user/selfie/delete';
const String kuReportSelfie = '/mobile/user/store-selfie-report';
const String kuSelfieSendGift = '/mobile/user/selfie/send-gift';


//* kids
//---------------------------------------
const String kuDeleteKids = '/mobile/user/delete-kid';
const String kuUpdateKid = '/mobile/user/update-kid';

//*Quiz
const String kuGetAllQuiz = '/mobile/user/get-quiz-for-today';
const String kuSubmitAnswer = '/mobile/user/submit-quiz';
const String kuMyAllQuizes = '/mobile/user/get-my-quiz-all';
const String kuMyQuizWinner = '/mobile/user/get-my-quiz-winning';

//*Birthday
const String kuGetBirthdays = '/mobile/user/get-birthdays';
const String kuBirthdayWish = '/mobile/user/store-birthday-wish';
//*Badges
const String kuUserBadges = '/mobile/user/get-user-badges';
const String kuGetStarPrice = '/mobile/get-star-price';
const String kuPurchaseStar = '/mobile/user/purchase-star';
//* Pendent
const String kuUserPendent = '/mobile/user/get-user-pendents';
const String kuSetUserPendent = '/mobile/user/set-user-pendent';
//* Kid profile
const String kuKidOverview = '/mobile/user/kid-profile-overview';
const String kuKidUpdateBio = '/mobile/user/update-kid-bio';
const String kuKidUpdateProfilePicture = '/mobile/user/update-kid-profile-image';
const String kuKidUpdateCoverPhoto = '/mobile/user/update-kid-cover-photo';
const String kuKidUpdateParentRelation = '/mobile/user/update-kid-parent-relation';
const String kuKidUpdateGender = '/mobile/user/update-kid-gender';
const String kuKidUpdateLanguages = '/mobile/user/update-kid-languages';
const String kuGetAllHobbies = '/mobile/get-all-hobbies';
const String kuKidUpdateHobbies = '/mobile/user/update-kid-hobbies';
const String kuKidStoreContact = '/mobile/user/store-kid-contact';
const String kuKidUpdateContact = '/mobile/user/update-kid-contact';
const String kuKidDeleteContact = '/mobile/user/delete-kid-contact';
const String kuKidAllSchools = '/mobile/user/get-kid-schools';
const String kuKidStoreSchool = '/mobile/user/store-kid-school';
const String kuKidUpdateSchool = '/mobile/user/update-kid-school';
const String kuKidDeleteSchool = '/mobile/user/delete-kid-school';
const String kuGetKidPosts = '/mobile/user/get-kid-posts';
const String kuGetAllKidContacts = '/mobile/user/get-kid-contacts';
const String kuKidCreatePost = '/mobile/user/store-post';

//* Store profile
const String kuGetBusinessCategories = '/mobile/get-business-categories';
const String kuStoreProfileOverview = '/mobile/user/store-profile-overview';
const String kuUpdateStoreBio = '/mobile/user/update-store-bio';
const String kuUpdateStoreBin = '/mobile/user/update-store-bin';
const String kuUpdateStoreQr = '/mobile/user/update-store-qr';
const String kuUpdateStorePrivacyLink = '/mobile/user/update-store-privacy-link';
const String kuUpdateStoreCategories = '/mobile/user/update-store-categories';
const String kuUpdateStoreLegalFiles = '/mobile/user/update-store-legal-files';
const String kuUpdateStoreProfilePicture = '/mobile/user/set-store-profile-picture';
const String kuUpdateStoreCoverPhoto = '/mobile/user/set-store-cover-picture';
const String kuStoreStoreLocation = '/mobile/user/store-store-location';
const String kuGetStoreLocations = '/mobile/user/get-store-locations';
const String kuUpdateStoreLocation = '/mobile/user/update-store-location';
const String kuDeleteStoreLocation = '/mobile/user/delete-store-location';
const String kuGetAllStoreContacts = '/mobile/user/get-store-contacts';
const String kuStoreStoreContacts = '/mobile/user/store-store-contact';
const String kuUpdateStoreContacts = '/mobile/user/update-store-contact';
const String kuDeleteStoreContact = '/mobile/user/delete-store-contact';
const String kuGetAllLinks = '/mobile/user/get-store-links';
const String kuStoreStoreLink = '/mobile/user/store-store-link';
const String kuUpdateStoreLink = '/mobile/user/update-store-link';
const String kuDeleteStoreLink = '/mobile/user/delete-store-link';
const String kuGetStorePost = '/mobile/user/get-store-posts';

//* Post Reaction
const String kuSetReaction = "/mobile/user/set-reaction";

//* Star
const String kuGiftStar = '/mobile/user/post-gift-star';

//*  Comment
const String kuSetComment = "/mobile/user/set-comment";
const String kuGetComment = "/mobile/user/get-comments";
const String kuDeleteComment = "/mobile/user/delete-comment";
const String kuHideComment = "/mobile/user/hide-comment";
const String kuUpdateComment = "/mobile/user/update-comment";

const String kuDeleteReply = "/mobile/user/delete-comment-reply";
const String kuHideReply = "/mobile/user/hide-comment-reply";
const String kuSetReply = "/mobile/user/set-comment-reply";
const String kuUpdateReply = "/mobile/user/update-comment-reply";
const String kuGetReply = "/mobile/user/get-comment-replies";
//* Search
const String kuSearchHistory = '/mobile/user/search-history';
const String kuDeleteSearchHistory = '/mobile/user/delete-search-history';
const String kuDeleteAllSearchHistory = '/mobile/user/delete-all-search-history';
const String kuSearchFilterData = '/mobile/user/search-filter-data';
const String kuSearch = '/mobile/user/search';

//* Post Action
const String kuHidePost = '/mobile/user/hide-post';
const String kuDeletePost = '/mobile/user/delete-post';
const String kuPostNotificationOff = '/mobile/user/off-post-notification';
const String kuPostNotificationOn = '/mobile/user/on-post-notification';
const String kuEditAudience = '/mobile/user/update-post-privacy';
const String kuEditDateTime = '/mobile/user/update-post-date-time';
const String kuGetReoportList = '/mobile/get-all-reporting-list';
const String kuPostReport = '/mobile/user/store-post-report';
const String kuUndoPostReport = '/mobile/user/remove-post-report';
const String kuUpdatePost = '/mobile/user/update-post';

//* Awards
const String kuGetMyAward = "/mobile/user/get-my-awards";

//* Dashboard
const String kuGetProfileOverview = "/mobile/dashboard/profile-overview";
const String kuDashboardContents = "/mobile/dashboard/contents";
const String kuDashboardStarInsight = "/mobile/dashboard/star-insight";
const String kuDashboardGiftInsight = "/mobile/dashboard/gift-insight";

/*
|--------------------------------------------------------------------------
| //! Image urls
|--------------------------------------------------------------------------
*/

//* normal images
const String kiLogoImageUrl = 'assets/images/logo.png';
const String kiGoogleImageUrl = 'assets/images/Google.png';
const String kiFacebookImageUrl = 'assets/images/facebook.png';
const String kiTwitterImageUrl = 'assets/images/twitter.png';
const String kiCoverPicImageUrl = 'assets/images/coverPic.png';
const String kiFamilyImageUrl = 'assets/images/family.png';
const String kiFriendImageUrl = 'assets/images/friend.png';
const String kiProfileDefaultImageUrl = 'assets/images/profileDefault.png';
const String kiProfilePicImageUrl = 'assets/images/profilePic.png';
const String kiProfilePic4xImageUrl = 'assets/images/profilePic4x.png';
const String kiDummyImage1ImageUrl = 'assets/images/pic4.jpeg';
const String kiDummyImage2ImageUrl = 'assets/images/pic5.jpeg';
const String kiDummyImage3ImageUrl = 'assets/images/pic12.jpeg';
const String kiBoostPost1xImage3ImageUrl = 'assets/images/boost1x.png';
const String kiBoostPost4xImage3ImageUrl = 'assets/images/boost4x.png';
const String kiOnBoardingImageUrl = 'assets/images/onBoarding.png';
const String kiOnBoarding4xImageUrl = 'assets/images/onBoarding4x.png';

//* svg images
const String kiBadgeSvgImageUrl = 'assets/svg/badge.svg';
const String kiBadge1SvgImageUrl = 'assets/svg/badge1.svg';
const String kiBadge2SvgImageUrl = 'assets/svg/badge2.svg';
const String kiBadge3SvgImageUrl = 'assets/svg/badge3.svg';
const String kiBadge4SvgImageUrl = 'assets/svg/badge4.svg';
const String kiHahaSvgImageUrl = 'assets/svg/haha.svg';
const String kiLoveSvgImageUrl = 'assets/svg/love.svg';
const String kiAngrySvgImageUrl = 'assets/svg/angry.svg';
const String kiLikeSvgImageUrl = 'assets/svg/like.svg';
const String kiSadSvgImageUrl = 'assets/svg/sad.svg';
const String kiWowSvgImageUrl = 'assets/svg/wow.svg';
const String kiFacebookSvgImageUrl = 'assets/svg/facebook.svg';
const String kiLinkedInSvgImageUrl = 'assets/svg/linkedin.svg';
const String kiTwitterSvgImageUrl = 'assets/svg/twitter.svg';
const String kiWebSvgImageUrl = 'assets/svg/web.svg';
const String kiYoutubeSvgImageUrl = 'assets/svg/youtube.svg';
const String kiTwitterXSvgImageUrl = 'assets/svg/x.svg';
const String kiOnBoardingSvgUrl = 'assets/svg/onbording.svg';
const String kiRegistrationBonusSvgUrl = 'assets/svg/registration_bonus.svg';
const String kiRegularPostSvgUrl = 'assets/svg/regular_post.svg';
const String kiBiddingPostSvgUrl = 'assets/svg/bidding_post.svg';
const String kiBoostPostSvgUrl = 'assets/svg/boost_post_banner.svg';
const String kiInstagramSvgUrl = 'assets/svg/instagram.svg';
const String kiTwitterX2SvgUrl = 'assets/svg/twitter_x.svg';
const String kiWarningInfo = 'assets/svg/warning_info.svg';
const String kiStoreImage = 'assets/svg/store_image.svg';
const String kikidImage = 'assets/svg/kid_image.svg';
const String kiUploadImage = 'assets/svg/upload_image.svg';
const String kiCongratulation1 = 'assets/svg/congratulation1.svg';
const String kiCongratulation2 = 'assets/svg/congratulation2.svg';
const String kiPayment = 'assets/svg/payment.svg';
const String kiGallery = 'assets/svg/gallery.svg';
const String kiLocation = 'assets/svg/location.svg';
const String kiTime = 'assets/svg/time.svg';
const String kiTagFriend = 'assets/svg/tag_friend.svg';
const String kiPendentSvgImageUrl = 'assets/svg/pendent.svg';
const String kiDollarSvgImageUrl = 'assets/svg/dollar.svg';
const String kiWinner = 'assets/svg/winner.svg';
const String kiPositionBadge = 'assets/svg/position_badge.svg';
const String kiQuizWinner = 'assets/svg/quiz_winner.svg';
const String kiParentSvgImageUrl = 'assets/svg/parent.svg';
const String kiAward = 'assets/svg/award.svg';
const String kiWorldSvgImage = 'assets/svg/world.svg';
const String kiStarSvgImage = 'assets/svg/star.svg';
const String kiNagadSvgImage = 'assets/svg/nagad.svg';
const String kiPaypalSvgImage = 'assets/svg/paypal.svg';
const String kiReviewSvgImage = 'assets/svg/review.svg';
const String kiRightArrow = 'assets/svg/right_arrow.svg';
