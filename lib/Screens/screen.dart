import 'package:flutter/material.dart';
import 'package:flutter_application_7/Service Model/api_service.dart';
import 'package:flutter_application_7/Service Model/news_model.dart';
import 'package:flutter_application_7/Screens/article.dart';

class Screen extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<Screen> {
  late Future<List<News>> futureNews;
  List<String> selectedCategories = [];

  @override
  void initState() {
    super.initState();
    futureNews = NewsService().getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        foregroundColor: Colors.black
        ,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
    
            },
          ),
        ],
      ),
      body: Column(
        children: [
          
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildChoiceChip('Sports'),
                  buildChoiceChip('Science'),
                  buildChoiceChip('Entertainment'),
                  buildChoiceChip('Crime'),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: futureNews,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<News> newsList = snapshot.data as List<News>;
                  return ListView.builder(
                    itemCount: newsList.length,
                    itemBuilder: (context, index) {
                      News news = newsList[index];
                      return Card(
                        elevation: 4.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          title: Text(news.title),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NewsDetailScreen(news: news),
                              ),
                            );
                          },
                          leading: SizedBox(
                            width: 60,
                            height: 60,
                            child: Image.network(
                              news.urlToImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChoiceChip(String label) {
    final bool isSelected = selectedCategories.contains(label);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ChoiceChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white, 
              ),
            ),
            if (isSelected)
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategories.remove(label);
                  });
                },
                child: Icon(
                  Icons.close,
                  size: 16.0,
                  color: Colors.white, 
                ),
              ),
          ],
        ),
        selected: isSelected,
        onSelected: (isSelected) {
          setState(() {
            if (isSelected) {
              selectedCategories.add(label);
            } else {
              selectedCategories.remove(label);
            }
          });
        },
        selectedColor: Colors.grey[700],
        backgroundColor: Colors.grey[500],
      ),
    );
  }
}
