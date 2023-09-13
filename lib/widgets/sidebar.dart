import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const Sidebar(
      {super.key, 
      required this.selectedIndex, 
      required this.onItemTapped}
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 130,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ToDo App",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Manage your daily works",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(
                  Icons.home_filled,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Home',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            selected: selectedIndex == 0,
            onTap: () {
              onItemTapped(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(
                  Icons.checklist_rounded,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'My Todos',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            selected: selectedIndex == 1,
            onTap: () {
              onItemTapped(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(
                  Icons.contact_phone,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Contact Us',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            selected: selectedIndex == 2,
            onTap: () {
              onItemTapped(2);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
