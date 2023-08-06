import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../infrastructure/models/models.dart';

class MapScreen extends StatefulWidget {

  static const String name = 'map_screen';

  final ScanModel scan;

  const MapScreen({super.key, required this.scan});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  MapType currentMapType = MapType.normal;


  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final latLng = widget.scan.getLatLng();

    final CameraPosition pointInitial = CameraPosition(
      target: latLng,
      zoom: 17,
      tilt: 50
    );

    // markers
    Set<Marker> markers = Set<Marker>();
    markers.add(Marker(
      markerId: MarkerId('geo-location-${widget.scan.id}'),
      position: latLng,

    ));


   final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();


    return Scaffold(
      appBar: AppBar(
        title: const Text('Coordinates'),
        actions: [
          IconButton(onPressed: () async {

            final GoogleMapController controller = await _controller.future;
            await controller.animateCamera(CameraUpdate.newCameraPosition(pointInitial));

          }, icon: Icon(Icons.location_on, color: colors.primary,))
        ],
      ),
      body: GoogleMap(
        markers: markers,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        mapType: currentMapType,
        initialCameraPosition: pointInitial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            currentMapType = (currentMapType == MapType.normal) ? MapType.satellite : MapType.normal;  
          });
        },
        child: Icon(Icons.mark_chat_read_sharp, color: colors.primary,),
      ),
    );
  }
}