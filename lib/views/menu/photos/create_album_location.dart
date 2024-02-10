import 'package:bip_hip/controllers/menu/gallery_controller.dart';
import 'package:bip_hip/utils/constants/imports.dart';

class CreateAlbumLocation extends StatelessWidget {
  CreateAlbumLocation({super.key});
  final GalleryController galleryController = Get.find<GalleryController>();
  final FocusNode createAlbumLocationFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        galleryController.locationTextEditingController.clear();
        galleryController.isAddLocationSuffixIconVisible.value = false;
        galleryController.isLocationSaveEnable.value = false;
        Get.back();
        return true;
      },
      child: Container(
        color: cWhiteColor,
        child: SafeArea(
          top: false,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kAppBarSize),
              //* info:: appBar
              child: CustomAppBar(
                appBarColor: cWhiteColor,
                title: ksAddLocation.tr,
                hasBackButton: true,
                isCenterTitle: true,
                onBack: () {
                  galleryController.locationTextEditingController.clear();
                  Get.back();
                  galleryController.isAddLocationSuffixIconVisible.value = false;
                  galleryController.isLocationSaveEnable.value = false;
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: Column(
                children: [
                  kH16sizedBox,
                  RawAutocomplete(
                    textEditingController: galleryController.locationTextEditingController,
                    focusNode: createAlbumLocationFocusNode,
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      return galleryController.locationList.where((word) => word.toLowerCase().startsWith(textEditingValue.text.toLowerCase()));
                    },
                    onSelected: (option) {
                      galleryController.locationTextEditingController.text = option;
                    },
                    optionsViewBuilder: (context, Function(String) onSelected, options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: width - 40,
                          child: Material(
                            elevation: 4,
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final option = options.elementAt(index);
                                return CustomListTile(
                                  title: Text(
                                    option.toString(),
                                    style: medium16TextStyle(cBlackColor),
                                  ),
                                  onPressed: () {
                                    onSelected(option.toString());
                                    galleryController.locationTextEditingController.text = option.toString();
                                    galleryController.checkCanSaveLocation();
                                    galleryController.isAddLocationSuffixIconVisible.value = true;
                                    unfocus(context);
                                  },
                                );
                              },
                              separatorBuilder: (context, index) => Container(
                                height: 1,
                                color: cLineColor,
                              ),
                              itemCount: options.length,
                            ),
                          ),
                        ),
                      );
                    },
                    fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                      return Obx(
                        () => CustomModifiedTextField(
                          focusNode: focusNode,
                          controller: galleryController.locationTextEditingController,
                          prefixIcon: BipHip.location,
                          hint: ksAddLocation.tr,
                          suffixIcon: galleryController.isAddLocationSuffixIconVisible.value ? BipHip.circleCrossNew : null,
                          onSuffixPress: () {
                            galleryController.isAddLocationSuffixIconVisible.value = false;
                            galleryController.locationTextEditingController.clear();
                            galleryController.checkCanSaveLocation();
                          },
                          onChanged: (text) {
                            galleryController.checkCanSaveLocation();
                            if (galleryController.locationTextEditingController.text.trim() != '') {
                              galleryController.isAddLocationSuffixIconVisible.value = true;
                            } else {
                              galleryController.isAddLocationSuffixIconVisible.value = false;
                            }
                          },
                          onSubmit: (text) {
                            galleryController.isAddLocationSuffixIconVisible.value = true;
                          },
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.text,
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  Obx(() => CustomElevatedButton(
                      buttonWidth: width - 40,
                      label: ksSave.tr,
                      onPressed: galleryController.isLocationSaveEnable.value
                          ? () {
                              Get.back();
                            }
                          : null)),
                  kH20sizedBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
