import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('No Internet'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.signal_wifi_off, color: Colors.red, size: 100),
            SizedBox(height: 20),
            Text(
              'No Internet Connection',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Optionally, try to reload the data or navigate to the home screen
                Navigator.pop(context);
              },
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
