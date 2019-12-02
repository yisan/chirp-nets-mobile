import 'package:flutter_test/flutter_test.dart';
import 'package:chirp_nets/providers/users.dart';
import 'package:chirp_nets/models/user.dart';

void usersTest() {
  var userData = new Users();

  setUp(() {
    for (var id in userData.users.keys) {
      userData.deleteUser(id);
    }
  });

  tearDown(() {
    for (var id in userData.users.keys) {
      userData.deleteUser(id);
    }
  });

  group('Users => ', () {
    test('Can create user provider', () {
      var userData = new Users();
      expect(userData.users, equals({}));
    });

    test('Can get current user', () async {
      var id = await userData.addUser('test_user', isCurrentUser: true);
      expect(userData.getCurrentUser(), isInstanceOf<User>());
      expect(userData.getCurrentUser().id, equals(id));
      expect(userData.getCurrentUser().name, equals('test_user'));
    });

    test(
      'Can update user',
      () async {
        var id = await userData.addUser('test_user');
        userData.updateUser(id, 'updated_user');
        expect(userData.users[id].name, equals('updated_user'));
      },
    );

    test(
      'Can add user to provider',
      () async {
        User user = new User(name: 'test_user');
        var id = await userData.addUser(user.name);
        expect(userData.users[id].name, equals(user.name));
      },
    );
  });
}