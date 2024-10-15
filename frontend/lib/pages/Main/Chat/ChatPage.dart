// ignore_for_file: prefer_conditional_assignment

import 'dart:convert';
import 'package:flings_flutter/routes/imageURL.dart';
import 'package:flings_flutter/styles/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flings_flutter/Providers/StreamSocket.dart';
import 'package:flings_flutter/Themes/themes.dart';
import 'package:flings_flutter/components/DropDown/CallingOptionsDropDown.dart';
import 'package:flings_flutter/Practice/Calling/VideoCallViaWebRTC.dart';
import 'package:flings_flutter/routes/apiStrings.dart';
import 'package:flings_flutter/services/InterceptedHTTP.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChatPage extends StatefulWidget {
  final String? targetUserID;
  final String? userName;
  final String? gender;
  final String? currentUserId;
  final String? matchId;

  ChatPage({
    super.key,
    required this.targetUserID,
    required this.userName,
    this.gender,
    this.matchId,
    this.currentUserId,
  });

  @override
  State createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextEditingController messageController;
  late StreamSocket socket;
  late FlutterSecureStorage storage;
  final List<Map<String, String>> _messages = [];
  String? currentUserId;
  final Set<String> _messageIds = {};

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
    storage = const FlutterSecureStorage();
    socket = StreamSocket();
    _initializeCurrentUser();
    socket.chatStream.listen((messageData) {
       _handleIncomingMessage(messageData);
     });
  }

  Future<void> _initializeCurrentUser() async {
    currentUserId = await storage.read(key: 'currentUserId');
    setState(() {});
  }

  String _uniqueMessageId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  @override
  void dispose() {
    messageController.dispose();
    socket.dispose();
    super.dispose();
  }

  Future<void> _sendMessageFunction(
      String matchId, String message, String targetUserID) async {
    if (currentUserId == null) {
      currentUserId =
          await storage.read(key: 'currentUserId') ?? "No CurrentUserID";
    }

    if (currentUserId != null) {
      var data = {
        'matchId': matchId,
        'message': message,
        'targetUserID': targetUserID,
      };

      try {
        var response = await InterceptedHTTP().postHttp(SEND_MESSAGE, data);
        if (response.statusCode == 200) {
          var decodedResponseBody = jsonDecode(response.body);
          debugPrint("Message sent Successfully. $decodedResponseBody");

          // Add message to local list
          _addMessage(message, currentUserId!);
        } else {
          var decodedErrorResponseBody = jsonDecode(response.body);
          debugPrint("Error in sending Message: ${decodedErrorResponseBody['error']}");
          _showErrorSnackbar(decodedErrorResponseBody['error']);
        }
      } catch (e) {
        debugPrint("Error in Sending Message: ${e.toString()}");
        _showErrorSnackbar("Failed to send message. Please try again.");
      }
    } else {
      debugPrint("Current User ID is null");
      _showErrorSnackbar("Current User ID is not available.");
    }
  }

  void _addMessage(String message, String senderId) {
    setState(() {
      _messages.add({
        'message': message,
        'from': senderId,
        'id': _uniqueMessageId(),
      });
    });
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: StreamBuilder<Map<String, String>>(
              stream: socket.chatStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  final messageData = snapshot.data!;

                  if (messageData.containsKey('message') &&
                      messageData.containsKey('from') &&
                      messageData.containsKey('id')) {
                    _handleIncomingMessage(messageData);
                    return MessageList(messages: _messages, currentUserId: currentUserId);
                  } else {
                    return const Center(child: Text('Invalid message data received'));
                  }
                }

                return Center(child: Text('No Messages', style: blackBoldText));
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  void _handleIncomingMessage(Map<String, String> messageData) {
    String messageText = messageData['message']!;
    String fromUser = messageData['from']!;
    String messageId = messageData['id']!;

    debugPrint("Incoming message: $messageText from: $fromUser with ID: $messageId");

    if (!_messageIds.contains(messageId)) {
      _messageIds.add(messageId);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _addMessage(messageText, fromUser);
      });
    } else {
      debugPrint("Duplicate message detected: $messageText");
    }
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _buildUserInfo(),
          _buildCallOptions(),
        ]),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        CircleAvatar(
          backgroundImage:
              NetworkImage(widget.gender == 'Male' ? MALE_AVATAR : FEMALE_AVATAR),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.userName ?? "Unknown",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
            Text("Online", style: greenNoramlText),
          ],
        ),
      ],
    );
  }

  Widget _buildCallOptions() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoCallViaWebRTC(remoteUserId: widget.targetUserID!),
              ),
            );
          },
          icon: const Icon(CupertinoIcons.video_camera, color: Colors.white),
        ),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const CallingOptionDropDown(),
                );
              },
            );
          },
          icon:
              const Icon(Icons.more_vert_rounded, color: Colors.white, size: 25),
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: messageController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(gapPadding: 2, borderRadius: BorderRadius.circular(50), borderSide:
                        BorderSide(color:
                            MyTheme.primaryColor)),
                hintText:
                    "Enter message here",
                prefixIcon:
                    IconButton(onPressed:
                        () {},
                      icon:
                          const Icon(Icons.emoji_emotions_outlined),
                    ),
              ),
            ),
          ),
          const SizedBox(width:
              5),
          IconButton(
            padding:
                const EdgeInsets.all(10),
            style:
                ButtonStyle(backgroundColor:
                    MaterialStateProperty.all(MyTheme.primaryColor), shape:
                    MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:
                        BorderRadius.circular(50),))),
            onPressed:
                () {
              String sendMessage =
                  messageController.text.trim();
              if (sendMessage.isNotEmpty) {
                _sendMessageFunction(widget.matchId!, sendMessage, widget.targetUserID!);
                messageController.clear(); // Clear the input field after sending
              } else {
                debugPrint("Message Controller is Empty, Nothing to send!");
                _showErrorSnackbar("Please enter a message.");
              }
            },
            icon:
                const Icon(Icons.send, color:
                    Colors.black),
          ),
        ],
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  final List<Map<String, String>> messages;
  final String? currentUserId;

  const MessageList({super.key, required this.messages, this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:
          messages.length,
      itemBuilder:
          (context, index) {
        String message =
            messages[index]['message']!;
        String fromUserId =
            messages[index]['from']!;
        String id =
            messages[index]['id']!;

        return
            _buildChatBubble(message,
                fromUserId,
                id);
      },
    );
  }

  Widget
      _buildChatBubble(String
      message,
      String fromUserId,
      String id) {
    bool isCurrentUserMessage =
        fromUserId == currentUserId;

    return ListTile(
      key:
          ValueKey(id),
      title:
          Align(alignment:
              isCurrentUserMessage ? Alignment.centerRight : Alignment.centerLeft,
            child:
            Container(padding:
            const EdgeInsets.all(10), decoration:
            BoxDecoration(color:isCurrentUserMessage ? Colors.black : MyTheme.primaryColor,borderRadius:
            BorderRadius.circular(20),),child:
            Text(message,style:
            TextStyle(color:isCurrentUserMessage ? Colors.white : Colors.black,),),),),);
}
}