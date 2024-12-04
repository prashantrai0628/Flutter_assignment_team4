import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../widgets/location_timeline.dart';

class LocationScreen extends StatefulWidget {
  final String memberId;
  final String memberName;

  const LocationScreen({required this.memberId, required this.memberName});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late GoogleMapController _mapController;
  DateTime _selectedDate = DateTime.now();

  final List<Map<String, dynamic>> _visitedLocations = [
    {
      "time": "10:00 AM",
      "location": "Park Avenue, NY",
      "stopTime": 12,
    },
    {
      "time": "12:30 PM",
      "location": "5th Avenue, NY",
      "stopTime": 8,
    },
    {
      "time": "3:00 PM",
      "location": "Madison Square, NY",
      "stopTime": 15,
    },
  ];

  void _onDateChanged(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location - ${widget.memberName}"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(40.7128, -74.0060),
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("currentLocation"),
                  position: LatLng(40.7128, -74.0060),
                  infoWindow: InfoWindow(title: "Current Location"),
                ),
              },
              polylines: {
                Polyline(
                  polylineId: PolylineId("route"),
                  color: Colors.blue,
                  width: 5,
                  points: [
                    LatLng(40.7128, -74.0060),
                    LatLng(40.7150, -74.0020),
                    LatLng(40.7200, -74.0000),
                  ],
                ),
              },
              onMapCreated: (controller) {
                _mapController = controller;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date: ${DateFormat('dd MMM yyyy').format(_selectedDate)}"),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      _onDateChanged(pickedDate);
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: LocationTimeline(locations: _visitedLocations),
          ),
        ],
      ),
    );
  }
}
