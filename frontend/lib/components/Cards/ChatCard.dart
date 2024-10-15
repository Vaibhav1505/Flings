import 'package:flings_flutter/pages/Main/Chat/ChatPage.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatefulWidget {
  final String userName;
  final String previousChat;
  final String userImage;
  final int unreadCount;
  final String lastMessageTime;

  ChatCard({
    required this.userName,
    required this.previousChat,
    required this.userImage,
    required this.unreadCount,
    required this.lastMessageTime,
  });

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  bool isUnreadMessage = false;

  var currentTime = '${DateTime.now().hour}:${DateTime.now().minute}';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        // contentPadding: EdgeInsets.all(16.0),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  targetUserID: '',
                  userName: '',
                
                ),
              ));
        },
        leading: Container(
          height: double.infinity,
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                  image: NetworkImage(
                      'https://imgs.search.brave.com/mC-y-YTPsdM6Y9QYGJN2Qv2r3rFI2ld64MMlbPbCi1M/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTM5/ODkyMTYyNS9waG90/by90b2t5by1qYXBh/bi1pbmRpYW4tcHJp/bWUtbWluaXN0ZXIt/bmFyZW5kcmEtbW9k/aS1hdHRlbmRzLXRo/ZS1xdWFkLWxlYWRl/cnMtc3VtbWl0LW9u/LW1heS0yNC5qcGc_/cz02MTJ4NjEyJnc9/MCZrPTIwJmM9QnEt/dnNFajhRaGc0WnpW/bWQ4bzZmNzVYS1Zi/YkZLcUoxaXpMSVR1/REZBST0'),
                  fit: BoxFit.cover)),
        ),
        title: Text(
          widget.userName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.previousChat,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        trailing: isUnreadMessage
            ? CircleAvatar(
                backgroundColor: Colors.red,
                radius: 12.0,
                child: Text(
                  '${widget.unreadCount}',
                  style: const TextStyle(color: Colors.white, fontSize: 12.0),
                ),
              )
            : Text(currentTime),
      ),
    );
  }
}
