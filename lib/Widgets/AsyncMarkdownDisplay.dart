import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AsyncMarkdownDisplay extends StatelessWidget {
  final Future<String> textFuture;
  const AsyncMarkdownDisplay({Key? key, required this.textFuture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: textFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String text = snapshot.data as String;
              return Markdown(shrinkWrap: true, data: text);
            } else if (snapshot.hasError) {
              return Text("Error: " + snapshot.error.toString());
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
