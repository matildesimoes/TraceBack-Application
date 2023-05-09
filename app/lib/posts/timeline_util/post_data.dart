import 'package:cloud_firestore/cloud_firestore.dart';

import '../short_post.dart';

class PostData {

  PostData(this.doc, this._isLostPost);

  final QueryDocumentSnapshot<Map<String, dynamic>> doc;
  final bool _isLostPost;

  get(String field) {
    try {
      return doc.get(field);
    } catch (e) {
      return null;
    }
  }
  getID() {
    return doc.id;
  }
  getTitle() {
    return get('title');
  }
  getDescription() {
    return get('description');
  }
  getCategory() {
    return get('category');
  }
  getLocation() {
    return get('location');
  }
  getTags() {
    return get('tags');
  }
  getImageURL() {
    return get('imageURL');
  }
  getAuthorID() {
    return get('authorID');
  }
  getDate() {
    return get('date');
  }
  bool isClosed() {
    bool? isClosed = get('isClosed');
    return isClosed ?? false;
  }
  bool isLostPost() {
    return _isLostPost;
  }

  getPostCard() {
    return PostCard(
      title: getTitle(),
      description: getDescription(),
      location: getLocation(),
      tags: getTags(),
      authorID: getAuthorID(),
      date: getDate(),
      isClosed: isClosed(),
      imageURL: getImageURL(),
      postID: getID(),
      isLostPost: isLostPost(),
    );
  }
}