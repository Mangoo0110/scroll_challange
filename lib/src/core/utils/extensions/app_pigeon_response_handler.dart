import 'package:app_pigeon/app_pigeon.dart';
import 'package:async_handler/async_handler.dart';

extension AppPigeonResponseHelper on ErrorHandler {
  dynamic extractBodyData(Response<dynamic> response) {
    final body = response.data;
    if (body is Map<String, dynamic> && body.containsKey('data')) {
      return body['data'];
    }
    if (body is Map && body.containsKey('data')) {
      return body['data'];
    }
    return body;
  }

  String? extractSuccessMessage(
    Response<dynamic> response, {
    Debugger? debugger,
  }) {
    debugger?.dekhao(response);
    try {
      return (response.data["success"] as bool) == true
          ? response.data["message"] as String
          : null;
    } catch (e) {
      debugger?.dekhao("Error from parsing success message: $e");
      return null;
    }
  }
}
