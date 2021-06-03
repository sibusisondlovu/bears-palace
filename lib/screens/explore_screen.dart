import 'dart:async';

import 'package:bears_palace_app/pages/day_visits_page.dart';
import 'package:bears_palace_app/widgets/map_bottom_pill_widget.dart';
import 'package:bears_palace_app/widgets/map_user_badge_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../colors.dart';

const LatLng RESORT_LOCATION = LatLng(-26.060183, 30.089174);

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  Completer<GoogleMapController> _mapController = Completer();
  BitmapDescriptor _customMapIcon;
  LatLng _currentLocation;
  Set<Marker> _markers = Set<Marker>();

  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: RESORT_LOCATION,
    bearing: 192.8334901395799,
    tilt: 59.440717697143555,
    zoom: 15,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();

    // setup initial locations
    this.setInitialLocation();
    this.setMarkerIcons();
  }

  void setMarkerIcons() async {
    _customMapIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/images/map_marker_icon.png');
  }

  void setInitialLocation() {
    _currentLocation =
        LatLng(RESORT_LOCATION.latitude, RESORT_LOCATION.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse(AppColors.primaryColor)),
        title: Text('Explore'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              mapType: MapType.terrain,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
            ),
          ),
          MapUserBadgeWidget(),
          MapBottomPillWidget()
        ],
      ),
    );
  }
}
