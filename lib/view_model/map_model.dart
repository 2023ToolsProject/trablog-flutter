import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapModel extends ChangeNotifier {

  final Completer<GoogleMapController> _controller =  Completer();
  Completer<GoogleMapController> get controller => _controller;

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
}