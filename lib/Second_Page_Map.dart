import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDisplayPage extends StatefulWidget {
  final double latitude;
  final double longitude;

  MapDisplayPage({required this.latitude, required this.longitude});

  @override
  _MapDisplayPageState createState() => _MapDisplayPageState();
}

class _MapDisplayPageState extends State<MapDisplayPage> {
  MapType _currentMapType = MapType.normal; // Default to normal map type

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Location on Map')),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.latitude, widget.longitude),
              zoom: 14,
            ),
            mapType: _currentMapType, // Set mapType based on user selection
            markers: {
              Marker(
                markerId: MarkerId('selectedLocation'),
                position: LatLng(widget.latitude, widget.longitude),
                infoWindow: InfoWindow(title: 'Selected Location'),
              ),
            },
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {}, // No action, we just use the popup menu
              child: PopupMenuButton<String>(
                icon: Icon(Icons.map),
                onSelected: (String value) {
                  setState(() {
                    if (value == 'Satellite') {
                      _currentMapType = MapType.satellite;
                    } else if (value == 'Terrain') {
                      _currentMapType = MapType.terrain;
                    } else if (value == 'Normal') {
                      _currentMapType = MapType.normal;
                    } else if (value == 'Hybrid') {
                      _currentMapType = MapType.hybrid;
                    }
                  });
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Normal',
                    child: Text('Normal View'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Satellite',
                    child: Text('Satellite View'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Terrain',
                    child: Text('Terrain View'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Hybrid',
                    child: Text('Hybrid View'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
