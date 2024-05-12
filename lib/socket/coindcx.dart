import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class CoinDCXWebSocketExample extends StatefulWidget {
  @override
  _CoinDCXWebSocketExampleState createState() =>
      _CoinDCXWebSocketExampleState();
}

class _CoinDCXWebSocketExampleState extends State<CoinDCXWebSocketExample> {
  final channel = IOWebSocketChannel.connect('wss://stream.coindcx.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CoinDCX WebSocket Example'),
      ),
      body: StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.hasData) {
            // Parse and handle the received data
            // For example, you can use json.decode(snapshot.data) if the data is JSON
            return Text('Received: ${snapshot.data}');
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
