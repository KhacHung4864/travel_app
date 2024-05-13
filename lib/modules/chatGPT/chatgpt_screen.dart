import 'dart:convert';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/constants/consts.dart';
import 'package:travel_app/data/model/places/place_model.dart';

class ChatGPTScreen extends StatefulWidget {
  const ChatGPTScreen({super.key});

  @override
  State<ChatGPTScreen> createState() => _ChatGPTScreenState();
}

class _ChatGPTScreenState extends State<ChatGPTScreen> {
  Places? placeItem = Get.arguments[0];

  final _openAI = OpenAI.instance.build(
      token: OPENAI_API_KEY,
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 5),
      ),
      enableLog: true);

  final ChatUser _user = ChatUser(
    id: '1',
    firstName: 'Charles',
    lastName: 'Leclerc',
  );

  final ChatUser _gptChatUser = ChatUser(
    id: '2',
    firstName: 'Chat',
    lastName: 'GPT',
  );

  List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  void initState() {
    super.initState();
    if (placeItem != null) {
      loadMessages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 166, 126, 1),
        title: const Text(
          'GPT Chat',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: DashChat(
        currentUser: _user,
        messageOptions: const MessageOptions(
          currentUserContainerColor: Colors.black,
          containerColor: Color.fromRGBO(0, 166, 126, 1),
          textColor: Colors.white,
        ),
        onSend: (ChatMessage m) {
          getChatResponse(m);
        },
        messages: _messages,
        typingUsers: _typingUsers,
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m, {bool? isFirst = false}) async {
    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_gptChatUser);
    });
    List<Map<String, dynamic>> messagesHistory = _messages.reversed.toList().map((m) {
      if (m.user == _user) {
        return Messages(role: Role.user, content: m.text).toJson();
      } else {
        return Messages(role: Role.assistant, content: m.text).toJson();
      }
    }).toList();
    final request = ChatCompleteText(
      messages: messagesHistory,
      maxToken: 200,
      model: GptTurbo0301ChatModel(),
    );
    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.insert(0, ChatMessage(user: _gptChatUser, createdAt: DateTime.now(), text: element.message!.content));
        });
        // Lưu tin nhắn vào local theo ID cuộc trò chuyện

        await saveMessage(placeItem?.id.toString() ?? '', m);

        await saveMessage(placeItem?.id.toString() ?? '', ChatMessage(user: _gptChatUser, createdAt: DateTime.now(), text: element.message!.content));
      }
    }
    setState(() {
      _typingUsers.remove(_gptChatUser);
    });
  }

  Future<void> saveMessage(String chatId, ChatMessage message) async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = prefs.getStringList(chatId) ?? [];
    messagesJson.insert(0, jsonEncode(message.toJson()));
    await prefs.setStringList(chatId, messagesJson);
  }

  Future<List<ChatMessage>> getMessages(String chatId) async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = prefs.getStringList(chatId) ?? [];
    return messagesJson.map((json) => ChatMessage.fromJson(jsonDecode(json))).toList();
  }

  Future<void> loadMessages() async {
    // Tải tin nhắn từ local theo ID cuộc trò chuyện
    final messages = await getMessages(placeItem?.id.toString() ?? '');
    setState(() {
      _messages = messages;
    });
    if (_messages.isEmpty) {
      getChatResponse(
        ChatMessage(
          text: 'Tư vấn về địa điểm du lịch ${placeItem?.name}',
          user: _user,
          createdAt: DateTime.now(),
        ),
        isFirst: true,
      );
    }
  }
}
