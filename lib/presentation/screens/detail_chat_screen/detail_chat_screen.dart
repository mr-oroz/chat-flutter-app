import 'package:chat_flutter_app/presentation/services/chat_service/chat_service.dart';
import 'package:chat_flutter_app/presentation/theme/app_color.dart';
import 'package:chat_flutter_app/presentation/theme/app_fonts.dart';
import 'package:chat_flutter_app/presentation/widgets/bottom_input_widget/bottom_input_widget.dart';
import 'package:chat_flutter_app/presentation/widgets/card_message_widget/card_message_widget.dart';
import 'package:chat_flutter_app/presentation/widgets/custom_date_chat/custom_date_chat.dart';
import 'package:chat_flutter_app/presentation/widgets/my_circle_avatar/my_cirle_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class DetailChatScreen extends StatefulWidget {
  const DetailChatScreen({
    super.key,
    required this.name,
    required this.active,
    required this.getRandomGradient,
    required this.login,
    required this.receiverId,
  });

  final String name;
  final String login;
  final String receiverId;

  final String active;
  final Gradient Function() getRandomGradient;

  @override
  State<DetailChatScreen> createState() => _DetailChatScreenState();
}

class _DetailChatScreenState extends State<DetailChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ScrollController _scrollController = ScrollController();

  void senMessage() async {
    if (_messageController.text.isNotEmpty) {
      await chatService.sendMessage(widget.receiverId, _messageController.text);

      // очистка textfield
      _messageController.clear();

      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        centerTitle: false,
        title: Row(
          children: [
            MyCircleAvatar(
              getRandomGradient: widget.getRandomGradient,
              name: widget.login,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: AppFonts.w500f16.copyWith(color: Colors.black),
                ),
                Text(
                  'В сети',
                  style: AppFonts.w500f12.copyWith(color: AppColors.textGrey1),
                ),
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: _buildWidgetMessageList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomInputWidget(
        controller: _messageController,
        sendMessage: senMessage,
      ),
    );
  }

  Widget _buildWidgetMessageList() {
    return StreamBuilder(
      stream:
          chatService.getMessages(widget.receiverId, _auth.currentUser!.uid),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var groupedMessages =
            chatService.groupMessagesByDate(snapshot.data!.docs);
        var dates = groupedMessages.keys.toList()..sort();
        // Создание списка виджетов, начиная с последних сообщений

        // CustomDateChat(date: date)
        return ListView.builder(
          reverse: true,
          controller: _scrollController,
          itemCount: dates.length,
          itemBuilder: (context, index) {
            var message = snapshot.data!.docs[index];
            var data = message.data() as Map<String, dynamic>;
            if (data['isReady'] == false) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  chatService.markMessageAsRead(
                    widget.receiverId,
                    _auth.currentUser!.uid,
                    message.id,
                  );
                }
              });
            }
            var date = dates[index];
            var messages = groupedMessages[date]!;
            // Сортируем сообщения в порядке возрастания (старые сообщения вверху)
            messages.sort((a, b) {
              var aData = a.data() as Map<String, dynamic>;
              var bData = b.data() as Map<String, dynamic>;
              var aTimestamp = aData['timestamp'];
              var bTimestamp = bData['timestamp'];
              return aTimestamp.compareTo(bTimestamp);
            });
            return Column(
              children: [
                CustomDateChat(date: date), // Виджет для отображения даты
                Column(
                  children: messages
                      .map((document) =>
                          _buildWidgetMessageItem(document, message.id))
                      .toList(),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildWidgetMessageItem(DocumentSnapshot document, String messageId) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var isOwnMessage = (data['senderId'] == _auth.currentUser!.uid);
    var aligment = isOwnMessage ? Alignment.centerLeft : Alignment.centerRight;
    return  CardMessageWidget(
          aligment: aligment, isOwnMessage: isOwnMessage, data: data);
  }
}
