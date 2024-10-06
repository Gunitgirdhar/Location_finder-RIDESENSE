import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'Second_Page_Map.dart';

class LocationInputPage extends StatefulWidget {
  @override
  _LocationInputPageState createState() => _LocationInputPageState();
}

class _LocationInputPageState extends State<LocationInputPage> {
  String selectedOption = 'Location';
  final _locationController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();
  late double latitude, longitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Location or Coordinates')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedOption,
              items: ['Location', 'Coordinates'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedOption = newValue!;
                });
              },
            ),
            if (selectedOption == 'Location')
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Enter your location',
                  border:
                      OutlineInputBorder(), // Add border around the TextField
                  //errorText: _locationController.text.isEmpty ? 'Location cannot be empty' : null,
                ),
              ),
            if (selectedOption == 'Coordinates') ...[
              TextField(
                controller: _latController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Latitude',
                  border:
                      OutlineInputBorder(), // Add border around the TextField
                  // errorText: _latController.text.isEmpty ? 'Latitude cannot be empty' : null,
                ),
              ),
              Container(
                height: 25,
              ),
              TextField(
                controller: _lngController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Longitude',
                  border:
                      OutlineInputBorder(), // Add border around the TextField
                  //    errorText: _lngController.text.isEmpty ? 'Longitude cannot be empty' : null,
                ),
              ),
              Container(
                height: 25,
              ),
            ],
            ElevatedButton(
              onPressed: () async {
                // Check if fields are empty
                if (selectedOption == 'Location' &&
                    _locationController.text.isEmpty) {
                  _showAlertDialog('Please enter a location.');
                  return;
                } else if (selectedOption == 'Coordinates') {
                  if (_latController.text.isEmpty ||
                      _lngController.text.isEmpty) {
                    _showAlertDialog(
                        'Please enter both latitude and longitude.');
                    return;
                  }

                  // Validate latitude and longitude input
                  try {
                    latitude = double.parse(_latController.text);
                    longitude = double.parse(_lngController.text);
                    if (latitude < -90 ||
                        latitude > 90 ||
                        longitude < -180 ||
                        longitude > 180) {
                      _showAlertDialog(
                          'Please enter valid latitude and longitude values.');
                      return;
                    }
                  } catch (e) {
                    _showAlertDialog(
                        'Please enter valid numeric values for latitude and longitude.');
                    return;
                  }
                }

                // Fetch location based on the selected option
                if (selectedOption == 'Location') {
                  try {
                    List<Location> locations =
                        await locationFromAddress(_locationController.text);
                    latitude = locations[0].latitude;
                    longitude = locations[0].longitude;
                  } catch (e) {
                    _showAlertDialog(
                        'Location not found. Please enter a valid location.');
                    return;
                  }
                }

                // Navigate to the map page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapDisplayPage(
                        latitude: latitude, longitude: longitude),
                  ),
                );
              },
              child: Text('Go to Map'),
            ),
            SizedBox(height: 20), // Spacing between buttons
            ElevatedButton(
              onPressed: () async {
                Position position = await _determinePosition();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapDisplayPage(
                      latitude: position.latitude,
                      longitude: position.longitude,
                    ),
                  ),
                );
              },
              child: Text('Get Current Location'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to fetch current location
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check permission and request if necessary
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location permissions are permanently denied.');
      }

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    // Get the current position if permission is granted
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // Function to show an alert dialog
  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
