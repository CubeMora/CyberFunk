import 'package:flutter/material.dart';
import 'package:security_info_project/src/models/blog_entry.dart';
import 'package:security_info_project/src/services/blog_fetch.dart';
import 'package:security_info_project/src/settings/settings_controller.dart';
import 'package:security_info_project/src/settings/settings_service.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final SettingsService _settingsService = SettingsService();
    final SettingsController controller = SettingsController(_settingsService);
    Future.microtask(() => controller.updateThemeMode(ThemeMode.dark));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CyberFunkAppBar(),
      drawer: const AppDrawer(),
      body: FutureBuilder<List<BlogEntry>>(
        future: fetchBlogs.fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.dotsTriangle(
                  color: Colors.black, size: 80.0),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final dataList = snapshot.data!;

            return AnimatedListView(
              duration: 300,
              addAutomaticKeepAlives: true,
              spaceBetween: 40,
              children: List.generate(
                dataList.length,
                (index) => Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5.0,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/images/spin_preloader.gif",
                          image: dataList[index].imageUrl[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataList[index].title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              truncateWithEllipsis(
                                  50, dataList[index].description.join(' ')),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
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
