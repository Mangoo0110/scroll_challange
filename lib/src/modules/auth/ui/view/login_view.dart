import 'package:flutter/material.dart';
import 'package:scroll_challenge/src/auth_di.dart';
import 'package:scroll_challenge/src/core/shared/reactive_notifier/process_notifier.dart';
import 'package:scroll_challenge/src/core/shared/reactive_notifier/snackbar_notifier.dart';
import 'package:scroll_challenge/src/core/shared/reactive_notifier/widget/process_notifier_button.dart';
import 'package:scroll_challenge/src/modules/auth/controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'mor_2314');
  final _passwordController = TextEditingController(text: '83r5^_');
  late final LoginController _loginController;

  @override
  void initState() {
    super.initState();
    _loginController = authServiceLocatior<LoginController>();
    _loginController.onUsernameChanged(_usernameController.text);
    _loginController.onPasswordChanged(_passwordController.text);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    final errorNotifier = SnackbarNotifier(context: context);
    final successNotifier = SnackbarNotifier(context: context);
    await _loginController.login(
      errorSnackbarNotifier: errorNotifier,
      successSnackbarNotifier: successNotifier,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _loginController,
          _loginController.processNotifier,
        ]),
        builder: (context, _) {
          final isLoading =
              _loginController.processNotifier.status is ProcessLoading;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    onChanged: _loginController.onUsernameChanged,
                    decoration: const InputDecoration(
                      labelText: 'Username / Email',
                      border: OutlineInputBorder(),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (_) => _loginController.usernameError,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    onChanged: _loginController.onPasswordChanged,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (_) => _loginController.passwordError,
                  ),
                  const SizedBox(height: 20),
                  
                  RProcessNotifierButton(
                    key: const ValueKey('login_process_button'),
                    processStatusNotifier: _loginController.processNotifier,
                    generalText: 'Login',
                    loadingText: 'Logging in',
                    doneText: 'Done',
                    errorText: 'Error',
                    onSave: (_) {
                      _onLogin();
                    },
                    onDone: () {
                      if (_loginController.loggedInUser != null && mounted) {
                        
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isLoading
                        ? 'Please wait...'
                        : 'Demo credentials are prefilled for fakestoreapi.',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
