import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatScreen extends StatefulWidget {
  final String employeeName;

  const ChatScreen({super.key, required this.employeeName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final Map<String, List<Map<String, String>>> _userMessages = {};

  String get apiKey => dotenv.env['CHAT_GPT_API_KEY']!;
  late final String userId = widget.employeeName;

  @override
  void initState() {
    super.initState();
    if (!_userMessages.containsKey(userId)) {
      _userMessages[userId] = [];
    }
  }

  Future<String> _getChatGptResponse(String message, String userId) async {
    const apiUrl = 'https://api.openai.com/v1/chat/completions';

    final List<Map<String, String>> conversationHistory = _userMessages[userId]!
        .map((msg) => {
              "role": msg['sender'] == userId ? "user" : "assistant",
              "content": msg['message']!
            })
        .toList();
    conversationHistory.add({"role": "user", "content": message});

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": conversationHistory,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'].trim();
    } else {
      print('Failed to get response from ChatGPT: ${response.body}');
      return 'Failed to get response from ChatGPT';
    }
  }

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _userMessages[userId]!
            .add({"sender": userId, "message": _controller.text});
      });

      final response = await _getChatGptResponse(_controller.text, userId);
      _controller.clear();

      setState(() {
        _userMessages[userId]!
            .add({"sender": "Assistant", "message": response});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final messages = _userMessages[userId]!;

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUserMessage = message['sender'] == userId;
                return Align(
                  alignment: isUserMessage
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF77AD78),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message['sender']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          message['message']!,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
