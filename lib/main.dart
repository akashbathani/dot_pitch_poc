import 'package:dot_pitch_poc/controllers/add_data_bloc/add_data_bloc.dart';
import 'package:dot_pitch_poc/controllers/home_bloc/home_bloc.dart';
import 'package:dot_pitch_poc/services/api_service/api_service.dart';
import 'package:dot_pitch_poc/services/local_storage_service/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controllers/auth_bloc/auth_bloc.dart';
import 'controllers/list_bloc/list_bloc.dart';
import 'services/auth_service/auth_service.dart';
import 'services/navigation_service/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferenceService = SharedPreferenceService();
  await sharedPreferenceService.init();
  final authService = AuthService(sharedPreferenceService);
  final homeService = FetchService();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authService,sharedPreferenceService),
        ),
        BlocProvider(
          create: (context) =>ListBloc(fetchService: homeService),
        ),
        BlocProvider(
          create: (context) =>HomeBloc( sharedPreferenceService),
        ),
        BlocProvider(
          create: (context) =>AddDataBloc(sharedPrefService: sharedPreferenceService),
        ),
      ],
      child:  MyApp(isLoggedIn: authService.isLoggedIn(),),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggedIn});
final bool isLoggedIn;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: NavigationServices.navigationRouter(isLoggedIn),
    );
  }
}
