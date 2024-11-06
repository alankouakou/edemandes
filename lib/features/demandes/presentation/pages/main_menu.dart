import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/authentification/presentation/providers/user_provider.dart';
import 'package:demandes/features/demandes/presentation/pages/navigation_menus.dart';
import 'package:demandes/features/demandes/presentation/widgets/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageIndexProvider = StateProvider<int>((ref) => 0);
final roleProvider = StateProvider<String>((ref) => '');

class MainMenu extends ConsumerWidget {
  const MainMenu({super.key});

  List<Widget> getBody(String role) {
    print('User role : $role');
    final body = switch (role) {
      'user' => userPages,
      'chef_service' => chefServicePages,
      'raf' => rafPages,
      'coordonnateur' => coordonnateurPages,
      'comptable' => comptablePages,
      'admin' => adminPages,
      _ => userPages
    };
    return body;
  }

  List<NavigationDestination> getNavDestinations(String role) {
    final navDestinations = switch (role) {
      'user' => userNavigationDestinations,
      'raf' => rafNavigationDestinations,
      'coordonnateur' => coordonnateurNavigationDestinations,
      'admin' => adminNavigationDestinations,
      _ => adminNavigationDestinations
    };

    return navDestinations;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(pageIndexProvider);
    // final uid = ref.watch(authRepoProvider).currentUser!.uid;
    final asyncUser = ref.watch(userNotifierProvider);
    //const role = 'user';

    /*    ref.listen(pageIndexProvider, (previous, next) {
      print('old index: $previous next index: $next');
    });
 */
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: const AppBarTitle(),
          actions: [
            IconButton(
                onPressed: () {
                  ref.read(authRepoProvider).signOut();
                },
                icon: const Icon(Icons.power_settings_new)),
          ]),
      bottomNavigationBar: asyncUser.when(
          data: (user) => NavigationBar(
                selectedIndex: currentIndex,
                indicatorColor: Colors.blue,
                backgroundColor: Colors.white,
                onDestinationSelected: (value) {
                  ref.read(pageIndexProvider.notifier).state = value;
                },
                destinations: getNavDestinations(user.role),
              ),
          error: (e, s) => null,
          loading: () => const Center(child: CircularProgressIndicator())),
      body: asyncUser.when(
        data: (user) => getBody(user.role)[currentIndex],
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
