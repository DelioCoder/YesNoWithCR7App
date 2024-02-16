import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/his_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(3.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://www.eluniverso.com/resizer/DXi_LQ1DOxJZ_2UZ_hY6gWtUfVg=/1031x670/smart/filters:quality(70)/cloudfront-us-east-1.images.arcpublishing.com/eluniverso/K2NWZYUGLBAABNYY7GR6W52NUA.jpg'),
          ),
        ),
        title: const Text('El bicho'),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(child: ListView.builder(
              controller: chatProvider.chatScrollController,
              itemCount: chatProvider.messageList.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messageList[index];

                return(message.fromWho == FromWho.him) ? HisMessageBubble(message: message) : MyMessageBubble(message: message);
              }
            )),
            // Caja de texto
            MessageFieldBox(
              //onValue: (value) => chatProvider.sendMessage(value)
              onValue: chatProvider.sendMessage,
            ),
            const SizedBox(height: 5),
            
          ],
        ),
      ),
    );
  }
}