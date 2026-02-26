import 'package:app_pigeon/app_pigeon.dart';
import 'package:scroll_challenge/src/core/packages/async_handler/lib/async_handler.dart';

extension AppPigeonResponseHelper on ErrorHandler{

  dynamic extractBodyData(Response<dynamic> response) {
    return response.data["data"];
  }

  String? extractSuccessMessage(Response<dynamic> response, {Debugger? debugger}){
    debugger?.dekhao(response);
    try {
      return (response.data["success"] as bool) == true ? response.data["message"] as String : null;
    } catch (e) {
      debugger?.dekhao("Error from parsing success message: $e");
      return null;
    }
  }
}