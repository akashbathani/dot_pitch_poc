import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_data_schema.dart';
import 'add_data_event.dart';
import 'add_data_state.dart';
import '../../services/local_storage_service/shared_preference_service.dart';

class AddDataBloc extends Bloc<AddDataEvent, AddDataState> {
  final SharedPreferenceService sharedPrefService;

  AddDataBloc({required this.sharedPrefService}) : super(AddDataInitial()) {
    on<AddDataButtonPressed>(_onAddDataButtonPressed);
  }

  Future<void> _onAddDataButtonPressed(
      AddDataButtonPressed event, Emitter<AddDataState> emit) async {
    emit(AddDataLoading());

    try {
      await sharedPrefService.init();
      String? dataListJson = sharedPrefService.getString('dataList');
      List<UserData> dataList = [];
      if (dataListJson != null) {
        dataList = (jsonDecode(dataListJson) as List)
            .map((item) => UserData.fromJson(item))
            .toList();
      }

      final newData = UserData(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        phoneNumber: event.phoneNumber,
        address: event.address,
      );

      dataList.add(newData);

      await sharedPrefService.setString('dataList', jsonEncode(dataList.map((e) => e.toJson()).toList()));

      emit(AddDataSuccess());
    } catch (e) {
      emit(AddDataFailure(error: e.toString()));
    }
  }
}
