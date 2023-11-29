import 'package:flutter/material.dart';
import 'package:security_info_project/src/models/blog_entry.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogDetailScreen extends StatefulWidget {
  final BlogEntry blogEntry;

  const BlogDetailScreen({required this.blogEntry, Key? key}) : super(key: key);

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: const Color.fromRGBO(52, 51, 58, 0.96),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          child: const Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: ListView(
        children: [
          Hero(
              tag: 'blogCard${widget.blogEntry.title}',
              transitionOnUserGestures: true,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(
                      25), // Change this to your preferred border radius
                  bottomRight: Radius.circular(
                      25), // Change this to your preferred border radius
                ),
                child: Image.network(
                  widget.blogEntry.imageUrl[0],
                  fit: BoxFit
                      .cover, // This makes the image cover the entire container
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  widget.blogEntry.title,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Divider(thickness: 1.0, color: Colors.black87),
                const SizedBox(
                  height: 30.0,
                ),
                Text(truncateWithEllipsis(200, widget.blogEntry.description.join(' ')), style: TextStyle(height: 1.6), ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final url = widget.blogEntry.url;
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100.0, 50.0),
                    backgroundColor: const Color.fromRGBO(52, 51, 58, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Leer más"),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  String truncateWithEllipsis(int cutoff, String myString) {
    var words = myString.split(' ');
    return (words.length <= cutoff)
        ? myString
        : '${words.take(cutoff).join(' ')}...';
  }
}
