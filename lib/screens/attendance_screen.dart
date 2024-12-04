import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final List<Map<String, String>> members = [
    {
      'name': 'Wade Warren',
      'status': 'Working',
      'loginTime': '09:30 am',
      'logoutTime': '06:40 pm',
      'photo': 'lib/screens/photos/photo1.jpg', 
    },
    {
      'name': 'Esther Howard',
      'status': 'Logged Out',
      'loginTime': '09:30 am',
      'logoutTime': '06:40 pm',
      'photo': 'lib/screens/photos/photo2.jpg', // No photo, will show initials
    },
    {
      'name': 'Cameron Williamson',
      'status': 'Not Logged In',
     'loginTime': '10:30 am',
      'logoutTime': '07:40 pm',
      'photo': 'lib/screens/photos/photo3.jpg',
    },
    {
      'name': 'Brooklyn Simmons',
      'status': 'Logged Out',
      'loginTime': '09:30 am',
      'logoutTime': '06:40 pm',
      'photo': 'lib/screens/photos/photo4.jpg',
    },
  ];

  DateTime selectedDate = DateTime.now();

  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('ATTENDANCE', style: TextStyle(fontSize: 20)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header with dropdown and date picker
          Container(
            color: Colors.purple,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.group, color: Colors.white),
                    const SizedBox(width: 8),
                    const Text('All Members', style: TextStyle(color: Colors.white, fontSize: 16)),
                    const Icon(Icons.arrow_drop_down, color: Colors.white),
                  ],
                ),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Row(
                    children: [
                      Text(
                        DateFormat('EEE, MMM dd yyyy').format(selectedDate),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.calendar_today, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  margin: const EdgeInsets.only(bottom: 8),
                  color: Colors.white,
                  child: Row(
                    children: [
                      // Display photo or initials
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: member['photo']!.isNotEmpty
                            ? NetworkImage(member['photo']!) // Use photo URL
                            : null,
                        backgroundColor: Colors.grey[300],
                        child: member['photo']!.isEmpty
                            ? Text(
                                member['name']![0],
                                style: const TextStyle(fontSize: 20, color: Colors.white),
                              )
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              member['name']!,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Row(
                              children: [
                                Icon(Icons.arrow_upward, size: 16, color: Colors.green),
                                const SizedBox(width: 4),
                                Text(member['loginTime'] ?? '',
                                    style: const TextStyle(fontSize: 14, color: Colors.black54)),
                                if (member['logoutTime']!.isNotEmpty) ...[
                                  const SizedBox(width: 16),
                                  Icon(Icons.arrow_downward, size: 16, color: Colors.red),
                                  const SizedBox(width: 4),
                                  Text(member['logoutTime'] ?? '',
                                      style: const TextStyle(fontSize: 14, color: Colors.black54)),
                                ]
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.location_on, color: Colors.purple),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
