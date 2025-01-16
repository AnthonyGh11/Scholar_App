import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/pages/cubits/chat_cubit/cubit/chat_cubit.dart';
import 'package:scholar_chat/widgets/chat_bubble.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  final _controller = ScrollController();
  List<Message> messagesList = [];

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // for the return arrow
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            const Text('Scholar Chat'),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: ((context, state) => {
                    if (state is ChatSuccess)
                      {
                        messagesList = state.messages,
                      }
                  }),
              builder: (context, state) {
                return ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBubble(
                              message: messagesList[index],
                            )
                          : ChatBubbleForFriend(message: messagesList[index]);
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: data, email: email);
                controller.clear();
                _controller.animateTo(0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn);
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffix: const Icon(
                  Icons.send,
                  color: kPrimaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: kPrimaryColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
