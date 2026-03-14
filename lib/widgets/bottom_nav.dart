import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_feed_clone/screens/home_screen.dart';
import 'package:instagram_feed_clone/screens/other_screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const ReelsScreen(),
    const ActivityScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 24.w),
            activeIcon: Icon(Icons.home, size: 24.w),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined, size: 24.w),
            activeIcon: Icon(Icons.search, size: 24.w),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_outlined, size: 24.w),
            activeIcon: Icon(Icons.movie, size: 24.w),
            label: 'Reels',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border, size: 24.w),
            activeIcon: Icon(Icons.favorite, size: 24.w),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 24.w),
            activeIcon: Icon(Icons.person, size: 24.w),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}