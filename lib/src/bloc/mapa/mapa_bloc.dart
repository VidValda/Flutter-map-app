import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Colors, Offset;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/src/helpers/helpers.dart';
import 'package:mapas_app/src/themes/uber_map_theme.dart';
import 'package:meta/meta.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());
  // Controller of the map
  GoogleMapController _mapController;

  // Polylines
  Polyline _miRuta = new Polyline(
    polylineId: PolylineId("mi_ruta"),
    width: 4,
    color: Colors.black87,
  );
  Polyline _miRutaDest = new Polyline(
    polylineId: PolylineId("mi_ruta_dest"),
    width: 4,
    color: Colors.black87,
  );

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
    } else if (event is OnLocationUpdate) {
      yield* _onLocationUpdate(event);
    } else if (event is OnMarcarRecorrido) {
      yield* _onMarcarRecorrido(event);
    } else if (event is OnFollowing) {
      yield* _onFollowing(event);
    } else if (event is OnMapMoved) {
      yield state.copyWith(centralUbication: event.mapCenter);
    } else if (event is OnBuildRoute) {
      yield* _onBuildRoute(event);
    }
  }

  Stream<MapaState> _onLocationUpdate(OnLocationUpdate event) async* {
    if (state.seguirUbicacion) {
      moverCamara(event.latLng);
    }
    final List<LatLng> points = [
      ...this._miRuta.points,
      event.latLng,
    ];
    this._miRuta = this._miRuta.copyWith(pointsParam: points);
    final currentPolylines = state.polylines;
    currentPolylines["mi_ruta"] = this._miRuta;
    yield state.copyWith(polylines: currentPolylines);
  }

  Stream<MapaState> _onMarcarRecorrido(OnMarcarRecorrido event) async* {
    this._miRuta =
        this._miRuta.copyWith(colorParam: (!state.drawRoute) ? Colors.black87 : Colors.transparent);
    final currentPolylines = state.polylines;
    currentPolylines["mi_ruta"] = this._miRuta;
    yield state.copyWith(polylines: currentPolylines, drawRoute: !state.drawRoute);
  }

  Stream<MapaState> _onFollowing(OnFollowing event) async* {
    if (!state.seguirUbicacion) {
      moverCamara(_miRuta.points.last);
    }
    yield state.copyWith(seguirUbicacion: !state.seguirUbicacion);
  }

  Stream<MapaState> _onBuildRoute(OnBuildRoute event) async* {
    moverCamara(event.coords.last);
    this._miRutaDest = this._miRutaDest.copyWith(pointsParam: event.coords);
    final currentPolylines = state.polylines;
    currentPolylines["mi_ruta_dest"] = this._miRutaDest;
    // Icono inicio
    final iconStart = await getMarkerStartIcon(event.duration.floor());
    final iconEnd = await getMarkerEndIcon(event.nombreDest, event.distance);

    // marcadores
    final markerInicio = Marker(
      markerId: MarkerId("inicio"),
      position: event.coords.first,
      icon: iconStart,
      anchor: Offset(0, 0.9),
    );
    final markerFinal = Marker(
      markerId: MarkerId("final"),
      position: event.coords.last,
      icon: iconEnd,
      anchor: Offset(0, 0.9),
    );
    final markers = {...state.markers};
    markers["inicio"] = markerInicio;
    markers["final"] = markerFinal;

    yield state.copyWith(
      polylines: currentPolylines,
      markers: markers,
    );
  }
}
