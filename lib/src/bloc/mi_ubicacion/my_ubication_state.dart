part of 'my_ubication_bloc.dart';

@immutable
class MyUbicationState {
  final bool following;
  final bool existUbication;
  final LatLng latLng;

  MyUbicationState({
    this.following = true,
    this.existUbication = false,
    this.latLng,
  });
  MyUbicationState copyWith({
    bool following,
    bool existUbication,
    LatLng latLng,
  }) =>
      new MyUbicationState(
        following: following ?? this.following,
        existUbication: existUbication ?? this.existUbication,
        latLng: latLng ?? this.latLng,
      );
}
