import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final wsUrl = Uri.parse('ws://52.83.183.229:4000');

  late WebSocketChannel _channel;
  MessageBloc() : super(MessageState.initial()) {
    //初始化webSocket连接流程
    on<MessageInitialEvent>(_init);
    on<SendMessageEvent>(sendMessage);
  }

  @override
  Future<void> close() async {
    await _channel.sink.close();
    return super.close();
  }

  Future<void> _init(
      MessageInitialEvent event, Emitter<MessageState> emit) async {
    try {
      // 尝试建立 WebSocket 连接
      _channel = WebSocketChannel.connect(wsUrl);
      await _channel.ready;
      emit(MessageState(channel: _channel.stream));
    } catch (e) {
      if (e is WebSocketChannelException) {
        // 如果是 WebSocketChannelException，获取内部的 WebSocketException
        final innerException = e.inner;
        if (innerException is WebSocketException) {
          // 打印详细的错误信息
          debugPrint('WebSocketException: ${innerException.message}');
        } else {
          // 处理其他类型的内部异常
          debugPrint('其他异常: $innerException');
        }
      } else {
        // 处理其他类型的异常
        debugPrint('未知异常: $e');
      }
    }
  }

  sendMessage(SendMessageEvent event, Emitter<MessageState> emit) {
    _channel.sink.add(event.message);
  }
}
