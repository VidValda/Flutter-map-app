import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mapas_app/src/models/search_result.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is OnManual) {
      yield state.copyWith(isManual: !state.isManual);
    } else if (event is OnAddHistory) {
      final exist =
          state.historial.where((result) => result.nombreDest == event.result.nombreDest).length;
      if (exist == 0) {
        yield state.copyWith(
          historial: [...state.historial, event.result],
        );
      }
    } else if (event is OnRemove) {
      final newList =
          state.historial.where((result) => result.nombreDest != event.result.nombreDest).toList();
      yield state.copyWith(historial: newList);
    }
  }
}
