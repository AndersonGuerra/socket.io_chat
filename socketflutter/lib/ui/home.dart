import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final channel = IOWebSocketChannel.connect(
      "ws://socketiochatflutter.herokuapp.com/socket.io/?EIO=3&transport=websocket");
  List<String> messages;
  @override
  void initState() {
    super.initState();
    messages = new List();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String data = snapshot.data.substring(2, snapshot.data.length);
            if (data.length > 0) {
              data = data.replaceAll("[", "").replaceAll("]", "");
              var test = data.split(",");
              messages.add(test[1].replaceAll('"', ''));
            }
            return Scaffold(
              appBar: AppBar(
                title: Text("websocket e blabla"),
              ),
              body: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text(messages[index]),
                  );
                },
              ),
            );
          } else {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
