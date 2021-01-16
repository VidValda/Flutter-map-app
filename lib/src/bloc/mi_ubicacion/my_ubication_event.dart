part of 'my_ubication_bloc.dart';

@immutable
abstract class MyUbicationEvent {}

class OnUbicationChange extends MyUbicationEvent {
  final LatLng latLng;

  OnUbicationChange(this.latLng);
}
