import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad/blocs/message_bloc/message_bloc.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  void initState() {
    context.read<MessageBloc>().add(MessageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        // Check if the channel is null or not yet initialized
        if (state.channel == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text("webSocket ",
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            body: Center(child: Text("No WebSocket channel connected")),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("webSocket demo",
                style: Theme.of(context).textTheme.headlineSmall),
          ),
          body: Column(
            children: [
              StreamBuilder(
                stream:
                    state.channel, // Use the channel from the state directly
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    return Text("Message: ${snapshot.data}");
                  } else {
                    return Text("No data received");
                  }
                },
              ),
              ElevatedButton(
                onPressed: () {
                  sendMessage(context, "message");
                },
                child: Text('Send Message'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> sendMessage(BuildContext context, String message) async {
    context.read<MessageBloc>().add(SendMessageEvent(message: message));
  }
}
