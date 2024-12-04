import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class LocationTimeline extends StatelessWidget {
  final List<Map<String, dynamic>> locations;

  const LocationTimeline({required this.locations});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];
        return TimelineTile(
          alignment: TimelineAlign.start,
          isFirst: index == 0,
          isLast: index == locations.length - 1,
          indicatorStyle: IndicatorStyle(
            color: Colors.purple,
            width: 20,
          ),
          beforeLineStyle: LineStyle(
            color: Colors.purple,
            thickness: 2,
          ),
          endChild: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location['time'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(location['location']),
                if (location['stopTime'] > 10)
                  Text(
                    "Stop Time: ${location['stopTime']} mins",
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
