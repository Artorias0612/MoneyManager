import 'package:flutter/material.dart';
import 'package:money_manager_app/screens/home_screen.dart';
import 'package:money_manager_app/screens/info_screen.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currenttIndex = 0;
  Widget bodyWidget = const HomeScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        inactiveColor: Colors.black54,
        icons: const [
          Icons.home,
          Icons.info
        ],
        activeIndex: currenttIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        onTap: (index) {
          if (index == 0){
            bodyWidget = const HomeScreen();
          }
          else {
            bodyWidget = const InfoScreen();
          }
          setState(() {
            currenttIndex = index;
          });
        },
      ),
      body: bodyWidget,
    );
  }
}