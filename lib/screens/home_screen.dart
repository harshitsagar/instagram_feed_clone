import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../repositories/post_repository.dart';
import '../models/post_model.dart';
import '../models/story_model.dart';
import '../widgets/story_tray.dart';
import '../widgets/post_card.dart';
import '../widgets/loading_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostRepository _repository = PostRepository();
  final ScrollController _scrollController = ScrollController();

  List<Post> _posts = [];
  List<Story> _stories = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 0;
  bool _isInitialLoading = true;

  @override
  void initState() {
    super.initState();
    _stories = _repository.getStories();
    _loadInitialPosts();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadInitialPosts() async {
    setState(() {
      _isInitialLoading = true;
    });

    try {
      final posts = await _repository.fetchPosts(pageKey: 0);
      setState(() {
        _posts = posts;
        _currentPage = 1;
        _hasMore = posts.length == 10;
        _isInitialLoading = false;
      });
    } catch (e) {
      setState(() {
        _isInitialLoading = false;
      });
      _showErrorSnackbar('Failed to load posts');
    }
  }

  Future<void> _loadMorePosts() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final newPosts = await _repository.fetchPosts(pageKey: _currentPage);
      setState(() {
        if (newPosts.isEmpty) {
          _hasMore = false;
        } else {
          _posts.addAll(newPosts);
          _currentPage++;
          _hasMore = newPosts.length == 10;
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackbar('Failed to load more posts');
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 500) {
      _loadMorePosts();
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/instagram_logo.png',
          height: 100.h,
          width: 100.w,
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border, size: 22.w, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.chat_bubble_outline, size: 22.w, color: Colors.black),
          ),
        ],
      ),
      body: _isInitialLoading
          ? ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => const PostShimmer(),
      )
          : RefreshIndicator(
        onRefresh: _loadInitialPosts,
        color: Colors.black,
        child: AnimationLimiter(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _posts.length + 2, // +1 for stories, +1 for loading indicator
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  height: 100.h,
                  margin: EdgeInsets.only(bottom: 8.h),
                  child: StoryTray(stories: _stories),
                );
              }

              if (index == _posts.length + 1) {
                if (_isLoading) {
                  return const PostShimmer();
                } else if (!_hasMore) {
                  return Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Center(
                      child: Text(
                        'No more posts',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }

              final postIndex = index - 1;
              final post = _posts[postIndex];

              return AnimationConfiguration.staggeredList(
                position: postIndex,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: PostCard(
                      post: post,
                      onLikeChanged: (liked) {
                        setState(() {
                          post.isLiked = liked;
                        });
                      },
                      onSaveChanged: (saved) {
                        setState(() {
                          post.isSaved = saved;
                        });
                      },
                      onShare: () {},
                      onComment: () {},
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}