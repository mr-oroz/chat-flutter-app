import 'package:chat_flutter_app/presentation/screens/detail_chat_screen/detail_chat_screen.dart';
import 'package:chat_flutter_app/presentation/widgets/chat_item_widget/chat_item_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({
    super.key,
    required this.getRandomGradient,
  });

  final Gradient Function() getRandomGradient;

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var chatItems = snapshot.data!.docs.map<Widget>((doc) {
          return _buildUserListItem(doc);
        }).toList();
        return ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: chatItems);
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot<Object?> document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (_auth.currentUser!.email != data['email']) {
      return ChatItemWidget(
        name: data['email'] ?? '',
        receiverId: data['uid'],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailChatScreen(
                receiverId: data['uid'],
                name: data['email'],
                active: '',
                getRandomGradient: widget.getRandomGradient,
                login: 'OO',
              ),
            ),
          );
        },
        getRandomGradient: widget.getRandomGradient,
      );
    } else {
      return Container();
    }
  }
}
