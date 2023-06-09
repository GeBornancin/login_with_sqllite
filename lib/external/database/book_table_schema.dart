
import 'package:login_with_sqllite/external/database/user_table_schema.dart';

abstract class BookTableSchema {
  static const String nameTable = "book";
  static const String bookIDColumn = 'id';
  static const String bookNameColumn = 'name';
  static const String bookStopColumn = 'stop';
  static const String bookEndColumn = 'end';
  static const String userIDColumn = 'user_id';

  static String createBookTableScript() => '''
    CREATE TABLE $nameTable (
        $bookIDColumn TEXT NOT NULL PRIMARY KEY, 
        $bookNameColumn TEXT NOT NULL, 
        $bookStopColumn TEXT NOT NULL,
        $bookEndColumn INTEGER NOT NULL,
        $userIDColumn TEXT NOT NULL,
        FOREIGN KEY ($userIDColumn) REFERENCES ${UserTableSchema.nameTable}(${UserTableSchema.userIDColumn})
        )
      ''';
}
