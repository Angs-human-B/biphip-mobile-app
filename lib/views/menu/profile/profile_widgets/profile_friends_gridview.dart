import 'package:bip_hip/controllers/menu/menu_section_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class FriendFamilyTab extends StatelessWidget {
  FriendFamilyTab({super.key});
  final MenuSectionController menuController = Get.find<MenuSectionController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: cWhiteColor,
          child: FriendsFamilyGridView(
            header: ksFriends.tr,
            count: menuController.friendList.length.toString(),
            friendList: menuController.friendList,
          ),
        ),
        kH12sizedBox,
        Container(
          color: cWhiteColor,
          child: FriendsFamilyGridView(
            header: ksFamily.tr,
            count: menuController.familyList.length.toString(),
            friendList: menuController.familyList,
          ),
        ),
      ],
    );
  }
}
class FriendsFamilyGridView extends StatelessWidget {
  const FriendsFamilyGridView({super.key, required this.header, required this.count, this.seeAll, required this.friendList});

  final String header;
  final String count;
  final VoidCallback? seeAll;
  final List friendList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        children: [
          kH12sizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                header,
                style: semiBold18TextStyle(cBlackColor),
              ),
              kW8sizedBox,
              Text(
                '$count $header',
                style: regular12TextStyle(cSmallBodyTextColor),
              ),
              const Spacer(),
              CustomTextButton(onPressed: seeAll, text: ksSeeAll.tr, textStyle: semiBold14TextStyle(cPrimaryColor)),
            ],
          ),
          kH12sizedBox,
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: .8,
              crossAxisCount: 3,
              crossAxisSpacing: k10Padding,
              mainAxisSpacing: k4Padding,
            ),
            itemBuilder: (BuildContext context, int index) {
              var item = friendList[index];
              return CustomGridViewContainer(
                item: item,
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomGridViewContainer extends StatelessWidget {
  const CustomGridViewContainer({Key? key, required this.item}) : super(key: key);

  final Map item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: k8CircularBorderRadius,
            child: Image.asset(
              item['image'],
              height: 100,
              width: ((width - 72) / 3),
              filterQuality: FilterQuality.high,
              fit: BoxFit.fill,
            ),
          ),
          kH4sizedBox,
          Text(
            item['name'],
            style: semiBold14TextStyle(cBlackColor),
            overflow: TextOverflow.clip,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}