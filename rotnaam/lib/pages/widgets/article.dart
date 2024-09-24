import 'package:flutter/material.dart';
import 'package:rotnaam/pages/material.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';

class Article extends StatefulWidget {
  const Article({super.key});

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  List articleItems = [];

  @override
  void initState() {
    super.initState();
    getAllArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 30),
                child: IconButton(
                  icon: Image.asset('assets/back.png', height: 35, width: 35),
                  iconSize: 50,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const HomePage()));
                  },
                ),
              ),
            ],
          ),
          const Text(
            "มาอ่านบทความที่น่าสนใจกัน",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          articleTail(),
        ],
      ),
    );
  }

  Widget articleTail() {
    return Expanded(
        child: ListView.builder(
      itemCount: articleItems.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.hardLight),
                  image: NetworkImage(
                      "http://${host()}/${articleItems[index]['article_img']}"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 20),
                    child: Text(
                      "${articleItems[index]['title']}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  ReadMoreText(
                    '      ${articleItems[index]['content']}.  ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    trimLines: 4,
                    colorClickableText: Colors.white,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'อ่านต่อ',
                    trimExpandedText: 'ปิด',
                    lessStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    moreStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }

  Future getAllArticle() async {
    var url = Uri.http(host(), article());
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      articleItems = json.decode(result);
      print(articleItems);
    });
  }
}
