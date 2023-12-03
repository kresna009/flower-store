import 'package:flower_store/controllers/DatabaseController.dart';
import 'package:flutter/material.dart';

class DatabaseView extends StatefulWidget {
  @override
  _DatabaseView createState() => _DatabaseView();
}

class _DatabaseView extends State<DatabaseView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final DatabaseController databaseController = DatabaseController();
  final TextEditingController _editNameController = TextEditingController();
  final TextEditingController _editDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flower List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty) {
                    databaseController.create(
                      DateTime.now().millisecondsSinceEpoch.toString(),
                      nameController.text,
                      descriptionController.text,
                    );
                    nameController.clear();
                    descriptionController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Data added successfully'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter both name and description'),
                      ),
                    );
                  }
                },
                child: Text('Create'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text('Read'),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: databaseController.read(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final data = snapshot.data;
                  return ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(data[index]['name']),
                        subtitle: Text(data[index]['description']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _editData(context, data[index]);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteData(data[index]['documentId']);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Data deleted successfully'),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _editData(BuildContext context, Map<String, dynamic> data) async {
    _editNameController.text = data['name'];
    _editDescriptionController.text = data['description'];

    bool dataUpdated = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Data'),
          content: Column(
            children: [
              TextField(
                controller: _editNameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _editDescriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Implement update functionality
                databaseController.update(
                  data['documentId'],
                  _editNameController.text,
                  _editDescriptionController.text,
                );
                Navigator.pop(context, true); // Data updated
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );

    if (dataUpdated == true) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data updated successfully'),
        ),
      );
    }
  }

  void _deleteData(String documentId) {
    // Implement delete functionality
    databaseController.delete(documentId);
    setState(() {});
  }
}
