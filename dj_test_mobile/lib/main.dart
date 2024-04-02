import 'package:dj_test_mobile/belonging.dart';
import 'package:dj_test_mobile/borrowed.dart';
import 'package:dj_test_mobile/friendspage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const BelongingPage(),
    const FriendsPage(),
    const BorrowedPage(),
    const Scaffold()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? SvgPicture.asset('assets/images/bookmark_selected_icon.svg')
                  : SvgPicture.asset('assets/images/bookmark_unselected_icon.svg'),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? SvgPicture.asset('assets/images/bookmark_selected_icon.svg')
                  : SvgPicture.asset(
                      'assets/images/bookmark_unselected_icon.svg'),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? SvgPicture.asset(
                      'assets/images/bookmark_selected_icon.svg')
                  : SvgPicture.asset(
                      'assets/images/bookmark_unselected_icon.svg'),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 3
                  ? SvgPicture.asset('assets/images/bookmark_selected_icon.svg')
                  : SvgPicture.asset(
                      'assets/images/bookmark_unselected_icon.svg'),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

