part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapLoaded extends MapaEvent {}

class OnMarcarRecorrido extends MapaEvent {}

class OnFollowing extends MapaEvent {}

class OnMapMoved extends MapaEvent {
  final LatLng mapCenter;

  OnMapMoved(this.mapCenter);
}

class OnLocationUpdate extends MapaEvent {
  final LatLng latLng;

  OnLocationUpdate(this.latLng);
}
