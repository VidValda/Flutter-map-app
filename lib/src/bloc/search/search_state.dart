part of 'search_bloc.dart';

@immutable
class SearchState {
  final bool isManual;

  SearchState({
    this.isManual = false,
  });

  SearchState copyWith({
    bool isManual,
  }) =>
      SearchState(
        isManual: isManual ?? this.isManual,
      );
}
