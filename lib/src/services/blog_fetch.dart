import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:security_info_project/src/models/blog_entry.dart';

class BlogFetch {
  final baseUrl = dotenv.env['SCRAPPER_URL']!;
  final authHeader = dotenv.env['SCRAPPER_API_KEY'];

  Future<List<BlogEntry>> fetchData() async {
    try {
      print('URL: $baseUrl');
      print('Authorization Header: $authHeader');
      final encodedAuthHeader =
          'Basic ' + base64Encode(utf8.encode('$authHeader:'));
      final response = await Dio().get(
        baseUrl,
        options: Options(
          headers: {
            'Authorization': encodedAuthHeader,
            'Accept-Encoding': 'gzip'
          },
        ),
      );
      print(response.data);

      if (response.statusCode == 200) {
        final lines = response.data.split('\n');
        final List<BlogEntry> blogEntries = [];

        for (var line in lines) {
          if (line.trim().isNotEmpty) {
            final json = jsonDecode(line);
            blogEntries.add(BlogEntry.fromJson(json));
          }
        }

        return blogEntries;
      } else {
        throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
