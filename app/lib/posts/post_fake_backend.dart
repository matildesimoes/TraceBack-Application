
class FakePostBackend{

  static int id = 0;

  static Map<String,Map<String, Object>> collection = {};

  static Map<String,Map<String, Object>> getCollection() => collection;

  static Map<String,Object>? getDocument(int id) => collection[id.toString()];

  static void addToCollection(Map<String, Object> document){
    collection[id.toString()] = document;
    id++;

    print("Title: " + collection[(id-1).toString()]!['title'].toString());
    print("Category: " + collection[(id-1).toString()]!['category'].toString());
    print("Tags: " + collection[(id-1).toString()]!['tags'].toString());
    print("Location: " + collection[(id-1).toString()]!['location'].toString());
    print("Date: " + collection[(id-1).toString()]!['date'].toString());

  }
}