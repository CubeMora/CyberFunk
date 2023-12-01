// ignore_for_file: depend_on_referenced_packages,

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:security_info_project/src/models/video_class.dart';
import 'package:video_player/video_player.dart';

import 'package:security_info_project/src/pages/module_1/quiz_screen.dart';
import 'package:security_info_project/src/widgets/ButtonGeneralAction.dart';
import 'package:security_info_project/src/widgets/CyberFunkAppBar.dart';

class VideoCourseScreen extends StatefulWidget {
  const VideoCourseScreen({super.key, required this.classInfo});

  final VideoClass classInfo;

  @override
  State<VideoCourseScreen> createState() => _VideoCourseScreenState();
}

class _VideoCourseScreenState extends State<VideoCourseScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _videoEnded = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.network(widget.classInfo.videoUrl);

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9, // Adjust this value to change the aspect ratio
      autoInitialize: false,

      looping: false,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );

    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.position ==
          _videoPlayerController.value.duration) {
        _videoEnded = true;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CyberFunkAppBar(),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.menu_book_outlined),
            title: const Text('Video lección: '),
            subtitle: Text(widget.classInfo.title),
          ),
          const Divider(
            indent: 30.0,
            endIndent: 30.0,
            thickness: 1.5,
          ),

          //HERE GOES THE VIDEO PLAYER

          Container(
            height: 300.0,
            margin: const EdgeInsets.all(50.0),
            child: Chewie(controller: _chewieController),
          ),

          _videoEnded
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 20.0),
                  child: buttonGeneralAction("Comenzar Quiz", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(quizPath: widget.classInfo.questionPoolPath),
                      ),
                    );
                  }),
                )
              : const SizedBox(),

          ListTile(
            title: const Text('Resumen'),
            subtitle: Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                const Divider(
                  height: 2.0,
                  indent: 10.0,
                  endIndent: 10.0,
                ),
                const SizedBox(height: 10.0),
                Text(widget.classInfo.summary, textAlign: TextAlign.left, style: GoogleFonts.inter(),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
