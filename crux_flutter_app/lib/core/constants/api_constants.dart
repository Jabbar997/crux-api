class ApiConstants {
  // TODO: Change this for Android emulator (10.0.2.2) or real device
  static const String baseUrl = 'http://localhost:3000'; 
  
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  
  // Deals
  static const String dealsFuture = '/deals/future';
  static const String dealsActive = '/deals/active';
  static const String dealsCompleted = '/deals/completed';
  static const String dealDetails = '/deals'; // + /:id
  
  // Orders
  static const String orders = '/orders';
  
  // Payments
  static const String payments = '/payments';
}
