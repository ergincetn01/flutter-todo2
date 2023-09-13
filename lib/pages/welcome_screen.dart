import 'package:flutter/material.dart';
import 'package:todo2/widgets/sidebar.dart';
// import 'package:todoapp/screens/contact_us.dart';
// import 'package:todoapp/screens/display_todos.dart';
// import 'package:todoapp/screens/home_Page.dart';
// import 'package:todoapp/screens/sidebar.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key, required this.title});

  final String title;

  @override
  State<WelcomeScreen> createState() => MainPageState();
}

class MainPageState extends State<WelcomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    // HomePage(),
    // TodoListPage(),
    // ContactUs()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Sidebar(selectedIndex: 
      _selectedIndex, onItemTapped: _onItemTapped
      ),
    );
  }
}
