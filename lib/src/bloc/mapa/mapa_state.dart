part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaReady;

  MapaState({
    this.mapaReady = false,
  });
  MapaState copyWith({
    bool mapaReady,
  }) =>
      MapaState(
        mapaReady: mapaReady ?? this.mapaReady,
      );
}
