import 'dart:typed_data';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:turbovets/core/components/gradient_wrapper.dart';
import 'package:turbovets/core/utils/colors.dart';
import '../../core/controllers/global_provider.dart';
import '../../core/models/chat_message.dart';
import '../../core/services/chat_service.dart';
import 'components/chat_bubble.dart';
import 'components/typing_indicator.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  
  late Box<ChatMessage> _messageBox;
  bool _isLoading = true;
  bool _isTyping = false;
  bool _showEmojiPicker = false;
  Uint8List? _selectedImageBytes;

  final Map<dynamic, Uint8List> _ephemeralImages = {};

  @override
  void initState() {
    super.initState();
    _initHiveAndService();
  }

  Future<void> _initHiveAndService() async {
    _messageBox = await Hive.openBox<ChatMessage>('chat_history');

    final history = _messageBox.values.map((msg) {
      return msg.isUser 
          ? Content.text(msg.text) 
          : Content.model([TextPart(msg.text)]);
    });

    ChatService().initialize(history: history);

    if (mounted) {
      setState(() => _isLoading = false);
      _scrollToBottom();
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _selectedImageBytes = bytes;
      });
    }
  }

  Future<void> _sendMessage({String? retryText, int? retryIndex}) async {
    final text = retryText ?? _textController.text.trim();
    if (text.isEmpty && _selectedImageBytes == null) return;

    final imageToSend = _selectedImageBytes;

    if (retryText == null) {
      final userMsg = ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
        status: MessageStatus.sent,
        imageBytes: null, 
      );
      
      final key = await _messageBox.add(userMsg);
      
      if (imageToSend != null) {
        _ephemeralImages[key] = imageToSend;
      }
      
      _textController.clear();
      setState(() {
        _selectedImageBytes = null;
        _showEmojiPicker = false;
      });
      _scrollToBottom();
    } else {
       final msg = _messageBox.getAt(retryIndex!)!;
       msg.status = MessageStatus.sending;
       msg.save();
    }

    setState(() => _isTyping = true);

    try {
      final responseText = await ChatService().sendMessage(
        text.isEmpty ? "Describe the image" : text, 
        imageBytes: imageToSend,
      );
      
      final aiMsg = ChatMessage(
        text: responseText,
        isUser: false,
        timestamp: DateTime.now(),
      );
      await _messageBox.add(aiMsg);

    } catch (e) {
      if (_messageBox.isNotEmpty) {
        final lastMsg = _messageBox.values.lastWhere((m) => m.isUser);
        lastMsg.status = MessageStatus.error;
        lastMsg.save();
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to send. Tap to retry.")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isTyping = false);
        _scrollToBottom();
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return GradientWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TurboVets Agent'),
          backgroundColor: whiteColor.withValues(alpha: 0),
          actions: [
            IconButton(
              icon: const Icon(FluentIcons.delete_12_regular, color: secondaryColor,),
              onPressed: () {
                _messageBox.clear();
                setState(() {_ephemeralImages.clear();});
                ChatService().initialize(history: []);
              },
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _messageBox.listenable(),
                builder: (context, Box<ChatMessage> box, _) {
                  final messages = box.values.toList();
                  return messages.isEmpty ? Center(child: Icon(FluentIcons.bot_sparkle_20_regular, size: 150, color: Theme.of(context).dividerColor,),) : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length + (_isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == messages.length) return const TypingIndicator();
                      final msg = messages[index];
                      final displayImage = _ephemeralImages[msg.key];
                      return ChatBubble(
                        message: msg, 
                        imageBytes: displayImage,
                        onRetry: () => _sendMessage(retryText: msg.text, retryIndex: index)
                      );
                    },
                  );
                },
              ),
            ),
            _buildInputArea(),
            if (_showEmojiPicker)
              SizedBox(
                height: 250,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    _textController.text = _textController.text + emoji.emoji;
                  },
                  config: const Config(emojiViewConfig: EmojiViewConfig(columns: 7, emojiSizeMax: 32),),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    bool isDark = Provider.of<GlobalProvider>(context).isDark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      color: Colors.transparent,
      child: SafeArea(
        child: Column(
          children: [
            if (_selectedImageBytes != null)
              Container(
                height: 100,
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(_selectedImageBytes!),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => setState(() => _selectedImageBytes = null),
                    )
                  ],
                ),
              ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.emoji_emotions_outlined, 
                    color: _showEmojiPicker ? Colors.blue : Colors.grey),
                  onPressed: () {
                    setState(() {
                      _showEmojiPicker = !_showEmojiPicker;
                      if (_showEmojiPicker) FocusScope.of(context).unfocus();
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.grey),
                  onPressed: _pickImage,
                ),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    focusNode: FocusNode()..addListener(() {
                      if (FocusScope.of(context).hasFocus) {
                        setState(() => _showEmojiPicker = false);
                      }
                    }),
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      filled: true,
                      fillColor: isDark ? Colors.transparent : whiteColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: isDark ? Theme.of(context).secondaryHeaderColor : Colors.grey[200]!),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                    //onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: FloatingActionButton(
                    shape: CircleBorder(),
                    backgroundColor: primaryColor,
                    child: Icon(Icons.send, color: Theme.of(context).scaffoldBackgroundColor, size: 20),
                    onPressed: () => _sendMessage(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}