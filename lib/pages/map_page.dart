import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrreader/models/scan_models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final scanModel = ModalRoute.of(context)?.settings.arguments as ScanModel;

    CameraPosition _kGooglePlex = CameraPosition(
      target: scanModel.getLatLng,
      zoom: 14.4746,
    );

    Set<Marker> markers = {};

    markers.add(Marker(
        markerId: const MarkerId("geo-location"),
        position: scanModel.getLatLng));

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: scanModel.getLatLng, zoom: 17),
          ));
        },
        child: const Icon(Icons.location_history),
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        markers: markers,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
