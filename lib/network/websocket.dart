import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocket {
  static WebSocket? _instance;

  factory WebSocket() {
    if (_instance == null) {
      _instance = WebSocket._();
    }
    return _instance!;
  }

  WebSocket._() {
    _init();
  }

  static final wsUrl = Uri.parse('wss://echo.websocket.events');

  late WebSocketChannel channel;
  Future<void> _init() async {
    try {
      channel = WebSocketChannel.connect(wsUrl);
      await channel.ready;
    } catch (e) {
      print('WebSocket连接建立失败：$e');
    }
  }

  void send(String message) {
    try {
      channel.sink.add(message);
    } catch (e) {
      print('WebSocket消息发送失败：$e');
    }
  }

  void getMessage() {
    channel.stream.listen((message) {
      print('WebSocket消息接收：$message');
    });
  }
}
