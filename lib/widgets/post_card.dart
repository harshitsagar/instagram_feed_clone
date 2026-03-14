import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../models/post_model.dart';
import 'pinch_zoom_image.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final Function(bool) onLikeChanged;
  final Function(bool) onSaveChanged;
  final VoidCallback onShare;
  final VoidCallback onComment;

  const PostCard({
    Key? key,
    required this.post,
    required this.onLikeChanged,
    required this.onSaveChanged,
    required this.onShare,
    required this.onComment,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late bool isLiked;
  late bool isSaved;
  int _currentImageIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.post.isLiked;
    isSaved = widget.post.isSaved;
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: CachedNetworkImageProvider(widget.post.user.profileImageUrl),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.user.username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      'Suggested',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.more_horiz, size: 20.w),
            ],
          ),
        ),

        // Image Carousel with Pinch to Zoom
        if (widget.post.imageUrls.length > 1)
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: 300.h,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) => setState(() => _currentImageIndex = index),
                  itemCount: widget.post.imageUrls.length,
                  itemBuilder: (context, index) {
                    return PinchZoomImage(
                      imageUrl: widget.post.imageUrls[index],
                      child: CachedNetworkImage(
                        imageUrl: widget.post.imageUrls[index],
                        height: 300.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(color: Colors.grey[300]),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: Center(child: Icon(Icons.error, color: Colors.red)),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 8.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.post.imageUrls.length,
                        (index) => Container(
                      width: 6.w,
                      height: 6.w,
                      margin: EdgeInsets.symmetric(horizontal: 2.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentImageIndex == index ? Colors.blue : Colors.grey[400],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        else
          SizedBox(
            height: 300.h,
            child: PinchZoomImage(
              imageUrl: widget.post.imageUrls.first,
              child: CachedNetworkImage(
                imageUrl: widget.post.imageUrls.first,
                height: 300.h,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: Colors.grey[300]),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: Center(child: Icon(Icons.error, color: Colors.red)),
                ),
              ),
            ),
          ),

        // Actions
        Padding(
          padding: EdgeInsets.all(8.w),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isLiked = !isLiked;
                    widget.onLikeChanged(isLiked);
                  });
                },
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.black,
                  size: 24.w,
                ),
              ),
              IconButton(
                onPressed: () {
                  _showSnackbar('Comments feature coming soon!');
                  widget.onComment();
                },
                icon: Icon(Icons.comment_outlined, size: 22.w),
              ),
              IconButton(
                onPressed: () {
                  _showSnackbar('Share feature coming soon!');
                  widget.onShare();
                },
                icon: Icon(Icons.send_outlined, size: 22.w),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    isSaved = !isSaved;
                    widget.onSaveChanged(isSaved);
                  });
                },
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                  size: 22.w,
                ),
              ),
            ],
          ),
        ),

        // Likes
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            '${NumberFormat.compact().format(widget.post.likes + (isLiked ? 1 : 0))} likes',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
            ),
          ),
        ),

        // Caption
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 13.sp),
              children: [
                TextSpan(
                  text: widget.post.user.username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: ' ${widget.post.caption}'),
              ],
            ),
          ),
        ),

        // Time
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          child: Text(
            DateFormat.yMMMd().add_jm().format(widget.post.timestamp),
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.grey[600],
            ),
          ),
        ),

        SizedBox(height: 8.h),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}