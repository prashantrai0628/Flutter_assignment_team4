import 'package:flutter/material.dart';

class AttendanceListItem extends StatelessWidget {
  final String name;
  final String id;
  final String checkInTime;
  final String checkOutTime;
  final bool isLoggedIn;
  final VoidCallback onViewLocation;

  AttendanceListItem({
    required this.name,
    required this.id,
    required this.checkInTime,
    required this.checkOutTime,
    this.isLoggedIn = true,
    required this.onViewLocation,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.person, color: Colors.white),
        backgroundColor: Colors.purple,
      ),
      title: Text("$name ($id)"),
      subtitle: isLoggedIn
          ? Text("$checkInTime - $checkOutTime")
          : Text("NOT LOGGED-IN YET", style: TextStyle(color: Colors.red)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: onViewLocation,
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              // Handle other details here
            },
          ),
        ],
      ),
    );
  }
}
