import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/src/themes/uber_map_theme.dart';
import 'package:meta/meta.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());
  GoogleMapController _mapController;

  void initMap(GoogleMapController controller) {
    if (!state.mapaReady) {
      _mapController = controller;
      _mapController.setMapStyle(jsonEncode(uberMapTheme));
      add(OnMapLoaded());
    }
  }

  void moverCamara(LatLng destiny) {
    final cameraUpadate = CameraUpdate.newLatLng(destiny);
    this._mapController?.animateCamera(cameraUpadate);
  }

  @override
  Stream<MapaState> mapEventToState(MapaEvent event) async* {
    if (event is OnMapLoaded) {
      yield state.copyWith(mapaReady: true);
    }
  }
}
