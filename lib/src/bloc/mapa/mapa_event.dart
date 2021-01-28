part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapLoaded extends MapaEvent {}

class OnMarcarRecorrido extends MapaEvent {}

class OnFollowing extends MapaEvent {}

class OnBuildRoute extends MapaEvent {
  final List<LatLng> coords;
  final double distance;
  final double duration;
  final String nombreDest;

  OnBuildRoute(this.coords, this.distance, this.duration, this.nombreDest);
}

class OnMapMoved extends MapaEvent {
  final LatLng mapCenter;

  OnMapMoved(this.mapCenter);
}

class OnLocationUpdate extends MapaEvent {
  final LatLng latLng;

  OnLocationUpdate(this.latLng);
}
