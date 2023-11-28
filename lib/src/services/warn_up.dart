import 'package:flutter/material.dart';
import 'screen_reference.dart';

class WarmUp extends StatefulWidget {
  const WarmUp({super.key});

  @override
  State<WarmUp> createState() => _WarmUpState();
}

class _WarmUpState extends State<WarmUp> {

  @override
  void initState() {
    
    super.initState();
    warmUp();
  }

  Future warmUp() async {
    // This silly function is needed to remove jank from the first run screen transition...
    print('Running warmUp()');
    await Future.delayed(Duration(seconds: 2));
    // If not using Firebase, you'll have to add some other delay here!
    // Otherwise, you will get errors below for trying to push new screens
    // while the first one is still building.

    if (mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => FirstScreen()));
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu()));
      
      Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen()));
      Navigator.push(context, MaterialPageRoute(builder: (context) => VideoCourseScreen()));
      Navigator.push(context, MaterialPageRoute(builder: (context) => CircularProgressIndicator()));  // Shows a spinner

      await Future.delayed(Duration(milliseconds: 1000));

      if (mounted) {
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Text("fsdfdsdsfdsfds");
  }
}