import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'utils/colors.dart';

class EarthquakeDetailPage extends StatelessWidget {
  final Map<String, dynamic> earthquake;

  EarthquakeDetailPage({required this.earthquake});

  void _shareToWhatsApp(BuildContext context, String message) async {
    final whatsappUrl = 'whatsapp://send?text=$message';

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('WhatsApp is not installed on your device')),
      );
    }
  }

  void _viewLocationOnMaps(BuildContext context) async {
    var properties = earthquake['properties'];
    var coordinates = earthquake['geometry']['coordinates'];
    double latitude = coordinates[1];
    double longitude = coordinates[0];
    print('$latitude, $longitude');

    final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open Maps')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var properties = earthquake['properties'];

    String formattedTime = DateFormat('yyyy-MM-dd – hh:mm:ss a')
        .format(DateTime.fromMillisecondsSinceEpoch(properties['time']));

    return Scaffold(
      appBar: AppBar(
        title: Text('Earthquake Details'),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Magnitude: ${properties['mag']}',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Location: ${properties['place']}',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Time: $formattedTime',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Details:',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        properties['title'] ?? 'No additional information available.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        String message = 'Earthquake Details:\n'
                            'Magnitude: ${properties['mag']}\n'
                            'Location: ${properties['place']}\n'
                            'Time: $formattedTime\n'
                            'Details: ${properties['title']}';

                        _shareToWhatsApp(context, message);
                      },
                      child: Text(
                        'Share to WhatsApp',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: AppColors.primary,
                      ),
                      onPressed: () {
                        _viewLocationOnMaps(context);
                      },
                      child: Text(
                        'View on Maps',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
