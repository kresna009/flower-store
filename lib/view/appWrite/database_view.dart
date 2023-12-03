import 'package:flower_store/controllers/DatabaseController.dart';
import 'package:flutter/material.dart';

class DatabaseView extends StatefulWidget {
  @override
  _DatabaseViewState createState() => _DatabaseViewState();
}

class _DatabaseViewState extends State<DatabaseView> {
  final DatabaseController _databaseController = DatabaseController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String? get documentId => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database CRUD'),
      ),
      body: Column(
        children: [
          _buildForm(),
          _buildDocumentList(),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => _createDocument(),
                child: Text('Create'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _readDocuments(),
                child: Text('Read'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _updateDocument(),
                child: Text('Update'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => _deleteDocument(),
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentList() {
    return Expanded(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _readDocuments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> documents = snapshot.data ?? [];
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(documents[index]['name']),
                  subtitle: Text(documents[index]['description']),
                );
              },
            );
          }
        },
      ),  
    );  
  }

Widget _buildDocumentListFlowers() {
  return ListView.builder(
    itemCount: _databaseController.flowerController.flowers.length,
    itemBuilder: (context, index) => Card(
      elevation: 10,
      shadowColor: Colors.blueAccent,
      color: Color(0xFFFFDDE4),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: _databaseController.flowerController.flowers[index].isDone,
                  onChanged: (value) {
                    setState(() {
                      _databaseController.flowerController.flowers[index].isDone = value!;
                      _databaseController.update(
                        _databaseController.flowerController.flowers[index].documentId,
                        _databaseController.flowerController.flowers[index].name,
                        _databaseController.flowerController.flowers[index].description,
                      );
                    });
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          _databaseController.flowerController.flowers[index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "(${_databaseController.flowerController.flowers[index].createdAt.day}-${_databaseController.flowerController.flowers[index].createdAt.month}-${_databaseController.flowerController.flowers[index].createdAt.year})",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(_databaseController.flowerController.flowers[index].description)
                  ],
                ),
              ],
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  _databaseController.delete(
                    _databaseController.flowerController.flowers[index].documentId,
                  );
                });
              },
            ),
          ],
        ),
      ),
    ),
  );
}


  Future<List<Map<String, dynamic>>> _readDocuments() async {
    return await _databaseController.read();
  }

  void _createDocument() {
    if (_formKey.currentState?.validate() ?? false) {
      _databaseController.create(
        DateTime.now().millisecondsSinceEpoch.toString(),
        _nameController.text,
        _descriptionController.text,
      );
      _clearForm();
    }
  }

  void _updateDocument() {
    if (_formKey.currentState?.validate() ?? false) {
      _databaseController.update(
        'DOCUMENT_ID_TO_UPDATE',
        _nameController.text,
        _descriptionController.text,
      );
      _clearForm();
    }
  }

  void _deleteDocument() {
    _databaseController.delete('DOCUMENT_ID_TO_DELETE');
  }

  void _clearForm() {
    _nameController.clear();
    _descriptionController.clear();
  }
}
