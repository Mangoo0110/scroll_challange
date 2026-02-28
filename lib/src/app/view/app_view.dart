import 'package:flutter/material.dart';

import '../di/repo_di.dart';
import '../../modules/cart/controller/cart_store.dart';
import '../../modules/cart/ui/view/cart_view.dart';
import 'account_view.dart';
import 'home_view.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final ValueNotifier<int> _index = ValueNotifier<int>(0);
  final CartStore _cartStore = serviceLocator<CartStore>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cartStore.load(userId: null);
    });
  }

  @override
  void dispose() {
    _index.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _index,
      builder: (context, selectedIndex, _) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: selectedIndex,
              children: const [HomeView(), CartView(), AccountView()],
            ),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) => _index.value = value,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_cart_outlined),
                selectedIcon: Icon(Icons.shopping_cart_rounded),
                label: 'Cart',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline_rounded),
                selectedIcon: Icon(Icons.person_rounded),
                label: 'Account',
              ),
            ],
          ),
        );
      },
    );
  }
}
