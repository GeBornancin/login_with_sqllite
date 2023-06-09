import 'package:login_with_sqllite/external/database/book_table_schema.dart';
import 'package:login_with_sqllite/model/book_model.dart';

abstract class BookMapper {
  static Map<String, dynamic> toMapBD(BookModel book) {
    return {
      BookTableSchema.bookIDColumn: book.bookId,
      BookTableSchema.bookNameColumn: book.bookName,
      BookTableSchema.bookStopColumn: book.bookStop,
      BookTableSchema.bookEndColumn: book.bookEnd ? 1 : 0,
      BookTableSchema.userIDColumn: book.userId,
    };
  }

  static BookModel fromMapBD(Map<String, dynamic> map) {
    return BookModel(
      bookId: map[BookTableSchema.bookIDColumn],
      bookName: map[BookTableSchema.bookNameColumn],
      bookStop: map[BookTableSchema.bookStopColumn],
      bookEnd: map[BookTableSchema.bookEndColumn] == 1 ? true : false,
      userId: map[BookTableSchema.userIDColumn],
    );
  }

  static BookModel cloneBook(BookModel book) {
    return BookModel(
      bookId: book.bookId,
      bookName: book.bookName,
      bookStop: book.bookStop,
      bookEnd: book.bookEnd,
      userId: book.userId,
    );
  }
}
