import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_io_client/socket_io_client.dart';

class CryptoPriceSocket {
  static initPriceSocket() {
    final socket = io.io(
        'wss://stream.binance.com:9443/ws/',
        // <String, dynamic>{
        //   'transports': ['websocket'],
        //   // 'autoConnect': false,
        //   'origin': '*',
        // },
        OptionBuilder().setTransports(['websocket']).setExtraHeaders(
            {"origin": "*"}).build());

    socket.connect();
    socket.on('new-trade', (data) {
      log('Received message: $data');
    });
    socket.onConnect((_) {
      socket.emit('join', {'new-trade': 'B-XRP_USDT'});
      log('Connected to the crypto socket server');
    });
    socket.onConnectError((data) => log("error " + data.toString()));
  }
}
