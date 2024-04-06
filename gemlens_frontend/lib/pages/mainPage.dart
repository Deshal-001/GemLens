import 'package:flutter/material.dart';
import 'package:gemlens_frontend/pages/aboutPage.dart';
import 'package:gemlens_frontend/pages/gemStoneSearch.dart';
import 'package:gemlens_frontend/pages/helpAndSupportPage.dart';
import 'package:gemlens_frontend/pages/landingPage.dart';
import 'package:gemlens_frontend/pages/menuPage.dart';
import 'package:gemlens_frontend/pages/scanGemStonePage.dart';
import 'package:gemlens_frontend/pages/settingsPage.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    _children.add(MenuPage(onMenuTap: (index) {
      onTabTapped(index);
    }));
    _children.add(ScanImagePage());
    _children.add(GemStoneSearchPage());
        _children.add(HelpAndSupportPage());

    _children.add(AboutPage());
    _children.add(SettingsPage());
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          SalomonBottomBarItem(icon: Icon(Icons.menu), title: Text("Menu")),
          SalomonBottomBarItem(
              icon: Icon(Icons.camera_alt), title: Text("Scan")),
          SalomonBottomBarItem(icon: Icon(Icons.search), title: Text("Search")),

          // Add more items here
        ],
      ),
    );
  }
}
