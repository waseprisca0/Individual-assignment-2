import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:untitled/onboarding.dart';
import 'home.dart'; // Import the Earthquake List page
import 'details.dart'; // Import the Earthquake Detail page
import 'recovery.dart'; // Import the No Internet page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Earthquake Tracker',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Onboarding(), // Set the home page to EarthquakeListPage
      routes: {
        '/home': (context) => EarthquakeListPage(),
        '/earthquakeDetail': (context) => EarthquakeDetailPage(earthquake: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/noInternet': (context) => NoInternetPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
