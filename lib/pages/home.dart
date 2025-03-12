import 'package:api_fetching/Services/data.dart';
import 'package:api_fetching/Splash%20Screen/splash.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> posts = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  Future<void> getPosts() async {
    List<dynamic> fetchedPosts = await ApiService().fetchPosts();

    setState(() {
      if (fetchedPosts.isNotEmpty) {
        posts = fetchedPosts;
        errorMessage = null;
      } else {
        errorMessage = "No data available. Please try again later.";
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Titles'),
        backgroundColor: Color.fromARGB(255, 90, 144, 196),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SplashScreen()),
            );
          },
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Text(errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 16)))
              : ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Color.fromARGB(255, 223, 227, 230),
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(posts[index]['title'],
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(posts[index]['body']),
                      ),
                    );
                  },
                ),
    );
  }
}
