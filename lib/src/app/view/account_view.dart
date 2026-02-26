import 'package:flutter/material.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: Center(
        child: FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.login_rounded),
          label: const Text('Login'),
        ),
      ),
    );
  }
}
