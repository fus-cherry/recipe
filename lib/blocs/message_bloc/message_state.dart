part of 'message_bloc.dart';

class MessageState extends Equatable {
  final Stream? channel;

  const MessageState({required this.channel});

  factory MessageState.initial() => const MessageState(channel: null);
  @override
  List<Object?> get props => [channel];
}
