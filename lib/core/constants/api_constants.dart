class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'http://10.0.2.2:5020/api';
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String socialLogin = '/auth/social-login';
  static const String forgotPassword = '/auth/forgot-password';
  static const String me = '/auth/me';

  static const String catalogBootstrap = '/catalog/bootstrap';

  static const String destinations = '/destinations';
  static const String placeDetails = '/places';

  static const String savedPlaces = '/engagement/saved-places';
  static const String notifications = '/engagement/notifications';

  static const String mapPlaces = '/map/places';

  static const String profile = '/profile';

  static const String quests = '/quests';

  static const String customTrips = '/custom-trips';

  static const String generateTrip = '/ai/generate-trip';
  static const String recentTrips = '/ai/generate-trip/recent';

  static const String trips = '/trips';
  static const String currentTrip = '/trips/current';
  static const String myTrips = '/trips/my';

  static const String checkIn = '/visits/check-in';
  static const String visits = '/visits';
}
