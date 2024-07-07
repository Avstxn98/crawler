import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class WebCrawler {
  final String url;

  WebCrawler(this.url);

  Future<List<dynamic>> fetchData() async {
    List value = [];
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var document = parser.parse(response.body);
        value = extractData(document);
      } else {
        print(
            'Failed to load webpage with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    return value;
  }

  List<dynamic> extractData(Document document) {
    List text = [];
    // Example: Extract all text from <p> tags
    List<Element> paragraphs = document.querySelectorAll('p');
    for (var paragraph in paragraphs) {
      text.add(paragraph.text);
    }
    return text;
  }
}
