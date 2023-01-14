import 'package:donation_app_igdtuw/screens/home_screen.dart';
import 'package:donation_app_igdtuw/screens/profileview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'homepagemain.dart';

class navMainPage extends StatefulWidget {
  @override
  _navMainPageState createState() => _navMainPageState();
}

class _navMainPageState extends State<navMainPage>{
  int index = 0;
  final screens = [
    Home(),
    HomeScreen(),
    viewprofile(),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: screens[index],
    bottomNavigationBar: NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: Colors.black,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0), ),
        child: NavigationBar(
          height: 60,
          backgroundColor: Colors.white,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: index,
          animationDuration: Duration(seconds: 1),
          onDestinationSelected: (index) =>
              setState(() => this.index = index),
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_outlined, color: Colors.orange.shade900.withOpacity(0.90)),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.folder_open_outlined),
              selectedIcon: Icon(Icons.folder_open_outlined, color: Colors.orange.shade900.withOpacity(0.90)),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person_outline, color: Colors.orange.shade900.withOpacity(0.90)),
              label: '',
            ),
          ],
        ),
      ),
    ),

    //end
  );

}