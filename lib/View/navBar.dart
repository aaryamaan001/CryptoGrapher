import 'package:crypto/View/Components/secondPage.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});
  @override
  State<StatefulWidget> createState() {
    return _NavBarState();
  }
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  List<Widget> pages = [
    Home(),
    SecondPage(),
    Home(),
    Home(),
  ];
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: pages.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          // selectedItemColor: Color.fromARGB(255, 242, 179, 6),
          // unselectedItemColor: Colors.grey,

          //click kr rhe jab image ko to move kr rha h
          type: BottomNavigationBarType.fixed,

          //used to chage image onclick in the image taaki selected dikhe
          onTap: ((value) {
            setState(() {
              _currentIndex = value;
            });
          }),
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/1.1.png',
                  height: myHeight * 0.04,
                  color: const Color.fromARGB(255, 37, 36, 36),
                ),
                label: '',
                activeIcon: Image.asset(
                  'assets/icons/1.2.png',
                  height: myHeight * 0.04,
                  color: const Color.fromARGB(255, 242, 179, 6),
                )),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/2.1.png',
                  height: myHeight * 0.04,
                  color: const Color.fromARGB(255, 37, 36, 36),
                ),
                label: '',
                activeIcon: Image.asset(
                  'assets/icons/2.2.png',
                  height: myHeight * 0.04,
                  color: const Color.fromARGB(255, 242, 179, 6),
                )),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/3.1.png',
                  height: myHeight * 0.04,
                  color: const Color.fromARGB(255, 37, 36, 36),
                ),
                label: '',
                activeIcon: Image.asset(
                  'assets/icons/3.2.png',
                  height: myHeight * 0.04,
                  color: const Color.fromARGB(255, 242, 179, 6),
                )),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/icons/4.1.png',
                  height: myHeight * 0.04,
                  color: const Color.fromARGB(255, 37, 36, 36),
                ),
                label: '',
                activeIcon: Image.asset(
                  'assets/icons/4.2.png',
                  height: myHeight * 0.04,
                  color: const Color.fromARGB(255, 242, 179, 6),
                )),
          ]),
    ));
  }
}
