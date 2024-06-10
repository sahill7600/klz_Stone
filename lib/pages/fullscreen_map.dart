import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'locationpage.dart';

class FullScreenMap extends StatefulWidget {
  const FullScreenMap({Key? key}) : super(key: key);

  @override
  State<FullScreenMap> createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  BitmapDescriptor? pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 1.5), 'assets/mapmarker.png');
  }

  @override
  Widget build(BuildContext context) {
    LatLng pinPosition = LatLng(32.88848150448474, -96.8845901);
    MarkerId markerId = MarkerId('klz_stone');
    // the camera position
    CameraPosition initialLocation =
        CameraPosition(zoom: 16, bearing: 30, target: pinPosition);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Contact Us",
            style: TextStyle(fontFamily: 'Futura', color: Colors.white),
          )),
      body: GoogleMap(
          myLocationEnabled: true,
          compassEnabled: true,
          markers: _markers,
          initialCameraPosition: initialLocation,
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(Utils.mapStyles);
            controller.showMarkerInfoWindow(markerId);
            _controller.complete(controller);
            setState(() {
              _markers.add(Marker(
                  markerId: markerId,
                  position: pinPosition,
                  icon: pinLocationIcon!,
                  infoWindow: InfoWindow(
                      title: 'KLZStone',
                      snippet:
                          '11129 Zodiac Ln Suite 300, \nDallas, TX 75229,\n United States')));
            });
          }),
    );
  }
}
