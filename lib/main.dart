import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:blog_dev/utils/detail_page.dart';
import 'package:blog_dev/utils/splash_screen.dart';
import 'package:blog_dev/utils/privacy_policy.dart';

void main() {
  runApp(const MyApp());
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
    double width = MediaQuery.of(context).size.width;

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
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Blog', // 添加的文字
              style: TextStyle(
                  fontSize: 24.0, fontWeight: FontWeight.bold), // 可以调整文本的样式
              textAlign: TextAlign.center, // 设置文本居中显示
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 310,
            child: ListView(
              padding: const EdgeInsets.all(10.0),
              children: List.generate(blogs.length, (index) {
                return SizedBox(
                  height: 120.0,
                  child: Card(
                    child: Center(
                      // 使用 Center widget 使內部的 ListTile 垂直置中
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10.0),
                        leading: FractionallySizedBox(
                          widthFactor: 0.3,
                          heightFactor: 1.0,
                          child: Image.network(blogs[index]['image_url'],
                              fit: BoxFit.cover),
                        ),
                        title: Text(blogs[index]['title'],
                            style: const TextStyle(fontSize: 18.0)),
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
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
      // Travel Page
      ListView(
        children: [
          Image.network(
              'https://blog.dev-laravel.co/upload/menu-images/4/1690272126.png',
              fit: BoxFit.cover),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              '案例', // 添加的文字
              style: TextStyle(
                  fontSize: 24.0, fontWeight: FontWeight.bold), // 可以调整文本的样式
              textAlign: TextAlign.center, // 设置文本居中显示
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 310,
            child: ListView(
              padding: const EdgeInsets.all(10.0),
              children: List.generate(cases.length, (index) {
                return SizedBox(
                  height: 120.0,
                  child: Card(
                    child: Center(
                      // 使用 Center widget 使內部的 ListTile 垂直置中
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10.0),
                        leading: FractionallySizedBox(
                          widthFactor: 0.3,
                          heightFactor: 1.0,
                          child: Image.network(cases[index]['image_url'],
                              fit: BoxFit.cover),
                        ),
                        title: Text(cases[index]['title'],
                            style: const TextStyle(fontSize: 18.0)),
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
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
      // Contact Us Page
      ListView(
        children: [
          Image.network(
              'https://raw.gitmirror.com/renfu-her/image-drive/main/others.jpg',
              fit: BoxFit.cover),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              '其他文章', // 添加的文字
              style: TextStyle(
                  fontSize: 24.0, fontWeight: FontWeight.bold), // 可以调整文本的样式
              textAlign: TextAlign.center, // 设置文本居中显示
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 310,
            child: ListView(
              padding: const EdgeInsets.all(10.0),
              children: List.generate(others.length, (index) {
                return SizedBox(
                  height: 120.0,
                  child: Card(
                    child: Center(
                      // 使用 Center widget 使內部的 ListTile 垂直置中
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10.0),
                        leading: FractionallySizedBox(
                          widthFactor: 0.3,
                          heightFactor: 1.0,
                          child: Image.network(others[index]['image_url'],
                              fit: BoxFit.cover),
                        ),
                        title: Text(others[index]['title'],
                            style: const TextStyle(fontSize: 18.0)),
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
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    ];

    // 在 _HomePageState 類中的 build 方法中：
    return Scaffold(
      appBar: AppBar(
        title: const Text('開發 & 程式 Blog'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: tabs[_currentIndex],
      drawer: width <= 600
          ? Drawer(
              child: drawerContent(),
            )
          : null, // 如果宽度小于或等于600像素，则为手机
      endDrawer: width > 600
          ? Drawer(
              child: drawerContent(),
            )
          : null, // 如果宽度大于600像素，则为平板
    );
  }

  Widget drawerContent() {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://blog.dev-laravel.co/images/favicon.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(),
        ),
        ListTile(
          leading: const Icon(Icons.rss_feed),
          title: const Text('Blog'),
          onTap: () {
            setState(() {
              _currentIndex = 0;
            });
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.cases_sharp),
          title: const Text('案例'),
          onTap: () {
            setState(() {
              _currentIndex = 1;
            });
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.devices_other),
          title: const Text('其他文章'),
          onTap: () {
            setState(() {
              _currentIndex = 2;
            });
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip),
          title: const Text('隱私權政策'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
            );
          },
        ),
      ],
    );
  }
}
