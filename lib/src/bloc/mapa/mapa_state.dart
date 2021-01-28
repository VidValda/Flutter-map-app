part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaReady;
  final bool drawRoute;
  final bool seguirUbicacion;
  final LatLng centralUbication;

  // Polylines

  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  MapaState({
    this.mapaReady = false,
    this.drawRoute = true,
    this.seguirUbicacion = false,
    this.centralUbication,
    Map<String, Polyline> polylines,
    Map<String, Marker> markers,
  })  : this.polylines = polylines ?? new Map(),
        this.markers = markers ?? new Map();
  MapaState copyWith({
    bool mapaReady,
    bool drawRoute,
    bool seguirUbicacion,
    LatLng centralUbication,
    Map<String, Polyline> polylines,
    Map<String, Marker> markers,
  }) =>
      MapaState(
        mapaReady: mapaReady ?? this.mapaReady,
        drawRoute: drawRoute ?? this.drawRoute,
        seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
        centralUbication: centralUbication ?? this.centralUbication,
        polylines: polylines ?? this.polylines,
        markers: markers ?? this.markers,
      );
}
