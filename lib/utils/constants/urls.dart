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
const String kuGetAllKidList = '/mobile/user/get-all-kids';

//---------------------------------------
//* authentication story
//---------------------------------------

const String kuLogin = '/mobile/login';
const String kuRegistration = '/mobile/signup';
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
const String kuAlbumList = '/mobile/user/get-my-albums';

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

//* Family Relation Status
const String kuGetAllFamilyRelations = '/mobile/get-all-family-relations';
//*Friend Search
const String kuGetSearchFriends = '/mobile/user/search-friends';

//---------------------------------------
//* Create Post
//---------------------------------------

const String kuAddKid = '/mobile/user/store-kid';
const String kuAddBrand = '/mobile/user/store-brand';

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
const String kiWowSvgImageUrl = 'assets/svg/wow.svg';
const String kiFacebookSvgImageUrl = 'assets/svg/facebook.svg';
const String kiLinkedInSvgImageUrl = 'assets/svg/linkedin.svg';
const String kiTwitterSvgImageUrl = 'assets/svg/twitter.svg';
const String kiWebSvgImageUrl = 'assets/svg/web.svg';
const String kiYoutubeSvgImageUrl = 'assets/svg/youtube.svg';
const String kiTwitterXSvgImageUrl = 'assets/svg/x.svg';
const String kiOnBoardingSvgUrl = 'assets/svg/onbording.svg';
