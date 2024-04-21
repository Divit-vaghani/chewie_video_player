import 'package:chewie_example/app/network_player.dart';
import 'package:chewie_example/app/theme.dart';
import 'package:flutter/material.dart';

const String url = 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4';

class ChewieDemo extends StatefulWidget {
  const ChewieDemo({
    Key? key,
    this.title = 'Chewie Demo',
  }) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _ChewieDemoState();
}

class _ChewieDemoState extends State<ChewieDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light.copyWith(
        platform: TargetPlatform.iOS,
      ),
      debugShowCheckedModeBanner: false,
      title: widget.title,
      home: Scaffold(
        appBar: AppBar(title: Text(widget.title), centerTitle: true),
        body: ListView(
          children: List.generate(30, (index) => index)
              .map(
                (e) => const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text('Dolly Sharma'),
                      subtitle: Text('Last seen 2 hours ago'),
                    ),
                    NetworkPlayer(url: url),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
