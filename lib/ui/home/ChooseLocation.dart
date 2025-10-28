import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  GoogleMapController? mapController;
  LatLng? selectedLatLng;
  String? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose Event Location")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(30.033333, 31.233334), // Cairo
              zoom: 10,
            ),
            onTap: (latLng) async {
              setState(() {
                selectedLatLng = latLng;
              });

              List<Placemark> placemarks = await placemarkFromCoordinates(
                latLng.latitude,
                latLng.longitude,
              );
              if (placemarks.isNotEmpty) {
                final place = placemarks.first;
                setState(() {
                  address = "${place.locality}, ${place.country}";
                });
              }
            },
            markers: selectedLatLng == null
                ? {}
                : {
              Marker(
                markerId: MarkerId("selected"),
                position: selectedLatLng!,
              ),
            },
          ),
          if (address != null)
            Positioned(
              bottom: 80,
              left: 16,
              right: 16,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
                ),
                child: Text(
                  "📍 $address",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: selectedLatLng == null
                  ? null
                  : () {
                Navigator.pop(context, {
                  'latLng': selectedLatLng,
                  'address': address,
                });
              },
              child: Text("Confirm Location"),
            ),
          ),
        ],
      ),
    );
  }
}