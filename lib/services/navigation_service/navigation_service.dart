import 'package:dot_pitch_poc/views/api_calling_list_screen/api_calling_list_screen.dart';
import 'package:dot_pitch_poc/views/home_screen/home_screen.dart';
import 'package:dot_pitch_poc/views/registration_screen/registration_screen.dart';
import 'package:dot_pitch_poc/views/splash_screen.dart';
import 'package:dot_pitch_poc/widgets/add_data_screen.dart';
import 'package:go_router/go_router.dart';

import '../../views/login_screen/login_screen.dart';
import '../auth_service/auth_service.dart';
import 'navigation_middleware.dart';

// *****************************************************************************
// Go Router Starts From here
// *****************************************************************************

class NavigationServices {

  static  GoRouter navigationRouter(bool isLoggedIn) => GoRouter(
    observers: [GoRouteMiddleware()],
    initialLocation:"/splash",
    routes: [
      GoRoute(
        name: "/login",
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        name: "/splash",
        path: '/splash',
        builder: (context, state) => SplashScreen(isLoggedIn: isLoggedIn),
      ),
      GoRoute(
        name: "/register",
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        name: "/home",
        path: '/home',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        name: "/add-data",
        path: '/add-data',
        builder: (context, state) => AddDataPage(),
      ),
      GoRoute(
        name: "/api-calling-screen",
        path: '/api-calling-screen',
        builder: (context, state) => ApiCallingScreen(),
      ),
    ],
  );
}
