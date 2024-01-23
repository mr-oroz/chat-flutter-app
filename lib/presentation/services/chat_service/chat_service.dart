import 'package:chat_flutter_app/presentation/models/chat_message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  // создадим сообщение
  Future<void> sendMessage(String receiverId, String message) async {
    // почучаем инфо про пользователь
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // создадим новый сообшение
    ChatMessageModel newMessage = ChatMessageModel(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp,
        isReady: false);

    // конструктор
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');
    // добавим новый сообщение на база
    await _store
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('message')
        .add(newMessage.toMap());
  }

  // получаем сообшение

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return _store
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  // определеам если прочиталь смс тогда сделаем isRead true;
  void markMessageAsRead(
      String uid, String currentId,  String messageId) async {
    try {
      List<String> ids = [uid, currentId];
      ids.sort();
      String chatRoomId = ids.join('_');
      await _store
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('message')
          .doc(messageId)
          .update(
        {'isReady': true},
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // определяем день сообщение
  String getMessageDateLabel(Timestamp messageTimestamp) {
    DateTime now = DateTime.now();
    DateTime messageDate = messageTimestamp.toDate();

    // Определение, является ли дата сегодняшней
    bool isToday = messageDate.year == now.year &&
        messageDate.month == now.month &&
        messageDate.day == now.day;

    // Определение, является ли дата вчерашней
    DateTime yesterday = now.subtract(const Duration(days: 1));
    bool isYesterday = messageDate.year == yesterday.year &&
        messageDate.month == yesterday.month &&
        messageDate.day == yesterday.day;

    if (isToday) {
      return 'Сегодня';
    } else if (isYesterday) {
      return 'Вчера';
    } else {
      // Форматирование даты, если она не сегодня и не вчера
      return DateFormat('dd.MM.yyyy').format(messageDate);
    }
  }

  // последный сообщение дата время
  String lastDateMessage(Timestamp messageTimestamp) {
    var timestamp = messageTimestamp;
    var messageTime = timestamp.toDate();
    var currentTime = DateTime.now();
    var difference = currentTime.difference(messageTime);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} минут назад';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} часов назад';
    } else {
      // Форматируем дату, если разница больше одного дня
      return DateFormat('dd.MM.yyyy').format(messageTime);
    }
  }

  // Группировка Сообщений по Датам
  Map<String, List<DocumentSnapshot>> groupMessagesByDate(
      List<DocumentSnapshot> messages) {
    Map<String, List<DocumentSnapshot>> groupedMessages = {};

    for (var message in messages) {
      // Предполагается, что у вас есть поле timestamp в данных сообщения
      String dateLabel = getMessageDateLabel(message['timestamp']);
      if (!groupedMessages.containsKey(dateLabel)) {
        groupedMessages[dateLabel] = [];
      }
      groupedMessages[dateLabel]!.add(message);
    }
    return groupedMessages;
  }
}
