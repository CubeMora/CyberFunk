import 'package:flutter/material.dart';
import 'package:security_info_project/src/pages/quiz_screen.dart';
import 'package:security_info_project/src/widgets/ButtonGeneralAction.dart';
import 'package:security_info_project/src/widgets/CyberFunkAppBar.dart';
import 'package:security_info_project/src/widgets/textNormal.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class VideoCourseScreen extends StatefulWidget {
  const VideoCourseScreen({super.key});

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
    _videoPlayerController = VideoPlayerController.network(
        //'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
        'https://dl.dropboxusercontent.com/s/25kt0glpjda6cdyy5y7jt/Tema-4.-La-importancia-de-contrase-as-seguras-video-converter.com.mp4?rlkey=6wew6x113vnz1dr9jylgx7vlq&dl=0'
        //'https://dl.dropboxusercontent.com/s/8hbimughj1qqms0hpyuhp/Modulo_1_Seguridad_Online_video1.mp4?rlkey=dwmp927xu44v2ro84s7rv6n1g&dl=0'
        //'https://drive.google.com/uc?export=download&id=1f1DDyw1w6al0ewj6EyZ2l_oStikVvj0W',
        //1f1DDyw1w6al0ewj6EyZ2l_oStikVvj0W
        //x1fush3kadnmz3li6nhxc /2023-10-25-21-59-15.mp4
        );

    _chewieController = ChewieController(

      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9, // Adjust this value to change the aspect ratio
      autoInitialize: false,

      looping: false,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );

    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.position ==
          _videoPlayerController.value.duration) {
        _videoEnded = true;
        setState(() {});
        print("Ya we");
        // The video has ended, show or enable your button here
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
      appBar: CyberFunkAppBar(),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.menu_book_outlined),
            title: Text('Leccion "Placeholder for course number"'),
            subtitle: Text('Placeholder for course name'),
          ),
          Divider(
            indent: 30.0,
            endIndent: 30.0,
            thickness: 1.5,
          ),

          //HERE GOES THE VIDEO PLAYER

          
            Container(
              height: 300.0,
              child: Chewie(controller: _chewieController),
              margin: EdgeInsets.all(50.0),
            ),
          

          _videoEnded
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 20.0),
                  child: buttonGeneralAction("Comenzar Quiz", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(
                            
                            ),
                      ),
                    );
                  }),
                )
              : SizedBox(),

          ListTile(
            title: Text('Resumen'),
            subtitle: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Divider(
                  height: 2.0,
                  indent: 10.0,
                  endIndent: 10.0,
                ),
                SizedBox(height: 10.0),
                Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur mollis ante aliquet ligula aliquet, at blandit erat mollis. Etiam diam lectus, interdum vel neque sed, fringilla eleifend mi. Phasellus quis purus fringilla, tincidunt lacus in, tincidunt urna. Mauris nec lorem diam. Integer et turpis in est sollicitudin vestibulum. Pellentesque maximus, ante et fringilla luctus, sem libero suscipit nisl, ac mattis lacus tellus in elit. Nullam tristique massa ut justo ultrices, et condimentum tortor ullamcorper. Cras pulvinar commodo risus sit amet dictum. Pellentesque eleifend efficitur neque, eget volutpat enim gravida sit amet. In in condimentum dui, et euismod justo. Morbi tristique turpis ut nibh mollis, sed feugiat nisl feugiat. Donec vel lacus eget velit malesuada consequat. Nunc ut pharetra quam.')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
