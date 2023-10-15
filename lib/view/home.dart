import 'package:flutter/material.dart';
import 'package:pbp_2_restaurant/burger_grid.dart';
import 'package:pbp_2_restaurant/login.dart';
import 'package:pbp_2_restaurant/view/homePage.dart';
import 'package:pbp_2_restaurant/model/user.dart';

/// Flutter code sample for [NavigationBar].

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.user});

  final User? user;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color.fromARGB(255, 207, 207, 207),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.explore),
            icon: Icon(Icons.explore_outlined),
            label: 'Explore',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmarks),
            icon: Icon(Icons.bookmarks_outlined),
            label: 'Bookmarks',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        HomePage(logUser: widget.user),
        BurgerGrid(),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text('Logged In as ${widget.user!.username}!'),
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text(
            'Hello ${widget.user!.username}!',
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ][currentPageIndex],
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   static const List<Widget> _widgetOptions = <Widget>[
//     Center(
//       child: Text('Index 0: MainHome'),
//     ),
//     Center(
//       child: Text('Index 1: Explore'),
//     ),
//     Center(
//       child: Text('Index 2: BookMark'),
//     ),
//     Center(
//       child: Text('Index 3: Profile'),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.home,
//             ),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.bookmarks), label: 'Bookmarks'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         backgroundColor: Color.fromARGB(1, 66, 66, 66),
//       ),
//       body: _widgetOptions.elementAt(_selectedIndex),
//     );
//   }
// }
