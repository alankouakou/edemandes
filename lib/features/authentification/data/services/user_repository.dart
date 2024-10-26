import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = Provider<UserRepository>((ref) => UserRepository());

class UserRepository {}
