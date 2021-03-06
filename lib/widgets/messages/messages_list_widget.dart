import 'package:chirp_nets/models/conversation.dart';
import 'package:chirp_nets/models/message.dart';
import 'package:chirp_nets/providers/messages.dart';
import 'package:chirp_nets/widgets/messages/received_message_widget.dart';
import 'package:flutter/material.dart';

import 'package:chirp_nets/widgets/messages/sent_message_widget.dart';
import 'package:chirp_nets/models/user.dart';

class MessagesListWidget extends StatelessWidget {
  MessagesListWidget({
    Key key,
    this.scrollController,
    this.messageData,
    this.user,
    this.conversation,
  });

  final Conversation conversation;
  final ScrollController scrollController;
  final Messages messageData;
  final User user;

  @override
  Widget build(BuildContext context) {
    List<Message> messages = messageData.getList(conversation.id);
    return Expanded(
      child: LayoutBuilder(
        builder: (BuildContext ctx, constraints) {
          return SingleChildScrollView(
            reverse: true,
            controller: scrollController,
            child: Column(
              verticalDirection: VerticalDirection.up,
              children: [
                ...messages.map(
                  (message) {
                    int index = messages.indexOf(message);
                    bool sameMessageGroup = false;
                    if (index == messages.length - 1 || (index < messages.length - 1 && (message.sentBy != messages[index+1].sentBy || message.createdAt.difference(messages[index+1].createdAt).inMinutes >= 20))) {
                      sameMessageGroup = true;
                    }
                    if (message.sentBy == user.id) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SentMessageWidget(
                            message: message,
                            user: user,
                            sameMessageGroup: sameMessageGroup,
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ReceivedMessageWidget(
                            message: message,
                            currentUser: user,
                            sameMessageGroup: sameMessageGroup,
                          ),
                        ],
                      );
                    }
                  },
                ).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
