import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/responsivnes/base_layout_screen_scaffold.dart';

class MobileLayoutScreenScaffold extends BaseLayoutScreenScaffold {
  const MobileLayoutScreenScaffold({
    super.key,
    required super.child,
  });

  @override
  _MobileLayoutScreenScaffoldState createState() =>
      _MobileLayoutScreenScaffoldState();
}

class _MobileLayoutScreenScaffoldState extends BaseLayoutScreenScaffoldState {
  int _tabBarIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      _tabBarIndex = index;
    });
  }

  void navigateToPage(int index) {
    _pageController.jumpToPage(index);
    // _pageController.animateToPage(
    //   index,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.ease,
    // );
  }

  @override
  Widget build(BuildContext context) {
    // model.User? user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        centerTitle: false,
        title: Text(
          'For you',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          CupertinoButton(
            onPressed: () {},
            child: const Icon(CupertinoIcons.heart),
          ),
          CupertinoButton(
            onPressed: () {},
            child: const Icon(CupertinoIcons.paperplane),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onTabTapped,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          widget.child,
          const Center(child: Text('Search')),
          const Center(child: Text('Add')),
          const Center(child: Text('Reels')),
          const Center(child: Text('Profile')),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        activeColor: Theme.of(context).colorScheme.primary,
        inactiveColor: Theme.of(context).colorScheme.primary,
        onTap: navigateToPage,
        border: const Border(),
        currentIndex: _tabBarIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            activeIcon: Icon(CupertinoIcons.house_fill),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            activeIcon: Icon(CupertinoIcons.search),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.plus_app),
            activeIcon: Icon(CupertinoIcons.plus_app_fill),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.film),
            activeIcon: Icon(CupertinoIcons.film_fill),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_crop_circle),
            activeIcon: Icon(CupertinoIcons.person_crop_circle_fill),
          ),
        ],
      ),
    );
  }
}
