import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lottie/lottie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List blogs = [];
  List cases = [];
  List others = [];

  @override
  void initState() {
    super.initState();
    fetchBlogs();
    fetchCases();
    fetchOther();
  }

  Future<void> fetchBlogs() async {
    final response =
        await http.get(Uri.parse('https://blog.dev-laravel.co/api/blogs/1'));

    if (response.statusCode == 200) {
      setState(() {
        blogs = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  Future<void> fetchCases() async {
    final response =
        await http.get(Uri.parse('https://blog.dev-laravel.co/api/cases/2'));

    if (response.statusCode == 200) {
      setState(() {
        cases = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load cases');
    }
  }

  Future<void> fetchOther() async {
    final response =
        await http.get(Uri.parse('https://blog.dev-laravel.co/api/others/3'));

    if (response.statusCode == 200) {
      setState(() {
        others = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load cases');
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      // Home Page
      ListView(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.network(
                  'https://blog.dev-laravel.co/upload/menu-images/1/1690269739.png',
                  fit: BoxFit.cover),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Blog', // 添加的文字
              style: TextStyle(
                  fontSize: 24.0, fontWeight: FontWeight.bold), // 可以调整文本的样式
              textAlign: TextAlign.center, // 设置文本居中显示
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 200,
            child: ListView(
              padding: const EdgeInsets.all(10.0),
              children: List.generate(blogs.length, (index) {
                return Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    leading: FractionallySizedBox(
                        widthFactor: 0.3,
                        child: Image.network(blogs[index]['image_url'],
                            fit: BoxFit.cover)),
                    title: Text(blogs[index]['title'],
                        style: TextStyle(fontSize: 18.0)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(article: blogs[index]),
                        ),
                      );
                    },
                    
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      // Travel Page
      ListView(
        children: [
          Image.network(
              'https://blog.dev-laravel.co/upload/menu-images/4/1690272126.png',
              fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '案例', // 添加的文字
              style: TextStyle(
                  fontSize: 24.0, fontWeight: FontWeight.bold), // 可以调整文本的样式
              textAlign: TextAlign.center, // 设置文本居中显示
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 200,
            child: ListView(
              padding: const EdgeInsets.all(10.0),
              children: List.generate(cases.length, (index) {
                return Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    leading: FractionallySizedBox(
                        widthFactor: 0.3,
                        child: Image.network(cases[index]['image_url'],
                            fit: BoxFit.cover)),
                    title: Text(cases[index]['title'],
                        style: TextStyle(fontSize: 18.0)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(article: cases[index]),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      // Contact Us Page
      ListView(
        children: [
          Image.network(
              'https://raw.gitmirror.com/renfu-her/image-drive/main/others.jpg',
              fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '其他文章', // 添加的文字
              style: TextStyle(
                  fontSize: 24.0, fontWeight: FontWeight.bold), // 可以调整文本的样式
              textAlign: TextAlign.center, // 设置文本居中显示
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 200,
            child: ListView(
              padding: const EdgeInsets.all(10.0),
              children: List.generate(others.length, (index) {
                return Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    leading: FractionallySizedBox(
                        widthFactor: 0.3,
                        child: Image.network(others[index]['image_url'],
                            fit: BoxFit.cover)),
                    title: Text(others[index]['title'],
                        style: TextStyle(fontSize: 18.0)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(article: others[index]),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Blog Developer'),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.rss_feed),
              label: 'Blog',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cases_sharp),
              label: '案例',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.devices_other),
              label: '其他文章',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

// detail page
class DetailPage extends StatelessWidget {
  final Map<String, dynamic> article;

  DetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article['title']),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(article['image_url'], fit: BoxFit.cover),
              SizedBox(height: 8.0),
              Html(
                data: article['content'],
                style: {
                  "pre": Style(
                    backgroundColor: Colors.grey[300],
                    color: Colors.black87,
                  ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Lottie.asset(
        'assets/blog.json',
        controller: _controller,
        height: MediaQuery.of(context).size.height * 1,
        animate: true,
        onLoaded: (composition) {
          _controller
            ..duration = composition.duration
            ..forward().whenComplete(() => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                ));
        },
      ),
    );
  }
}
