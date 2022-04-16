import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:codexbloc/newsinfo.dart';

enum NewsAction{Fetch,Delete}

class newsBloc {
  final _stateStreamController = StreamController<List<Article>>();

  StreamSink<List<Article>?> get _newssink => _stateStreamController.sink;
  Stream<List<Article>?> get newsStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<NewsAction>();

  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  Stream<NewsAction> get eventstream => _eventStreamController.stream;

  newsBloc(){
    eventstream.listen((event)async { 
      try {
        var news = await getNews();
        if(news != null)
        _newssink.add(news.articles);
        else
        _newssink.addError("Something Went Wrong");
      } on Exception catch (e) {
        _newssink.addError("Something Went Wrong");
      }

    });
  }

  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(Uri.parse(Strings.url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }
}
class Strings
{
  static String url = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=ce4e228dd59e46c4b5cd8942145f6fcb";
}