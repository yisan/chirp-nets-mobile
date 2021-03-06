import 'package:chirp_nets/providers/conversations.dart';
import 'package:chirp_nets/providers/users.dart';
import 'package:flutter_test/flutter_test.dart';

void conversationsTest() {
  int userId;
  var conversationProvider = Conversations();
  var userProvider = Users();

  setUp(() async {
    userId = await userProvider.addUser(name:'Tim', nodeId: 0);
  });

  tearDown(() {
    for (var id in userProvider.users.keys) {
      userProvider.deleteUser(id);
    }
    for (var id in conversationProvider.conversations.keys) {
      conversationProvider.deleteConversation(id);
    }
  });

  group('Conversations => ', () {
    test('Can create conversation provider', () {
      expect(conversationProvider.conversations, equals({}));
    });

    test('Can add conversation to provider', () async {
      int convId = await conversationProvider.addConversation(userId, 'Name', 1);
      var conversations = conversationProvider.conversations;
      expect(conversations[convId].name, equals('Name'));
    });

    test(
      'Can update conversation',
      () async {
        int id = await conversationProvider.addConversation(userId, 'Conve', 2);
        conversationProvider.updateConversation(id, 'conversation', 3);
        var conversations = conversationProvider.conversations;
        expect(conversations[id].name, equals('conversation'));
      },
    );

    test(
      'Can delete conversation',
      () async {
        int id = await conversationProvider.addConversation(userId, 'Conve', 4);
        var originialConversations = conversationProvider.conversations;
        conversationProvider.deleteConversation(id);
        var conversations = conversationProvider.conversations;
        expect(conversations.length, equals(originialConversations.length - 1));
      },
    );
  });
}
