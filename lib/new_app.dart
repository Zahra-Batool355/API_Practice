import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/NewModel.dart';

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  late Future<News> futureNews;

  Future<News> fetchNews() async {
    final url =
        "https://newsapi.org/v2/everything?q=tesla&from=2025-06-10&sortBy=publishedAt&apiKey=2f709fa7678e416985866d3104e704e2";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return News.fromJson(result);
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  void initState() {
    super.initState();
    futureNews = fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TechCrunch News")),
      body: FutureBuilder<News>(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!.articles != null) {
            final articles = snapshot.data!.articles!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ListTile(
                  leading: article.urlToImage != null
                      ? CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(article.urlToImage!),
                    onBackgroundImageError: (exception, stackTrace) {
                      // fallback on image error
                    },
                  )
                      : CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.image, color: Colors.grey),
                  ),
                  title: Text(article.title ?? 'No Title'),
                  subtitle: Text(article.description ?? 'No Description'),
                );
              },
            );
          } else {
            return Center(child: Text("No news found."));
          }
        },
      ),
    );
  }
}
