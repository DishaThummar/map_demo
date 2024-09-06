import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<LatLng> latLen = [
    const LatLng(21.2480038922611, 72.8829388572782),
    const LatLng(21.170240, 72.831062),
    const LatLng(21.230005, 72.900902),
  ];

  Completer<GoogleMapController> controller = Completer();

  final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(21.2480038922611, 72.8829388572782),
    zoom: 14,
  );

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < latLen.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: latLen[i],
        visible: true,
        infoWindow: const InfoWindow(title: "Surat"),
        icon: BitmapDescriptor.defaultMarkerWithHue(9),
      ));
      _polyline.add(Polyline(
          polylineId: const PolylineId('1'),
          points: latLen,
          color: Colors.green,
          visible: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Maps Demo'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: <Widget>[
          // GoogleMap(
          //   onMapCreated: _onMapCreated,
          //   initialCameraPosition: CameraPosition(
          //     target: _center,
          //     zoom: 10.0,
          //   ),
          //   rotateGesturesEnabled: true,
          //   tiltGesturesEnabled: true,
          //   scrollGesturesEnabled: true,
          //   trafficEnabled: true,
          //   zoomControlsEnabled: true,
          //   buildingsEnabled: true,
          //
          //   zoomGesturesEnabled: true,
          // ),
          GoogleMap(
            initialCameraPosition: _kGoogle,
            mapType: MapType.hybrid,
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            rotateGesturesEnabled: true,
            tiltGesturesEnabled: true,
            scrollGesturesEnabled: true,
            trafficEnabled: true,
            zoomControlsEnabled: true,
            buildingsEnabled: true,
            zoomGesturesEnabled: true,
            polylines: _polyline,
            onMapCreated: (GoogleMapController controller) {
              // controller.complete(controller);
            },
          ),
        ],
      ),
    );
  }
}
