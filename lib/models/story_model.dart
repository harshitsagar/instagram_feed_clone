import 'package:instagram_feed_clone/models/user_model.dart';

class Story {
  final User user;
  final bool hasUnseenStory;
  final String storyImageUrl;

  Story({
    required this.user,
    required this.hasUnseenStory,
    required this.storyImageUrl,
  });
}