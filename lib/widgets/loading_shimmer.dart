import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class PostShimmer extends StatelessWidget {
  const PostShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                CircleAvatar(radius: 20.r, backgroundColor: Colors.white),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 100.w, height: 12.h, color: Colors.white),
                    SizedBox(height: 4.h),
                    Container(width: 60.w, height: 10.h, color: Colors.white),
                  ],
                ),
              ],
            ),
          ),
          // Image placeholder
          Container(height: 300.h, color: Colors.white),
          // Actions
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                Container(width: 24.w, height: 24.w, color: Colors.white),
                SizedBox(width: 16.w),
                Container(width: 24.w, height: 24.w, color: Colors.white),
                SizedBox(width: 16.w),
                Container(width: 24.w, height: 24.w, color: Colors.white),
                Spacer(),
                Container(width: 24.w, height: 24.w, color: Colors.white),
              ],
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}