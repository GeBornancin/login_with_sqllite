import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../common/messages/messages.dart';
import '../common/routes/view_routes.dart';
import '../external/database/db_sql_lite.dart';
import '../model/book_model.dart';
import '../model/user_model.dart';

class CreateBook extends StatefulWidget {
  final UserModel user;
  const CreateBook({Key? key, required this.user}) : super(key: key);
  @override
  State<CreateBook> createState() => _CreateBookState();
}

class _CreateBookState extends State<CreateBook> {
  final _formKey = GlobalKey<FormState>();
  final _bookNameController = TextEditingController();
  final _bookStopController = TextEditingController();
  bool _bookEnd = false;
  final _userIDController = TextEditingController();
  late BookModel book;
  late UserModel user;

  @override
  void dispose() {
    _bookNameController.dispose();
    _bookStopController.dispose();
    super.dispose();
  }

  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = ModalRoute.of(context)!.settings.arguments as UserModel;
    
  }

  void createBook(BuildContext context, UserModel user) async {
    if (_formKey.currentState!.validate()) {
      BookModel book = BookModel(
        bookId: _bookNameController.text.trim(),
        bookName: _bookNameController.text.trim(),
        bookStop: _bookStopController.text.trim(),
        bookEnd: _bookEnd,
        userId: widget.user.userId,
      );
  
    print('Book ID: ${book.bookId}');
    print('Book Name: ${book.bookName}');
    print('Book Stop: ${book.bookStop}');
    print('Book End: ${book.bookEnd}');
    print('User ID: ${book.userId}');

      final db = SqlLiteDb();
      db.saveBook(book).then(
        (value) {
          AwesomeDialog(
            context: context,
            headerAnimationLoop: false,
            dialogType: DialogType.success,
            title: MessagesApp.successBooKInsert,
            btnOkOnPress: () => Navigator.pushNamed(
              context,
              RoutesApp.listBook,
              arguments: user,
            ),
            btnOkText: 'OK',
          ).show(); // Message
        },
      ).catchError((error) {
        if (error.toString().contains('UNIQUE constraint failed')) {
          MessagesApp.showCustom(
            context,
            MessagesApp.errorBookExist,
          );
        } else {
          MessagesApp.showCustom(
            context,
            MessagesApp.errorDefault,
          );
        }
      });
       
    }
  }

  @override
  Widget build(BuildContext context) {
    _userIDController.text = user.userId;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Livro'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _bookNameController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Livro',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bookStopController,
                decoration: const InputDecoration(
                  labelText: 'Pagina em que parou',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              CheckboxListTile(
                value: _bookEnd,
                onChanged: (value) {
                  setState(() {
                    _bookEnd = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text('Lido'),
              ),
              const SizedBox(height: 16),
               
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 80,
                  right: 80,
                ),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => createBook(context,user),
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed: _saveBook,
              //   child: const Text('Salvar Livro'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
