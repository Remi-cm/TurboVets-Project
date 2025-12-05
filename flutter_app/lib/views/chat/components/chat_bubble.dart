
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:turbovets/core/utils/colors.dart';

import '../../../core/controllers/global_provider.dart';
import '../../../core/models/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback onRetry;
  final Uint8List? imageBytes;

  const ChatBubble({
    super.key, 
    required this.message, 
    required this.onRetry,
    this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<GlobalProvider>(context).isDark;
    final isMe = message.isUser;
    final isError = message.status == MessageStatus.error;
    final displayImage = imageBytes ?? message.imageBytes;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (isMe && isError)
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.red),
              onPressed: onRetry,
            ),
            
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isMe 
                  ? (isError ? Colors.red[100] : primaryColor) 
                  : Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: isMe ? const Radius.circular(20) : Radius.circular(5),
                bottomRight: isMe ? Radius.circular(5) : const Radius.circular(20),
              ),
              border: isDark && !isMe ? Border.all(color: whiteColor.withValues(alpha: 0.5)) : null,
              boxShadow: isDark && !isMe ? null :  [
                BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (displayImage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        displayImage,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                
                if (message.text.isNotEmpty)
                  MarkdownBody(
                    data: message.text,
                    styleSheet: MarkdownStyleSheet(
                      p: TextStyle(
                        color: isMe ? (isError ? Colors.red[900] : Colors.white) : (isDark ? whiteColor.withValues(alpha: 0.9) : Colors.black87),
                        fontSize: 16,
                      ),
                      strong: TextStyle(fontWeight: FontWeight.bold, color: isMe ? Colors.white : (isDark ? whiteColor : blackColor)),
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('h:mm a').format(message.timestamp),
                  style: TextStyle(
                    color: isMe ? Colors.white70 : Colors.grey[600],
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

