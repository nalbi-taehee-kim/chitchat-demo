import 'dart:async';
import 'dart:developer';
import 'package:web_socket_channel/io.dart';

class ChitchatWebsocketService {
  static const Duration pingInterval = Duration(seconds: 5);

  final String url;
  final String token;
  late IOWebSocketChannel _channel;
  late StreamController<List<String>> _usersController;
  bool _shouldConnect;
  List<String> _users = [];
  Timer? _pingTimer;

  ChitchatWebsocketService({required this.url, required bool shouldConnect, required this.token}) : _shouldConnect = shouldConnect {
    _usersController = StreamController<List<String>>();
    initializeConnection();
  }

  Stream<dynamic> get stream => _usersController.stream;

  void initializeConnection() {
    log("initializeConnection");
    _channel = IOWebSocketChannel.connect('$url?token=$token');
    _channel.stream.listen((event) {
      log("websocket raw message : $event");
      _usersController.add(event);
    });

    _pingTimer = Timer.periodic(pingInterval, (timer) {
      _channel.sink.add("ping");
    });
  }

  void _handleEvent(Map<String, dynamic> event) {
    final eventType = event["eventType"] ?? '';
    final source = event["source"] ?? '';
  }

  void setShouldConnect(bool shouldConnect) {
    _shouldConnect = shouldConnect;
  }

  void _reconnect() {
  }

  void dispose() {
    _shouldConnect = false;
    _pingTimer?.cancel();
    _channel.sink.close();
    _usersController.close();
  }
}