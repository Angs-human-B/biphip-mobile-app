import 'package:bip_hip/utils/constants/imports.dart';

class StoriesWidget extends StatelessWidget {
  const StoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: k10Padding),
        child: ListView.builder(
            padding: const EdgeInsets.only(left: k20Padding),
            itemCount: stories.length + 1,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const _StoryCard(
                  isStory: false,
                  storyImage: '',
                  profileImage: 'assets/images/pic5.jpeg',
                  userName: '',
                  isSeen: false,
                );
              } else {
                return _StoryCard(
                  isStory: true,
                  storyImage: stories[index - 1]['storyImage'],
                  profileImage: stories[index - 1]['profileImage'],
                  userName: stories[index - 1]['name'],
                  isSeen: stories[index - 1]['isSeen'],
                );
              }
            }),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard(
      {super.key, required this.isStory, required this.storyImage, required this.profileImage, required this.userName, required this.isSeen, this.onPressed});

  final bool isStory;
  final String storyImage;
  final String profileImage;
  final String userName;
  final bool isSeen;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: k8Padding),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 137,
          width: 90,
          decoration: BoxDecoration(borderRadius: k8CircularBorderRadius, border: Border.all(color: cLineColor)),
          child: Stack(
            children: [
              Container(
                height: 137,
                width: 90,
                color: cTransparentColor,
              ),
              if (isStory)
                SizedBox(
                  height: 137,
                  width: 90,
                  child: ClipRRect(
                    borderRadius: k8CircularBorderRadius,
                    child: Image.asset(
                      storyImage,
                      fit: BoxFit.cover,
                      color: cBlackColor.withOpacity(0.2),
                      colorBlendMode: BlendMode.multiply,
                    ),
                  ),
                ),
              if (isStory)
                Positioned(
                  top: 8,
                  left: 6,
                  child: Container(
                    height: 27,
                    width: 27,
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: isSeen ? cLineColor : cPrimaryColor)),
                    child: ClipOval(
                      child: Image.asset(
                        profileImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              if (!isStory)
                Positioned(
                  top: 0,
                  child: SizedBox(
                    height: 80,
                    width: 90,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(k8BorderRadius),
                        topRight: Radius.circular(k8BorderRadius),
                      ),
                      child: Image.asset(
                        profileImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              if (!isStory)
                Positioned(
                  bottom: 30,
                  left: 28.5,
                  child: Container(
                    height: 33,
                    width: 33,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: cPrimaryColor, border: Border.all(color: cWhiteColor, width: 2)),
                    child: const Icon(
                      BipHip.plus,
                      color: cWhiteColor,
                    ),
                  ),
                ),
              if (!isStory)
                Positioned(
                  left: 32,
                  bottom: 5,
                  child: Text(
                    'Add\nSelfie',
                    textAlign: TextAlign.center,
                    style: semiBold10TextStyle(cBlackColor),
                  ),
                ),
              if (isStory)
                Positioned(
                    bottom: 6,
                    left: 6,
                    child: SizedBox(
                      width: 80,
                      child: Text(
                        userName,
                        overflow: TextOverflow.clip,
                        style: semiBold10TextStyle(cWhiteColor),
                      ),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
