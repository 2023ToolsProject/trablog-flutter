import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trablog/page/memory_pages/write_page.dart';
import 'package:trablog/view_model/write_model.dart';

class MapModel extends ChangeNotifier {

  MapModel(this.context);

  late BuildContext context;

  final Completer<GoogleMapController> _controller =  Completer();
  Completer<GoogleMapController> get controller => _controller;

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void onTap(LatLng location) async {
    var model = WriteModel();
    Navigator.push(context, MaterialPageRoute(
        builder: (context)=>ChangeNotifierProvider(
            create: (context) => model,
            child: const WritePage(),
        )
    ));
    try{
      await model.setLocation(location);
      // ignore: use_build_context_synchronously
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context){
            return AlertDialog(
              title: const Text('주소 정보를 가져오는 데 성공'),
              actions: [
                TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('확인'))
              ],
            );
          }
      );
    } catch(e){
      // ignore: use_build_context_synchronously
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text(e.toString()),
              actions: [
                TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('확인'))
              ],
            );
          }
      );
    }
  }
}