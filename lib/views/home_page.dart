
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // TRY THIS: Try changing the color here to a specific color (to
      //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
      //   // change color while the other colors stay the same.
      //   // backgroundColor: Colors.deepPurple,
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text("title",
      //       style: TextStyle(
      //         color: Theme.of(context).colorScheme.primary, // 使用主色
      //       )),
      // ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(margin: const EdgeInsets.all(10.0),width: 50, height: 50, color: Colors.red),
          Container(width: 50, height: 50, color: Colors.green),
          Container(width: 50, height: 50, color: Colors.blue),
        ],
      ),
      );
  }
}