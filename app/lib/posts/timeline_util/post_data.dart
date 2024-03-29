import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'short_post.dart';

class PostData {

  static bool key = true;
  PostData(this.doc, this._isLostPost);

  final DocumentSnapshot<Map<String, dynamic>> doc;
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
    return get('image_url');
  }
  getAuthorID() {
    return get('authorID');
  }
  getDate() {
    return get('date');
  }
  bool isClosed() {
    bool? isClosed = get('closed');
    return isClosed ?? false;
  }
  bool isLostPost() {
    return _isLostPost;
  }

  getPostCard() {
    bool displayKey = key;
    if (key){
      key = false;
    }
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
      key: displayKey ? const Key("Post Card") : null,
    );
  }
}