class BookModel {
  String bookId;
  String bookName;
  String bookStop;
  bool bookEnd;
  String userId;

  BookModel({
    required this.bookId,
    required this.bookName,
    required this.bookStop,
    required this.bookEnd,
    required this.userId,
  });


  @override
  String toString() {
    return 'BookModel(bookId: $bookId, bookName: $bookName, bookStop: $bookStop, bookEnd: $bookEnd, userId: $userId)';
  }
}