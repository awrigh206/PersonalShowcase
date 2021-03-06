// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:showcase/Models/Commit.dart';
import 'package:showcase/Models/Project.dart';

class AsyncCommitDisplay extends StatelessWidget {
  final Project project;
  final Future<List<Commit>> commitFuture;
  const AsyncCommitDisplay(
      {Key? key, required this.project, required this.commitFuture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        borderOnForeground: true,
        elevation: 20.0,
        shadowColor: Colors.blueGrey,
        child: FutureBuilder(
            future: commitFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Commit> commitList = snapshot.data as List<Commit>;
                return ListView.builder(
                    itemCount: commitList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const ListTile(
                          tileColor: Colors.blueAccent,
                          leading: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Author',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text('Commit Message',
                              style: TextStyle(color: Colors.white)),
                          trailing: Text('Commit/Merge',
                              style: TextStyle(color: Colors.white)),
                        );
                      }
                      return ListTile(
                        leading: Text(commitList[index].name),
                        title: Text(commitList[index].message),
                        subtitle: Text(commitList[index].date),
                        trailing: Builder(
                          builder: (context) {
                            if (commitList[index]
                                .message
                                .toLowerCase()
                                .contains('merge')) {
                              return const Icon(Icons.merge_type);
                            } else {
                              return const Icon(Icons.comment_outlined);
                            }
                          },
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("Error: " + snapshot.error.toString());
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
