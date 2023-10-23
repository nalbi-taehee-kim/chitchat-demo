import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matching_prototype/chitchat_websocket_service.dart';

final chitchatWebsocketProvider = StreamProvider((ref) {
  final service = ChitchatWebsocketService(url: "wss://chitchat-dev.apla.world", shouldConnect: true, token: "111");
  ref.onDispose(() {
    service.dispose();
  });
  return service.stream;
});
