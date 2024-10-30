import 'package:bip_hip/utils/constants/imports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/const.dart';
import '../../widgets/common/utils/common_shimmer.dart';
import '../../widgets/common/utils/custom_app_bar.dart';

class SettingsShimmerPage extends StatelessWidget {
  const SettingsShimmerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: cGreyBoxColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kAppBarSize),
        //* info:: appBar
        child: CustomAppBar(
          appBarColor: cWhiteColor,
          title: ShimmerCommon(
            widget: Container(decoration: BoxDecoration(color: cWhiteColor, borderRadius: k8CircularBorderRadius), height: h20, width: width * 0.6),
          ),
          hasBackButton: true,
          onBack: () {
            Get.back();
          },
        ),
      ),      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Shimmer.fromColors(
                baseColor: cGreyBoxColor,
                highlightColor: cWhiteColor,
                child: Container(
                  width: 180.w,
                  height: 20.h,
                  color: cGreyBoxColor,
                ),
              ),
              SizedBox(height: 6.h),
              Shimmer.fromColors(
                baseColor: cGreyBoxColor,
                highlightColor: cWhiteColor,
                child: Container(
                  width: double.infinity,
                  height: 15.h,
                  color: cGreyBoxColor,
                ),
              ),
              SizedBox(height: 10.h),
              _buildShimmerMenuItem(),
              SizedBox(height: 12.h),
              _buildShimmerMenuItem(),
              SizedBox(height: 12.h),
              _buildShimmerMenuItem(),
              SizedBox(height: 12.h),
              _buildShimmerMenuItem(),
              SizedBox(height: 22.h),
              Shimmer.fromColors(
                baseColor: cGreyBoxColor,
                highlightColor: cWhiteColor,
                child: Container(
                  width: 180.w,
                  height: 20.h,
                  color: cGreyBoxColor,
                ),
              ),
              SizedBox(height: 6.h),
              Shimmer.fromColors(
                baseColor: cGreyBoxColor,
                highlightColor: cWhiteColor,
                child: Container(
                  width: double.infinity,
                  height: 15.h,
                  color: cGreyBoxColor,
                ),
              ),
              SizedBox(height: 10.h),
              _buildShimmerMenuItem(),
              SizedBox(height: 22.h),
              Shimmer.fromColors(
                baseColor: cGreyBoxColor,
                highlightColor: cWhiteColor,
                child: Container(
                  width: 180.w,
                  height: 20.h,
                  color: cGreyBoxColor,
                ),
              ),
              SizedBox(height: 6.h),
              Shimmer.fromColors(
                baseColor: cGreyBoxColor,
                highlightColor: cWhiteColor,
                child: Container(
                  width: double.infinity,
                  height: 15.h,
                  color: cGreyBoxColor,
                ),
              ),
              SizedBox(height: 10.h),
              _buildShimmerMenuItem(),
              SizedBox(height: 12.h),
              _buildShimmerMenuItem(),
              SizedBox(height: 12.h),
              _buildShimmerMenuItem(),
              // Repeat as needed for additional menu items and sections
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerMenuItem() {
    return Shimmer.fromColors(
      baseColor: cGreyBoxColor,
      highlightColor: cWhiteColor,
      child: Container(
        width: double.infinity,
        height: 70.h,
        color: cGreyBoxColor,
        margin: EdgeInsets.symmetric(vertical: 6.h),
      ),
    );
  }
}
