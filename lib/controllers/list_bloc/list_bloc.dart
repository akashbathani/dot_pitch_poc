import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/api_service/api_service.dart';
import 'list_event.dart';
import 'list_state.dart';


class ListBloc extends Bloc<ListEvent, ListState> {
  final FetchService fetchService;

  ListBloc({required this.fetchService}) : super(ListInitial()) {
    on<FetchListEvent>((event, emit) async {
      emit(ListLoading());
      try {
        final responseSchema = await fetchService.fetchListSchema();
        print("resssssss:::::#$responseSchema");
        emit(ListLoaded(responseSchema: responseSchema));
      } catch (e) {
        emit(ListError(message: e.toString()));
      }
    });
  }
}
