
class FakeLostBackend{

  static int id = 1;

  static Map<String,Map<String, Object>> collection = {
    '0':{'title': 'Iphone SE', 'category': 'IT Devices','tags': 'White', 'location': 'FCUP, Porto'},
  };

  static Map<String,Map<String, Object>> getCollection() => collection;

  static Map<String,Object>? getDocument(int id) => collection[id.toString()];

  static void addToCollection(Map<String, Object> document){
    collection[id.toString()] = document;
    id++;
  }
}