import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BinanceSocket extends StatefulWidget {
  @override
  _BinanceSocketState createState() => _BinanceSocketState();
}

class _BinanceSocketState extends State<BinanceSocket> {
  final WebSocketChannel channel = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/btcusdt@trade');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Binance WebSocket Example'),
      ),
      body: StreamBuilder(
        stream: channel.stream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          // You can handle and display the WebSocket data here
          return Center(
            child: Text('Received data: ${snapshot.data}'),
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
