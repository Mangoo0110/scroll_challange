import 'package:flutter/material.dart';
import 'package:scroll_challenge/src/auth_di.dart';
import 'package:scroll_challenge/src/core/packages/async_handler/lib/async_handler.dart';
import 'package:scroll_challenge/src/core/shared/reactive_notifier/snackbar_notifier.dart';
import 'package:scroll_challenge/src/core/utils/utils.dart';
import 'package:scroll_challenge/src/modules/auth/model/auth_user.dart';
import 'package:scroll_challenge/src/modules/auth/repo/auth_repo.dart';
import 'package:scroll_challenge/src/modules/auth/ui/view/login_view.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  late final AuthRepo _authRepo;
  AuthUser? _currentUser;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _authRepo = authServiceLocatior<AuthRepo>();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    setState(() => _isLoading = true);
    _currentUser = await handleFutureRequest(futureRequest: () async=> await _authRepo.getCurrentUser());
    setState(() => _isLoading = false);
  }

  Future<void> _logout() async {
    setState(() => _isLoading = true);
    await handleFutureRequest(
      futureRequest: () async=> await _authRepo.logout(),
      onSuccess: (_) {
        _currentUser = null;
      },
      errorSnackbarNotifier: SnackbarNotifier(context: context),
      successSnackbarNotifier: SnackbarNotifier(context: context),
    );
    setState(() => _isLoading = false);
  }

  Future<void> _openLogin() async {
    final result = await Navigator.of(
      context,
    ).push<bool>(MaterialPageRoute(builder: (_) => const LoginView()));
    if ((result ?? false) && mounted) {
      await _loadCurrentUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: Builder(
        builder: (context) {
          if (_isLoading && _currentUser == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = _currentUser;
          if (user == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'You are not logged in',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: _openLogin,
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  user.fullName.isEmpty ? user.username : user.fullName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: const Text('Current user'),
              ),
              const Divider(),
              ListTile(
                title: const Text('Username'),
                subtitle: Text(user.username),
              ),
              ListTile(title: const Text('Email'), subtitle: Text(user.email)),
              ListTile(title: const Text('Phone'), subtitle: Text(user.phone)),
              const SizedBox(height: 16),
              FilledButton.tonal(
                onPressed: _isLoading ? null : _logout,
                child: const Text('Logout'),
              ),
            ],
          );
        },
      ),
    );
  }
}
