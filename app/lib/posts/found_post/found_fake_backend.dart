
class FakeFoundBackend{

  static int id = 2;

  static Map<String,Map<String, Object>> collection = {
    '0':{'title': 'Samsung Galaxy A32', 'category': 'IT Devices','tags': 'Samsung,Black', 'location': 'FEUP, Porto'},
    '1':{'title': 'Iphone SE', 'category': 'IT Devices','tags': 'Broken,White', 'location': 'Sala 103, FCUP, Porto'}
  };

  static Map<String,Map<String, Object>> getCollection() => collection;

  static Map<String,Object>? getDocument(int id) => collection[id.toString()];

  static void addToCollection(Map<String, Object> document){
    collection[id.toString()] = document;
    id++;
  }
}