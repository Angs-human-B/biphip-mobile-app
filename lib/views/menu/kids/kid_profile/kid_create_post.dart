// import 'package:bip_hip/controllers/menu/kids_controller.dart';
// import 'package:bip_hip/controllers/post/create_post_controller.dart';
// import 'package:bip_hip/helpers/menu/kids/kid_helper.dart';
// import 'package:bip_hip/utils/constants/imports.dart';
// import 'package:bip_hip/views/post/widgets/create_post_bottom_section.dart';
// import 'package:bip_hip/views/post/widgets/create_post_media_section.dart';
// import 'package:bip_hip/views/post/widgets/create_post_upper_section.dart';
// import 'package:bip_hip/widgets/common/utils/common_divider.dart';

// class KidCreatePost extends StatelessWidget {
//   KidCreatePost({super.key});
//   final KidsController kidsController = Get.find<KidsController>();
//   final KidHelper kidHelper = KidHelper();
//   final GlobalController globalController = Get.find<GlobalController>();

//   @override
//   Widget build(BuildContext context) {
//     ll(width);
//     return Stack(
//       children: [
//         Container(
//           color: cWhiteColor,
//           child: SafeArea(
//             top: false,
//             child: Scaffold(
//               backgroundColor: cWhiteColor,
//               appBar: PreferredSize(
//                 preferredSize: const Size.fromHeight(kAppBarSize),
//                 //* info:: appBar
//                 child: CustomAppBar(
//                   appBarColor: cWhiteColor,
//                   title: ksCreatePost.tr,
//                   hasBackButton: true,
//                   isCenterTitle: true,
//                   onBack: () {
//                     Get.back();
//                   },
//                   action: [
//                     Padding(
//                       padding: const EdgeInsets.only(right: h16),
//                       child: CustomElevatedButton(
//                         label: ksPost.tr,
//                         onPressed: kidsController.isPostButtonActive.value
//                             ? () async {
//                                 unfocus(context);
//                                 // await createPostController.createPost();
//                               }
//                             : null,
//                         buttonWidth: 60,
//                         buttonHeight: 32,
//                       ),
//                     ),
//                     // ),
//                   ],
//                 ),
//               ),
//               body: Stack(
//                 children: [
//                   Container(
//                     color: cWhiteColor,
//                     height: height - kAppBarSize,
//                     width: width,
//                     child: SingleChildScrollView(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: h16, vertical: h12),
//                         child: Column(
//                           children: [
//                             CreatePostUpperSection(),
//                             if (Get.find<CreatePostController>().allMediaList.isNotEmpty) CreatePostMediaSection(),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   // ),
//                   Positioned(
//                     top: 0,
//                     child: SizedBox(
//                       width: width,
//                       child: const CustomDivider(),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 44,
//                     child: SizedBox(
//                       width: width,
//                       child: const CustomDivider(),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     child: CreatePostBottomSection(),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//         // if (createPostController.isCreatePostLoading.value == true)//!Condition for kid create post loading after api call
//         //   Positioned(
//         //     child: CommonLoadingAnimation(
//         //       onWillPop: () async {
//         //         if (createPostController.isCreatePostLoading.value) {
//         //           return false;
//         //         }
//         //         return true;
//         //       },
//         //     ),
//         //   ),
//       ],
//       // ),
//     );
//   }
// }
