import 'package:flutter/material.dart';
import 'route_names.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/welcome/screens/welcome_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/screens/forgot_password_screen.dart';
import '../../features/home/screens/main_shell_screen.dart';
import '../../features/place_details/screens/place_details_screen.dart';
import '../../features/ai_trip_planner/screens/trip_roadmap_screen.dart';
import '../../features/ai_trip_planner/models/trip_preferences.dart';
import '../../features/mission/screens/mission_verification_screen.dart';
import '../models/quest_model.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return _buildRoute(const SplashScreen());
      case RouteNames.welcome:
        return _buildRoute(const WelcomeScreen());
      case RouteNames.login:
        return _buildRoute(const LoginScreen());
      case RouteNames.signup:
        return _buildRoute(const SignupScreen());
      case RouteNames.forgotPassword:
        return _buildRoute(const ForgotPasswordScreen());
      case RouteNames.mainShell:
        return _buildRoute(const MainShellScreen());
      case RouteNames.placeDetails:
        final placeId = settings.arguments as String? ?? '';
        return _buildRoute(PlaceDetailsScreen(placeId: placeId));
      case RouteNames.tripRoadmap:
        final preferences = settings.arguments as TripPreferences;
        return _buildRoute(TripRoadmapScreen(preferences: preferences));
      case RouteNames.missionVerification:
        final quest = settings.arguments as QuestModel;
        return _buildRoute(MissionVerificationScreen(quest: quest));
      default:
        return _buildRoute(
          Scaffold(
            body: Center(child: Text('لا يوجد مسار باسم ${settings.name}')),
          ),
        );
    }
  }

  static Route<dynamic> _buildRoute(Widget screen) =>
      MaterialPageRoute(builder: (_) => screen);
}
