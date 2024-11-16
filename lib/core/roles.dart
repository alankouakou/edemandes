enum Role {
  user(value: 'USER'),
  chefService(value: 'CHEF_SERVICE'),
  raf(value: 'RAF'),
  coordonnateur(value: 'COORDONNATEUR'),
  comptable(value: 'COMPTABLE'),
  admin(value: 'ADMIN');

  const Role({required this.value});
  final String value;
}
