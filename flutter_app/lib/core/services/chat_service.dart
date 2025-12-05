import 'dart:typed_data';
import 'package:firebase_ai/firebase_ai.dart';

import 'global_methods.dart';

class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  late final GenerativeModel _model;
  late ChatSession _chatSession;
  bool _isInitialized = false;

  void initialize({Iterable<Content>? history}) {
    if (_isInitialized) return;

    final systemInstruction = Content.system(
      '''You are a helpful, friendly support agent for TurboVets.
      - Format your answers using Markdown (bold, bullet points) where appropriate.
      - Keep answers concise.
      - If the user sends an image, describe what you see or answer their question about it.
      - Keep in mind that this is an app for american veterans
      - You can use military expressions
      _ You can be funny and crack some jokes from time to time'''
    );

    _model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-2.5-flash',
      systemInstruction: systemInstruction,
    );

    _chatSession = _model.startChat(history: history?.toList());
    _isInitialized = true;
    newPrint("ChatService Initialized");
  }

  Future<String> sendMessage(String userMessage, {Uint8List? imageBytes}) async {
    if (!_isInitialized) initialize();

    try {
      GenerateContentResponse response;

      if (imageBytes != null) {
        final content = Content.multi([
          TextPart(userMessage),
          InlineDataPart('image/jpeg', imageBytes),
        ]);
        response = await _chatSession.sendMessage(content);
      } else {
        response = await _chatSession.sendMessage(Content.text(userMessage));
      }
      playAssetAudio("new_message.mp3");

      return response.text ?? "I'm having trouble understanding.";
    } catch (e) {
      newPrint("AI Error: $e");
      throw Exception("Failed to connect");
    }
  }
}