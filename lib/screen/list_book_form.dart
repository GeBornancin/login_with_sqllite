import 'package:flutter/material.dart';
import 'package:login_with_sqllite/common/routes/view_routes.dart';
import 'package:login_with_sqllite/components/user_app_bar.dart';
import 'package:login_with_sqllite/external/database/db_sql_lite.dart';
import 'package:login_with_sqllite/model/book_model.dart';
import 'package:login_with_sqllite/model/user_model.dart';
import 'package:login_with_sqllite/screen/create_book_form.dart';

class ListBook extends StatefulWidget {
  final UserModel user;

  const ListBook({Key? key, required this.user}) : super(key: key);

  @override
  _ListBookState createState() => _ListBookState();
}

class _ListBookState extends State<ListBook> {
  List<BookModel> bookList = [];

  late UserModel user;
  final _bookNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _fetchBooks();
     user = widget.user;
     _bookNameController.text = user.userName;
  }


  
  @override
  void dispose() {
    _bookNameController.dispose();
    super.dispose();
  }

  Future<void> _fetchBooks() async {
    final db = SqlLiteDb();
    final books = await db.getBooksByUserId(widget.user.userId);
    books.sort((a, b) => a.bookEnd == b.bookEnd ? 0 : a.bookEnd ? 1 : -1);
    setState(() {
      bookList = books;
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: UserAppBar(
      icon: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          Navigator.pushNamed(
            context,
            RoutesApp.loginUpdate,
            arguments: user,
          );
        },
      ),
      controller: _bookNameController,
    ),
    body: ListView.builder(
      itemCount: bookList.length,
      itemBuilder: (context, index) {
        final book = bookList[index];
        return ListTile(
          title: Text(book.bookName),
          subtitle: Text('Página: ${book.bookStop}'),
          leading: Icon(
            book.bookEnd ? Icons.check : Icons.close,
            color: book.bookEnd ? Colors.green : Colors.red,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit,
            color: Colors.green),
            
            onPressed: () {
              _editBook(book);
            },
          ),
        );
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          RoutesApp.createBook,
          arguments: widget.user,
        );
      },
      child: Icon(Icons.add),
    ),
  );
}
  void _editBook(BookModel book) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController bookStopController =
            TextEditingController(text: book.bookStop);
        bool bookEnd = book.bookEnd;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Editar Livro'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: bookStopController,
                    decoration: InputDecoration(labelText: 'Página'),
                  ),
                  CheckboxListTile(
                    value: bookEnd,
                    onChanged: (value) {
                      setState(() {
                        bookEnd = value!;
                      });
                    },
                    title: Text('Já leu / Terminou de ler?'),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      book.bookStop = bookStopController.text;
                      book.bookEnd = bookEnd;
                    });
                    await _updateBookInDatabase(book);
                    Navigator.of(context).pop();
                  },
                  child: Text('Salvar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _updateBookInDatabase(BookModel book) async {
  final db = SqlLiteDb();
  await db.updateBook(book);
  await _fetchBooks(); // Atualiza a lista de livros
  setState(() {}); // Atualiza o estado do widget
}
}
