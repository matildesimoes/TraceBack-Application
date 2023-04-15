
class FakePostBackend{

  static int id = 0;

  static Map<String,Map<String, Object>> collection = {};

  static Map<String,Map<String, Object>> getCollection() => collection;

  static Map<String,Object>? getDocument(int id) => collection[id.toString()];

  static void addToCollection(Map<String, Object> document){
    collection[id.toString()] = document;
    id++;
  }
}