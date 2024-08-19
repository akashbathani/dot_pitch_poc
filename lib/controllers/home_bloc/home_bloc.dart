import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_data_schema.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../../services/local_storage_service/shared_preference_service.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SharedPreferenceService sharedPrefService;

  HomeBloc(this.sharedPrefService) : super(HomeInitial()) {
    on<LoadDataEvent>(_onLoadData);
    on<LogoutEvent>(_onLogout);
    on<RemoveItemEvent>(_onRemoveItem);
  }

  Future<void> _onLoadData(LoadDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    try {
      List<UserData> items = [];
      await sharedPrefService.init();
      String? dataListJson = sharedPrefService.getString('dataList');
      if (dataListJson != null) {
        items = (jsonDecode(dataListJson) as List)
            .map((item) => UserData.fromJson(item))
            .toList();
      }
      emit(HomeLoaded(items));
    } catch (e) {
      emit(HomeError("Failed to load data"));
    }
  }

  Future<void> _onRemoveItem(RemoveItemEvent event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final items = List<UserData>.from(currentState.items);
      items.removeAt(event.index);

      try {
        await sharedPrefService.setString('dataList', jsonEncode(items.map((e) => e.toJson()).toList()));
        emit(HomeLoaded(items));
      } catch (e) {
        emit(HomeError("Failed to remove item"));
      }
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded) {
      await sharedPrefService.setBool('isLoggedIn', false);
      emit(LogoutState());
    }
  }
}
