import 'package:flutter/foundation.dart';

base class ApiEndpoints {
  static const String socketUrl = _RemoteServer.socketUrl;

  static const String baseUrl = _RemoteServer.baseUrl;
  
  // ---------------------- AUTH -----------------------------
  /// ### post
  static const String login = '$baseUrl/auth/login';

  // ---------------------- USER -----------------------------
  /// ### get
  static String getUserProfile(String userId) => '$baseUrl/users/$userId';

  // ---------------------- PRODUCT -----------------------------
  static const String getProducts = '$baseUrl/products';
  static String singleProduct(String productId) => '$baseUrl/products/$productId';

}

class _RemoteServer {
  static const String socketUrl =
      '';

  static const String baseUrl =
      'https://fakestoreapi.com';
}

class _LocalHostWifi {
  static const String socketUrl = 'http://10.10.5.90:5006';

  static const String baseUrl = 'http://10.10.5.90:5006/api/v1';
}


class _Auth {
  @protected
  static const String _authRoute = '${ApiEndpoints.baseUrl}/auth';
  // example
  //static const String login = '$_authRoute/login';
}



// ---------------------- Notification -----------------------------
class _Notification {
  static const String _notificationRoute =
      '${ApiEndpoints.baseUrl}/notification';
}

class _User {
  static const String _userRoute = '${ApiEndpoints.baseUrl}/user';
}

// ---------------------- MESSAGE -----------------------------
class _Message {
  static const String _messageRoute = '${ApiEndpoints.baseUrl}/message';
}

