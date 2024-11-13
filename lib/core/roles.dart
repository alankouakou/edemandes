enum Role {
  user(value: 'user'),
  chefService(value: 'chef_service'),
  raf(value: 'raf'),
  coordonnateur(value: 'coordonnateur'),
  comptable(value: 'comptable'),
  admin(value: 'admin');

  const Role({required this.value});
  final String value;
}
