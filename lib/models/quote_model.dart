import 'package:cloud_firestore/cloud_firestore.dart';

class QuoteModel {
  final String quote;
  final String author;
  final String id;
  final String imageUrl;
  final String imageFBPath;

  QuoteModel(
      {this.quote, this.author, this.id, this.imageUrl, this.imageFBPath});

  factory QuoteModel.fromFirebase(DocumentSnapshot snapshot) {
    return QuoteModel(
      id: snapshot.id,
      quote: snapshot.data()['quote'],
      author: snapshot.data()['author'],
    );
  }
}
