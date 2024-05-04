import 'package:bip_hip/controllers/post/post_reaction_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonGiftViewScreen extends StatelessWidget {
  const CommonGiftViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      child: SafeArea(
        top: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: cWhiteColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kAppBarSize),
            //* info:: appBar
            child: CustomAppBar(
              appBarColor: cWhiteColor,
              title: ksPeopleWhoGifted.tr,
              titleColor: cBlackColor,
              hasBackButton: true,
              isCenterTitle: true,
              onBack: () {
                Get.back();
              },
            ),
          ),
          body: Column(
            children: [BadgeTabViewContent()],
          ),
        ),
      ),
    );
  }
}

class BadgeTabViewContent extends StatelessWidget {
  BadgeTabViewContent({super.key});

  final PostReactionController postReactionController = Get.find<PostReactionController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Obx(
        () => Column(
          children: [
            SizedBox(
              height: 40,
              child: TabBar(
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                controller: postReactionController.tabController,
                isScrollable: true,
                tabs: [
                  ReactionBottomSheetTab(
                    isReactionImageShown: false,
                    reactionImage: '',
                    text: ksAll.tr,
                  ),
                  ReactionBottomSheetTab(
                    isReactionImageShown: true,
                    reactionImage: kiBadge1SvgImageUrl,
                    text: postReactionController.badgeCount1.value.toString(),
                  ),
                  ReactionBottomSheetTab(
                    isReactionImageShown: true,
                    reactionImage: kiBadge2SvgImageUrl,
                    text: postReactionController.badgeCount2.value.toString(),
                  ),
                  ReactionBottomSheetTab(
                    isReactionImageShown: true,
                    reactionImage: kiBadge3SvgImageUrl,
                    text: postReactionController.badgeCount3.value.toString(),
                  ),
                  ReactionBottomSheetTab(
                    isReactionImageShown: true,
                    reactionImage: kiBadge4SvgImageUrl,
                    text: postReactionController.badgeCount4.value.toString(),
                  ),
                  // ReactionBottomSheetTab(
                  //   isReactionImageShown: true,
                  //   reactionImage: kiAngrySvgImageUrl,
                  //   text: postReactionController.badgeCount4.value.toString(),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: (height * 0.9) - 65,
              child: TabBarView(controller: postReactionController.tabController, children: [
                ReactionTabPage(list: postReactionController.gift1),
                ReactionTabPage(list: postReactionController.gift1),
                ReactionTabPage(list: postReactionController.gift1),
                ReactionTabPage(list: postReactionController.gift1),
                ReactionTabPage(list: postReactionController.gift1),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class ReactionBottomSheetTab extends StatelessWidget {
  const ReactionBottomSheetTab({super.key, required this.isReactionImageShown, required this.reactionImage, required this.text});

  final bool isReactionImageShown;
  final String reactionImage;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (width - 30) / 5,
      child: Tab(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isReactionImageShown)
              SvgPicture.asset(
                reactionImage,
                width: 20,
              ),
            if (isReactionImageShown) kW8sizedBox,
            Text(
              text,
              style: isReactionImageShown ? regular12TextStyle(cBlackColor) : semiBold12TextStyle(cBlackColor),
            )
          ],
        ),
      ),
    );
  }
}

class ReactionTabPage extends StatelessWidget {
  const ReactionTabPage({super.key, required this.list});
  final List list;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => kH8sizedBox,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          var item = list[index];
          return Padding(
            padding: const EdgeInsets.only(left: h8, right: h8),
            child: CustomListTile(
              leading: Stack(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: ClipOval(
                      child: Image.asset(item['image']),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: SvgPicture.asset(
                        item['giftImage'],
                        height: 16,
                        width: 16,
                      ))
                ],
              ),
              title: item['name'],
              trailing: item['isFriend']
                  ? Text(
                      ksMessage.tr,
                      style: regular14TextStyle(cPrimaryColor),
                    )
                  : Text(
                      ksAddFriend.tr,
                      style: regular14TextStyle(cPrimaryColor),
                    ),
            ),
          );
        });
  }
}
