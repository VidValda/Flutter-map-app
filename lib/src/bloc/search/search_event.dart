part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class OnManual extends SearchEvent {}

class OnRemove extends SearchEvent {
  final SearchResult result;

  OnRemove(this.result);
}

class OnAddHistory extends SearchEvent {
  final SearchResult result;

  OnAddHistory(this.result);
}
