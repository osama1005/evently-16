import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pro/dataBase/Event_Dao.dart';
import 'package:pro/ui/providers/Theme_provider.dart';
import 'package:provider/provider.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  void initState() {
    super.initState();
    setMapStyle();
    loadEventMarkers();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(30.047378935281518, 31.234088434423573),
          zoom: 10,
        ),
        style: themeProvider.getSelectedThemeMode() == ThemeMode.dark
            ? _style
            : null,

        markers: _markers,
      ),
    );
  }

  String? _style;
  Set<Marker> _markers = {};
  Future<void> setMapStyle() async {
    final String style = await rootBundle.loadString(
      "assets/mapStyle/MapDark.json",
    );
    setState(() {
      _style = style;
    });
  }

  Future<void> loadEventMarkers() async {
    final events = await EventDao.getEvents(null);
    Set<Marker> markers = events
        .where((event) => event.location != null)
        .map(
          (event) => Marker(
            markerId: MarkerId(event.id!),
            position: event.location!,
            infoWindow: InfoWindow(title: event.title, snippet: event.description),
          ),
        )
        .toSet();

    setState(() {
      _markers = markers;
    });
  }
}
