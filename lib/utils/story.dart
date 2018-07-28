import 'package:html_unescape/html_unescape.dart';


class Story {

  final String url;
  final String title;
  final String source;
  String body;
  final int _maxWordCount = 10;
  final String imageURL;


  Story({this.url, this.title, this.source, this.body, this.imageURL});

  factory Story.fromList(List list, int index) {
    return Story(
      url: list[index]['url'] as String,
      title: list[index]['title'] as String,
      source: list[index]['source'] as String,
      body: list[index]['body'] as String,
      imageURL: list[index]['imageurl'] as String,
    );
  }

  @override
  String toString() {
    return 'url: ${this.url}, title: ${this.title}, source: ${this.source}, body: ${this.body}';
  }

  String getSummary() {

    var unescape = new HtmlUnescape();

    // Remove escaped characters
    this.body = unescape.convert(this.body);

    String summary = "";

    var words = this.body.split(" ");
    var wordCount = words.length;

    for(var i = 0; i < _maxWordCount; i ++) {
      if(i >= wordCount) break;
      summary += words[i] + " ";
    }
    summary += "...";
    return summary;
  }


}