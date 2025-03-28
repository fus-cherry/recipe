part of 'message_bloc.dart';

sealed class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class MessageInitialEvent extends MessageEvent {
  const MessageInitialEvent();
}

class GetMessageEvent extends MessageEvent {
  const GetMessageEvent();
}

class SendMessageEvent extends MessageEvent {
  final String message;
  const SendMessageEvent({required this.message});
}
