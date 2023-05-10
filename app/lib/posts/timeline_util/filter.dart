import 'package:TraceBack/posts/post_pages/post.dart';
import 'package:TraceBack/posts/timeline_util/post_data.dart';

class ItemsFilter {

  String _category = "All";
  String _searchInfo = "";

  String get category => _category;
  String get searchInfo => _searchInfo;

  void setCategory(String category) {
    _category = category;
  }

  void setSearchQuery(String searchInfo) {
    _searchInfo = searchInfo;
  }

  bool matches(PostData postData, String key){
     return postData.getTitle().toLowerCase().contains(key) ||
        postData.getLocation().toLowerCase().contains(key) ||
        postData.getDescription().toLowerCase().contains(key) ||
        postData.getTags().toLowerCase().contains(key);
  }

  List<PostData> filterThrough(List<PostData> postsData) {

    List<PostData> filteredCategory = [];

    if (_category != 'All') {
      for (var postData in postsData){
        if (postData.getCategory() == _category) {
          filteredCategory.add(postData);
        }
      }
    }
    else {
      filteredCategory = postsData;
    }

    if (_searchInfo.trim().isEmpty)
      return filteredCategory;

    List<String> keys = _searchInfo.split(' ');

    List<PostData> filtered = [];

    for (var postData in filteredCategory){
      bool match = false;
      for (String key in keys){
        key = key.toLowerCase().trim();
        match = match || matches(postData, key);
      }
      if (match) {
        filtered.add(postData);
      }
    }
    return filtered;
  }
}