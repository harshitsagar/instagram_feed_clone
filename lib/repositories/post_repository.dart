import 'dart:async';
import 'package:instagram_feed_clone/models/story_model.dart';
import 'package:instagram_feed_clone/models/user_model.dart';

import '../models/post_model.dart';

class PostRepository {
  static const int _pageSize = 10;
  static const Duration _simulatedDelay = Duration(milliseconds: 1500);

  Future<List<Post>> fetchPosts({required int pageKey}) async {
    // Simulate network delay
    await Future.delayed(_simulatedDelay);

    // Simulate pagination with 50 total posts
    final startIndex = pageKey * _pageSize;
    if (startIndex >= 50) {
      return []; // No more posts
    }

    final endIndex = (startIndex + _pageSize).clamp(0, 50);
    return List.generate(
      endIndex - startIndex,
          (index) => Post.fromJson({}, startIndex + index),
    );
  }

  List<Story> getStories() {
    return List.generate(
      12,
          (index) => Story(
        user: User(
          id: 'story_$index',
          username: ['your_story', 'john_doe', 'jane_smith', 'travel_gram', 'food_lover', 'tech_guru', 'nature_lover', 'fitness_freak', 'art_daily', 'music_lover', 'book_worm', 'pet_lover'][index],
          profileImageUrl: 'https://picsum.photos/seed/story_$index/200/200',
        ),
        hasUnseenStory: index % 3 != 0,
        storyImageUrl: 'https://picsum.photos/seed/story_img_$index/400/800',
      ),
    );
  }
}