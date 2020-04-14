import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import '../models/place.dart';
import '../providers/great_places.dart';
import 'package:provider/provider.dart';

class Navigation extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  Navigation(
      {this.initialLocation =
          const PlaceLocation(latitude: -7.7506728, longitude: 110.4104669),
      this.isSelecting = false});

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
            )
        ],
      ),
      body: Stack(
        children: <Widget>[
          FlutterMap(
            options: MapOptions(
              maxZoom: 16,
              center: LatLng(widget.initialLocation.latitude,
                  widget.initialLocation.longitude),
              onTap: widget.isSelecting ? _selectLocation : null,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/yantoguntel/ck5hvmyx70gzl1in6u0tt68r6/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoieWFudG9ndW50ZWwiLCJhIjoiY2s1Yzh4cHlwMWpxYjNsbTdoMnlhNnhpMSJ9.gmEc5DZKlunPxRQIACleXg",
                additionalOptions: {
                  'access_token':
                      'pk.eyJ1IjoieWFudG9ndW50ZWwiLCJhIjoiY2s1Yzh4cHlwMWpxYjNsbTdoMnlhNnhpMSJ9.gmEc5DZKlunPxRQIACleXg',
                  'id': 'mapbox.mapbox-streets-v8',
                },
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 80,
                    height: 80,
                    point: (_pickedLocation == null && widget.isSelecting)
                        ? LatLng(
                            widget.initialLocation.latitude,
                            widget.initialLocation.longitude,
                          )
                        : _pickedLocation ??
                            LatLng(
                              widget.initialLocation.latitude,
                              widget.initialLocation.longitude,
                            ),
                    builder: (ctx) => Container(
                      child: IconButton(
                        icon: Icon(Icons.location_on),
                        color: Colors.red,
                        iconSize: 45.0,
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              PolylineLayerOptions(polylines: [
                Polyline(
                
                )
              ])
            ],
          ),
          Positioned(
              bottom: 30,
              right: 30,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.navigation),
                      onPressed: () {},
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
