import 'package:flutter/foundation.dart';
import 'package:scroll_challenge/src/core/shared/reactive_notifier/process_notifier.dart';
import 'package:scroll_challenge/src/core/shared/reactive_notifier/snackbar_notifier.dart';
import 'package:scroll_challenge/src/core/utils/helpers/handle_future_request.dart';
import 'package:scroll_challenge/src/modules/auth/model/auth_user.dart';
import 'package:scroll_challenge/src/modules/auth/repo/auth_repo.dart';
import 'package:async_handler/async_handler.dart';

class LoginController extends ChangeNotifier {
  LoginController(this._authRepo);

  final AuthRepo _authRepo;
  final ProcessStatusNotifier processNotifier = ProcessStatusNotifier(
    initialStatus: ProcessDisabled(),
  );

  AuthUser? _loggedInUser;
  String? _errorMessage;
  String _username = '';
  String _password = '';
  String? _usernameError;
  String? _passwordError;
  Debugger debugger = ControllerDebugger();

  AuthUser? get loggedInUser => _loggedInUser;
  String? get errorMessage => _errorMessage;
  String? get usernameError => _usernameError;
  String? get passwordError => _passwordError;
  bool get isUsernameValid => _usernameError == null && _username.isNotEmpty;
  bool get isPasswordValid => _passwordError == null && _password.isNotEmpty;
  bool get isFormValid => isUsernameValid && isPasswordValid;

  bool get isLoading => processNotifier.status is ProcessLoading;

  void onUsernameChanged(String value) {
    _username = value.trim();
    _usernameError = _validateUsername(_username);
    _syncProcessState();
    notifyListeners();
  }

  void onPasswordChanged(String value) {
    _password = value;
    _passwordError = _validatePassword(_password);
    _syncProcessState();
    notifyListeners();
  }

  Future<bool> login({
    required SnackbarNotifier errorSnackbarNotifier,
    SnackbarNotifier? successSnackbarNotifier,
  }) async {
    _usernameError = _validateUsername(_username);
    _passwordError = _validatePassword(_password);
    notifyListeners();
    if (!isFormValid) {
      _syncProcessState();
      return false;
    }

    _errorMessage = null;

    final result = await handleFutureRequest<AuthUser>(
      futureRequest: () => _authRepo.login(username: _username, password: _password),
      processStatusNotifier: processNotifier,
      errorSnackbarNotifier: errorSnackbarNotifier,
      successSnackbarNotifier: successSnackbarNotifier,
      debugger: debugger,
      onSuccess: (data) {
        _loggedInUser = data;
      },
      onError: (failure) {
        _errorMessage = failure.message;
      },
    );

    _syncProcessState();
    return result != null;
  }

  String? _validateUsername(String value) {
    if (value.isEmpty) {
      return 'Username is required';
    }
    // If user types email-like input, validate email format as well.
    if (value.contains('@')) {
      final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
      if (!emailRegex.hasMatch(value)) {
        return 'Enter a valid email';
      }
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 4) {
      return 'Password is too short';
    }
    return null;
  }

  void _syncProcessState() {
    if (isLoading) {
      return;
    }
    if (isFormValid) {
      processNotifier.setEnabled();
    } else {
      processNotifier.setDisabled();
    }
  }
}
