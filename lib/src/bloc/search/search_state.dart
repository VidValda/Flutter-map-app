part of 'search_bloc.dart';

@immutable
class SearchState {
  final bool isManual;
  final List<SearchResult> historial;

  SearchState({
    this.isManual = false,
    List<SearchResult> historial,
  }) : this.historial = historial ?? [];

  SearchState copyWith({
    bool isManual,
    List<SearchResult> historial,
  }) =>
      SearchState(
        isManual: isManual ?? this.isManual,
        historial: historial ?? this.historial,
      );
}
