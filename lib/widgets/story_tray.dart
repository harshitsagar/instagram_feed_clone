import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/story_model.dart';

class StoryTray extends StatelessWidget {
  final List<Story> stories;

  const StoryTray({Key? key, required this.stories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return Container(
            width: 68.w,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: story.hasUnseenStory
                            ? const LinearGradient(
                          colors: [Color(0xFFFCAF45), Color(0xFFE1306C)],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        )
                            : null,
                      ),
                      padding: story.hasUnseenStory ? EdgeInsets.all(2.r) : EdgeInsets.zero,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2.w,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 28.r,
                          backgroundImage: NetworkImage(story.user.profileImageUrl),
                        ),
                      ),
                    ),
                    if (index == 0)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 18.w,
                          height: 18.w,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2.w),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 12.w,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  story.user.username,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11.sp),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}