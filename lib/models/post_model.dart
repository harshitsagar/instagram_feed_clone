import 'package:instagram_feed_clone/models/user_model.dart';

class Post {
  final String id;
  final User user;
  final List<String> imageUrls;
  final String caption;
  final int likes;
  final DateTime timestamp;
  bool isLiked;
  bool isSaved;

  Post({
    required this.id,
    required this.user,
    required this.imageUrls,
    required this.caption,
    required this.likes,
    required this.timestamp,
    this.isLiked = false,
    this.isSaved = false,
  });

  // For pagination simulation
  factory Post.fromJson(Map<String, dynamic> json, int index) {
    return Post(
      id: 'post_$index',
      user: User(
        id: 'user_${index % 5}',
        username: ['john_doe', 'jane_smith', 'travel_gram', 'food_lover', 'tech_guru'][index % 5],
        profileImageUrl: 'https://picsum.photos/seed/${index % 5}/200/200',
      ),
      imageUrls: List.generate(
        (index % 3) + 1, // 1-3 images per post
            (imgIndex) => 'https://picsum.photos/seed/post_${index}_$imgIndex/400/400',
      ),
      caption: 'This is a sample caption for post $index. #flutter #instagram',
      likes: 100 + (index * 23) % 900,
      timestamp: DateTime.now().subtract(Duration(hours: index)),
    );
  }
}