import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:aeyrium_sensor/aeyrium_sensor.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:async';

double x = 0.0, y = 0.0;

bool i = true;
String schannel;

class Gacce extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(
        channel: IOWebSocketChannel.connect('wss://tbmatekl.com/wss2/NNN'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final WebSocketChannel channel;
  MyHomePage({Key key, @required this.channel}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSubscription<dynamic> _streamSubscriptions;

  @override
  void initState() {
    while (i) {
      print("subscribing..");
      widget.channel.sink.add('{"command":"subscribe", "channel":"$schannel"}');
      i = false;
    }
    print("messaging..");

    _streamSubscriptions = AeyriumSensor.sensorEvents.listen((event) {
      setState(() {
        x = event.roll * -2.5;
        y = event.pitch * 2.5;
      });

      // x = x - 5.5;
      // y = y + 3.8;
      // print('$x  $y');
      widget.channel.sink.add(
          '{"command": "message", "message": "${x.toStringAsFixed(1)},${y.toStringAsFixed(1)}"}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          child: VStack([
        Image(image: AssetImage('assets/mobileIcon.jpeg')).centered(),
        Padding(padding: EdgeInsets.only(top: 62)),
        "Slowly tilt & pan your phone to search"
            .text
            .size(18)
            .color(Colors.grey)
            .makeCentered(),
        "the sound of Kuala Lampur."
            .text
            .size(18)
            .color(Colors.grey)
            .makeCentered(),
        Padding(padding: EdgeInsets.only(top: 20)),
        "Guess the location by listening to it."
            .text
            .size(18)
            .color(Colors.lightBlue[100])
            .makeCentered(),
        Padding(padding: EdgeInsets.only(top: 20)),
        "${x.toStringAsFixed(1)}  ${y.toStringAsFixed(1)}"
            .text
            .size(18)
            .color(Colors.lightBlue[100])
            .makeCentered(),
      ])).centered(),
    );
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}
