import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/navigation_viewmodel.dart';

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  int pageSelectedIndex = 0;

  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationViewModel>(builder: (_, viewModel, __) {
      return Scaffold(
        body: PageView(
          children: viewModel.pages,
          controller: pageController,
          onPageChanged: (i) {
            setState(() {
              pageSelectedIndex = i;
            });
          },
          physics: const NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.live_tv_outlined),
              activeIcon: Icon(Icons.live_tv_sharp),
              label: 'Anime',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              activeIcon: Icon(Icons.book_sharp),
              label: 'Manga',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.download_outlined),
              activeIcon: Icon(Icons.download_sharp),
              label: 'Downloads',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.app_settings_alt_outlined),
              activeIcon: Icon(Icons.app_settings_alt_sharp),
              label: 'Settings',
            ),
          ],
          currentIndex: pageSelectedIndex,
          onTap: (int i) {
            setState(() {
              pageSelectedIndex = i;
            });
            pageController.animateToPage(i,
                duration: const Duration(milliseconds: 1),
                curve: Curves.linearToEaseOut);
          },
        ),
      );
    });
  }
}
