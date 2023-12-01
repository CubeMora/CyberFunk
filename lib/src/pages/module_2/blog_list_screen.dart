import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:security_info_project/src/models/blog_entry.dart';
import 'package:security_info_project/src/models/drawer_sections.dart';
import 'package:security_info_project/src/services/blog_fetch.dart';
// import 'package:security_info_project/src/settings/settings_controller.dart';
// import 'package:security_info_project/src/settings/settings_service.dart';
import 'package:security_info_project/src/widgets/AppDrawer.dart';
import 'package:security_info_project/src/widgets/CyberFunkAppBar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';

class BlogListScreen extends StatefulWidget {
  const BlogListScreen({super.key});

  @override
  State<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  final fetchBlogs = BlogFetch();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
        return false;
      },
      child: Scaffold(
        appBar: const CyberFunkAppBar(),
        drawer: const AppDrawer(currentScreen: DrawerSections.blog,),
        body: FutureBuilder<List<BlogEntry>>(
          future: fetchBlogs.fetchData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.dotsTriangle(
                    color: Colors.black, size: 80.0),
              );
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   const SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: Center(
                        child: SvgPicture.asset(
                      "assets/svg/screen_res/access_denied.svg",
                      width: MediaQuery.of(context).size.width / 1.5,
                    )),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "¡Vaya!",
                    style: GoogleFonts.majorMonoDisplay(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Parece que ha ocurrido un error al cargar los datos",
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 21.0,
                        fontWeight: FontWeight.w300,
                        height: 0,
                      )),
                      textAlign: TextAlign.center,
                    ),
                  ),
                 
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: buttonGeneralAction("Recargar", () {setState(() {
                        
                      });}),
                    ),
                  )
                ],
              ); //Center(child: Text('Error: ${snapshot.error}'),);
            } else {
              final dataList = snapshot.data!;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: AnimatedListView(
                  duration: 300,
                  addAutomaticKeepAlives: true,
                  spaceBetween: 0,
                  children: List.generate(
                    dataList.length,
                    (index) => InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/blogDetail',
                            arguments: dataList[index]);
                      },
                      child: Hero(
                        tag: 'blogCard${dataList[index].title}',
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5.0,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: FadeInImage.assetNetwork(
                                    placeholder:
                                        "assets/images/spin_preloader.gif",
                                    image: dataList[index].imageUrl[0],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dataList[index].title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        truncateWithEllipsis(
                                            50,
                                            dataList[index]
                                                .description
                                                .join(' ')),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ), //.animate().fadeIn(duration: const Duration(milliseconds: 300),/* delay: Duration(milliseconds: 20 * index)).moveY(begin: 50, curve: Curves.easeOutBack)*/
                      ),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(duration: const Duration(milliseconds: 900))
                    .moveY(begin: 50, curve: Curves.easeOutBack),
              );
            }
          },
        ),
      ),
    );
  }

  String truncateWithEllipsis(int cutoff, String myString) {
    var words = myString.split(' ');
    return (words.length <= cutoff)
        ? myString
        : '${words.take(cutoff).join(' ')}...';
  }

  Widget buttonGeneralAction(String text, void Function() action) {
    return ElevatedButton(
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size(150.0, 50.0)),
          backgroundColor: MaterialStateColor.resolveWith(
              (states) => const Color(0xFF3C3C3C))),
      onPressed: action,
      child: Text(text,
          style: GoogleFonts.inter(
              textStyle: const TextStyle(
            color: Color(0xFFF4F4F4),
            fontSize: 19,
            fontWeight: FontWeight.w500,
            height: 0,
          ))),
    );
  }

  Widget textNormal(double size, String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
          textStyle: TextStyle(
        color: const Color(0xFFF4F4F4),
        fontSize: size,
        fontWeight: FontWeight.w500,
        height: 0,
      )),
    );
  }
}
