import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pro/dataBase/Event.dart';
import 'package:pro/extension/context_extension.dart';
import 'package:pro/l10n/app_localizations.dart';
import 'package:pro/routes.dart';
import 'package:pro/ui/providers/Theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../dataBase/Event_Dao.dart';
import '../EventInfoTile.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  String? address;
  Event? event;
  bool _isLoaded = false;
  String? _style;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isLoaded) {
      event = ModalRoute.of(context)!.settings.arguments as Event;
      _loadAddress();
      _isLoaded = true;
    }
  }
  @override
  void initState() {
    super.initState();
    setMapStyle();
  }

  Future<void> _loadAddress() async {
    final lat = event?.location?.latitude;
    final lng = event?.location?.longitude;

    List<Placemark> placemarks = await placemarkFromCoordinates(lat!, lng!);
    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      setState(() {
        address = "${place.locality}, ${place.country}";
      });
    }
  }

  Future<void> setMapStyle() async {
    final String style = await rootBundle.loadString(
      "assets/mapStyle/MapDark.json",
    );
    setState(() {
      _style = style;
    });
  }

  @override
  Widget build(BuildContext context) {

    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final event = ModalRoute.of(context)!.settings.arguments as Event;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.appColors.primary)  ,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.eventDetails,style: context.fonts.bodyLarge?.copyWith(color:context.appColors.primary)),
        actions: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, App_routes.Edit.name, arguments: event);
          }, icon: Icon(Icons.edit)),
          IconButton(
            onPressed: () async {
              await EventDao.deleteEvent(event.id!);
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete_outline_outlined, color: Colors.red),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(16),
                  child: Image.asset(event.getCategoryImage()),
                ),
                SizedBox(height: 24),
                Text(
                  event.title ?? "",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: context.appColors.primary),
                ),
                SizedBox(height: 16),
                EventInfoTile(
                  prefixIcon: Icons.calendar_month_rounded,

                  text: event.dateTime!.formatDate,
                ),
                SizedBox(height: 16),

                EventInfoTile(
                  prefixIcon: Icons.gps_fixed_sharp,
                  suffixIcon: Icons.arrow_forward,
                  text: address ?? "",
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 300,
                  child: GoogleMap(
                    style: themeProvider.isDarkMode() ? _style : null,
                    markers: <Marker>{
                      Marker(
                        markerId: MarkerId(event.id!),
                        position: LatLng(
                          event.location!.latitude,
                          event.location!.longitude,
                        ),
                      ),
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        event.location!.latitude,
                        event.location!.longitude,
                      ),
                      zoom: 10,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(AppLocalizations.of(context)!.eventDesc),
                SizedBox(height: 5),
                Text(event.description ?? ""),
              ],
            ),
          ],
        ),
      ),
    );
  }
}