import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

part 'my_ubication_event.dart';
part 'my_ubication_state.dart';

class MyUbicationBloc extends Bloc<MyUbicationEvent, MyUbicationState> {
  MyUbicationBloc() : super(MyUbicationState());

  StreamSubscription<Position> _positionSubscription;

  void initFollowing() {
    _positionSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 4,
    ).listen((event) {
      final newUbication = LatLng(event.latitude, event.longitude);
      add(OnUbicationChange(newUbication));
    });
  }

  void disposeFollowing() {
    _positionSubscription?.cancel();
  }

  @override
  Stream<MyUbicationState> mapEventToState(MyUbicationEvent event) async* {
    if (event is OnUbicationChange) {
      yield state.copyWith(
        existUbication: true,
        latLng: event.latLng,
      );
    }
  }
}
