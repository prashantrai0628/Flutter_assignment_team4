import 'package:flutter/material.dart';
import 'attendance_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.assignment,
      'title': 'Attendance',
      'action': (context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AttendanceScreen()),
        );
      }
    },
    {
      'icon': Icons.help,
      'title': 'FAQ & Help',
      'action': (context) {
        // Example: Add another screen navigation here
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.purple),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/avatar.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "BCIIT ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "bciit@gmail.com",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return ListTile(
                    leading: Icon(item['icon'], color: Colors.black87),
                    title: Text(item['title']),
                    onTap: () {
                      if (item['action'] != null) {
                        item['action']!(context);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text("Main Screen Body"),
      ),
    );
  }
}
