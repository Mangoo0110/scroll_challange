
import 'package:scroll_challenge/src/core/packages/async_handler/lib/async_handler.dart';

import 'package:scroll_challenge/src/core/shared/reactive_notifier/process_notifier.dart';
import '../../shared/reactive_notifier/snackbar_notifier.dart';


 Future<T?> handleFutureRequest<T>({
    required AsyncRequest<T> Function() futureRequest,
    Debugger? debugger,
    ProcessStatusNotifier? processStatusNotifier,
    SnackbarNotifier? errorSnackbarNotifier,
    SnackbarNotifier? successSnackbarNotifier,
    void Function(T data)? onSuccess,
    void Function(ErrorResponse failure)? onError,
  }) async{
    processStatusNotifier?.setLoading();
    final res = await futureRequest();
    if(res is SuccessResponse) {
      processStatusNotifier?.setSuccess(
        message: (res).message
      );
      successSnackbarNotifier?.notifySuccess(
        message: (res).message
      );
      if(onSuccess != null && res.data is T) onSuccess(res.data as T);
      debugger?.dekhao("Success:: ${(res).message}");
      return res.data;
    } else if(res is ErrorResponse) {
      processStatusNotifier?.setEnabled();
      errorSnackbarNotifier?.notifyError(message: (res).message);
      if(onError != null) onError(res as ErrorResponse);
      debugger?.dekhao("Error:: ${(res as ErrorResponse).toString()}");
      return null;
    }

    return null;
  }
    