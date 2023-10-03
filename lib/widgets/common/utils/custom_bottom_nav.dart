import 'package:bip_hip/utils/constants/imports.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required bool isFirstButtonClicked,
    required bool isSecondButtonClicked,
    required bool isThirdButtonClicked,
    required bool isFourthButtonClicked,
    required bool isFifthButtonClicked,
    required double width,
  })  : _isFirstButtonClicked = isFirstButtonClicked,
        _isSecondButtonClicked = isSecondButtonClicked,
        _isThirdButtonClicked = isThirdButtonClicked,
        _isFourthButtonClicked = isFourthButtonClicked,
        _isFifthButtonClicked = isFifthButtonClicked,
        _width = width,
        super(key: key);

  final bool _isFirstButtonClicked;
  final bool _isSecondButtonClicked;
  final bool _isThirdButtonClicked;
  final bool _isFourthButtonClicked;
  final bool _isFifthButtonClicked;
  final double _width;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhiteColor,
      height: kBottomNavHeight,
      child: Column(
        children: [
          const Divider(
            height: .5,
            thickness: .5,
            color: cLineColor,
          ),
          Row(
            children: [
              //* home
              _BottomNavbarItem(
                width: _width,
                isClicked: _isFirstButtonClicked,
                title: "Home",
                icon: BipHip.homeOutline,
                iconSelected: BipHip.homeFill,
                onPressed: () async {
                  Get.toNamed(krHome);
                },
              ),

              //* Request
              _BottomNavbarItem(
                width: _width,
                isClicked: _isSecondButtonClicked,
                title: "Friends",
                icon: BipHip.friendsOutline,
                iconSelected: BipHip.friendsFill,
                onPressed: () async {
                  Get.toNamed(krFriends);
                },
              ),

              //* create request
              _BottomNavbarItem(
                width: _width,
                isClicked: _isThirdButtonClicked,
                title: "Badges",
                icon: BipHip.badgesOutline,
                iconSelected: BipHip.badgesFill,
                onPressed: () {},
              ),

              //* notification
              _BottomNavbarItem(
                width: _width,
                isClicked: _isFourthButtonClicked,
                title: "Notification",
                icon: BipHip.notificationOutline,
                iconSelected: BipHip.notificationFill,
                onPressed: () async {},
              ),

              //* more
              _BottomNavbarItem(
                width: _width,
                isClicked: _isFifthButtonClicked,
                title: "Menu",
                icon: BipHip.menuOutline,
                iconSelected: BipHip.menuFill,
                onPressed: () {
                  Get.offAllNamed(krMenu);
                },
              ),

              //* end
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomNavbarItem extends StatelessWidget {
  const _BottomNavbarItem({
    Key? key,
    required this.width,
    required this.isClicked,
    required this.title,
    required this.icon,
    required this.iconSelected,
    required this.onPressed,
  }) : super(key: key);

  final double width;
  final bool isClicked;
  final String title;
  final IconData icon;
  final IconData iconSelected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBottomNavHeight - .5,
      width: width * .20,
      child: TextButton(
        style: kTextButtonStyle,
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isClicked
                ? Icon(
                    iconSelected,
                    size: isDeviceScreenLarge() ? 20 : 16,
                    color: cPrimaryColor,
                  )
                : Stack(
                    children: [
                      Icon(
                        icon,
                        size: isDeviceScreenLarge() ? 20 : 16,
                        color: cIconColor,
                      ),
                      Visibility(
                        visible: false,
                        child: Positioned(
                          right: 2,
                          top: 0,
                          child: Container(
                            height: 6,
                            width: 6,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: cPrimaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: regular10TextStyle(isClicked ? cPrimaryColor : cIconColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
