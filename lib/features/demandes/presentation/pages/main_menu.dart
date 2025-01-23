import 'package:demandes/core/messaging/repository/user_token_repository.dart';
import 'package:demandes/core/themes/app_palette.dart';
import 'package:demandes/core/widgets/loading.dart';
import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/authentification/presentation/providers/user_provider.dart';
import 'package:demandes/features/demandes/presentation/pages/navigation_menus.dart';
import 'package:demandes/features/demandes/presentation/widgets/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final pageIndexProvider = StateProvider<int>((ref) => 0);

class MainMenu extends ConsumerWidget {
  const MainMenu({super.key});

  List<Widget> getBody(String role) {
    print('User role : $role');
    final body = switch (role) {
      'USER' => userPages,
      'CHEF_SERVICE' => chefServicePages,
      'RAF' => rafPages,
      'COORDONNATEUR' => coordonnateurPages,
      'COMPTABLE' => comptablePages,
      'ADMIN' => adminPages,
      _ => userPages
    };
    return body;
  }

  List<NavigationDestination> getNavDestinations(String role) {
    final navDestinations = switch (role) {
      'USER' => userNavigationDestinations,
      'CHEF_SERVICE' => chefServiceDestinations,
      'RAF' => rafNavigationDestinations,
      'COORDONNATEUR' => coordonnateurNavigationDestinations,
      'COMPTABLE' => comptableNavigationDestinations,
      'ADMIN' => adminNavigationDestinations,
      _ => userNavigationDestinations
    };

    return navDestinations;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(pageIndexProvider);
    final asyncUser = ref.watch(userNotifierProvider);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: const AppBarTitle(),
          actions: [
            IconButton(
                onPressed: () async {
                  await ref.read(authRepoProvider).signOut();
                  ref.invalidate(userNotifierProvider);
                },
                icon: const Icon(Icons.power_settings_new)),
          ]),
      bottomNavigationBar: asyncUser.when(
          data: (user) {
            return NavigationBar(
              selectedIndex: currentIndex,
              indicatorColor: AppPalette.buttonBackgroundColor,
              backgroundColor: Colors.white,
              onDestinationSelected: (value) {
                ref.read(pageIndexProvider.notifier).state = value;
              },
              destinations: getNavDestinations(user.role),
            );
          },
          error: (e, s) => null,
          loading: () => const Loading()),
      body: asyncUser.when(
        data: (user) => getBody(user.role)[currentIndex],
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => const Loading(),
      ),
    );
  }
}
