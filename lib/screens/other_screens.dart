import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Search', style: TextStyle(color: Colors.black, fontSize: 20.sp)),
      ),
      body: Center(
        child: Text(
          'Search Screen',
          style: TextStyle(fontSize: 18.sp, color: Colors.grey),
        ),
      ),
    );
  }
}

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Reels', style: TextStyle(color: Colors.black, fontSize: 20.sp)),
      ),
      body: Center(
        child: Text(
          'Reels Screen',
          style: TextStyle(fontSize: 18.sp, color: Colors.grey),
        ),
      ),
    );
  }
}

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Activity', style: TextStyle(color: Colors.black, fontSize: 20.sp)),
      ),
      body: Center(
        child: Text(
          'Activity Screen',
          style: TextStyle(fontSize: 18.sp, color: Colors.grey),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Profile', style: TextStyle(color: Colors.black, fontSize: 20.sp)),
      ),
      body: Center(
        child: Text(
          'Profile Screen',
          style: TextStyle(fontSize: 18.sp, color: Colors.grey),
        ),
      ),
    );
  }
}