import 'package:login_with_sqllite/external/database/book_table_schema.dart';
import 'package:login_with_sqllite/external/database/user_table_schema.dart';
import 'package:login_with_sqllite/model/book_mapper.dart';
import 'package:login_with_sqllite/model/book_model.dart';
import 'package:login_with_sqllite/model/user_mapper.dart';
import 'package:login_with_sqllite/model/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlLiteDb {
  //static final SqlLiteDb instance = SqlLiteDb._();
  static Database? _db;

  //SqlLiteDb._();
  Future<Database> get dbInstance async {
    // retorna a intancia se já tiver sido criada
    if (_db != null) return _db!;

    _db = await _initDB('user.db');
    return _db!;
  }

  Future<Database> _initDB(String dbName) async {
    // definie o caminho padrao para salvar o banco
    final dbPath = await getDatabasesPath();

    // define nome e onde sera salvo o banco
    String path = join(dbPath, dbName);

    // cria o banco
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateSchema,
    );
  }

  // executa script de criacao de tabelas
 Future<void> _onCreateSchema(Database db, int? version) async {
  print('Executing UserTableSchema');
  await db.execute(UserTableSchema.createUserTableScript());
  
  print('Executing BookTableSchema');
  await db.execute(BookTableSchema.createBookTableScript());
}
  Future<int> saveUser(UserModel user) async {
    var dbClient = await dbInstance;
    var res = await dbClient.insert(
      UserTableSchema.nameTable,
      UserMapper.toMapBD(user),
    );

    return res;
  }

  Future<int> updateUser(UserModel user) async {
    var dbClient = await dbInstance;
    var res = await dbClient.update(
      UserTableSchema.nameTable,
      UserMapper.toMapBD(user),
      where: '${UserTableSchema.userIDColumn} = ?',
      whereArgs: [user.userId],
    );
    return res;
  }

  Future<int> deleteUser(String userId) async {
    var dbClient = await dbInstance;
    var res = await dbClient.delete(
      UserTableSchema.nameTable,
      where: '${UserTableSchema.userIDColumn} = ?',
      whereArgs: [userId],
    );
    return res;
  }

  Future<UserModel?> getLoginUser(String userId, String password) async {
    var dbClient = await dbInstance;
    var res = await dbClient.rawQuery(
      "SELECT * FROM ${UserTableSchema.nameTable} WHERE "
      "${UserTableSchema.userIDColumn} = '$userId' AND "
      "${UserTableSchema.userPasswordColumn} = '$password'",
    );

    if (res.isNotEmpty) {
      return UserMapper.fromMapBD(res.first);
    }

    return null;
  }
  
 Future<int> saveBook(BookModel book) async {
  var dbClient = await dbInstance;
  var res = await dbClient.insert(
    BookTableSchema.nameTable,
    BookMapper.toMapBD(book),
  );

  print('BOOK saved. Result: $res');
  return res;
}

Future<List<BookModel>> getBooksByUserId(String userId) async {
  var dbClient = await dbInstance;
  var res = await dbClient.query(
    BookTableSchema.nameTable,
    where: '${BookTableSchema.userIDColumn} = ?',
    whereArgs: [userId],
  );

  return res.map((e) => BookMapper.fromMapBD(e)).toList();
}

Future<int> updateBook(BookModel book) async {
    var dbClient = await dbInstance;
    var res = await dbClient.update(
      BookTableSchema.nameTable,
      BookMapper.toMapBD(book),
      where: '${BookTableSchema.bookIDColumn} = ?',
      whereArgs: [book.bookId],
    );
    return res;
  }
  
    
}
