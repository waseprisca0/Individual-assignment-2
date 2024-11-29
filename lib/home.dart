import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'utils/colors.dart';
import 'dart:convert';

class EarthquakeListPage extends StatefulWidget {
  @override
  _EarthquakeListPageState createState() => _EarthquakeListPageState();
}

class _EarthquakeListPageState extends State<EarthquakeListPage> {
  List<dynamic> _earthquakes = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchEarthquakes();
  }

  Future<void> _fetchEarthquakes() async {
    try {
      final response = await http.get(
        Uri.parse('https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&limit=10'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _earthquakes = data['features'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load earthquakes. Status code: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching earthquake data: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Welcome to Quakers!'),
        elevation: 5.0,
        backgroundColor: AppColors.primary,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage, style: TextStyle(color: Colors.red)))
          : ListView.builder(
        itemCount: _earthquakes.length,
        itemBuilder: (context, index) {
          var earthquake = _earthquakes[index];
          var properties = earthquake['properties'];
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 0,
            child: ListTile(
              contentPadding: EdgeInsets.all(15),
              title: Text(
                'Magnitude: ${properties['mag']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Location: ${properties['place']}'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/earthquakeDetail',
                  arguments: earthquake,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
