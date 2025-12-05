import 'package:hive_ce/hive.dart';
import 'dart:typed_data'; 

enum MessageStatus { sending, sent, error }

@HiveType(typeId: 0)
class ChatMessage extends HiveObject {
  @HiveField(0)
  final String text;

  @HiveField(1)
  final bool isUser;

  @HiveField(2)
  final DateTime timestamp;

  @HiveField(3)
  MessageStatus status;

  // Not HiveField - this will NOT be saved locally
  final Uint8List? imageBytes;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.status = MessageStatus.sent,
    this.imageBytes,
  });
}

class ChatMessageAdapter extends TypeAdapter<ChatMessage> {
  @override
  final int typeId = 0;

  @override
  ChatMessage read(BinaryReader reader) {
    return ChatMessage(
      text: reader.read(),
      isUser: reader.read(),
      timestamp: reader.read(),
      status: MessageStatus.values[reader.read()],
      // imageBytes is always null when reading from disk
      imageBytes: null, 
    );
  }

  @override
  void write(BinaryWriter writer, ChatMessage obj) {
    writer.write(obj.text);
    writer.write(obj.isUser);
    writer.write(obj.timestamp);
    writer.write(obj.status.index);
    // We intentionally DO NOT write imageBytes here
  }
}