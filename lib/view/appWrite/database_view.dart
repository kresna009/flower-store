import 'package:flower_store/controllers/DatabaseController.dart';
import 'package:flutter/material.dart';

class DatabaseView extends StatefulWidget {
  @override
  _FlowerListViewState createState() => _FlowerListViewState();
}

class _FlowerListViewState extends State<DatabaseView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final DatabaseController databaseController = DatabaseController();

  List<Map<String, dynamic>> flowers = [];
  List<String> selectedDocumentIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flower List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),
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
                }
              },
              child: Text('Create'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final result = await databaseController.read();
                setState(() {
                  flowers = result;
                  selectedDocumentIds.clear();
                });
              },
              child: Text('Read'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: flowers.length,
                itemBuilder: (context, index) {
                  final flower = flowers[index];
                  return ListTile(
                    leading: Checkbox(
                      value: flower['isSelected'] ?? false,
                      onChanged: (value) {
                        setState(() {
                          flower['isSelected'] = value;
                          if (value == true) {
                            final documentId = flower['documentId'];
                            if (documentId != null) {
                              selectedDocumentIds.add(documentId);
                            }
                          } else {
                            final documentId = flower['documentId'];
                            if (documentId != null) {
                              selectedDocumentIds.remove(documentId);
                            }
                          }
                        });
                      },
                    ),
                    title: Text(flower['name']),
                    subtitle: Text(flower['description']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            for (var documentId in selectedDocumentIds) {
                              databaseController.update(
                                documentId,
                                'Updated Name',
                                'Updated Description',
                              );
                            }
                          },
                          child: Text('Update'),
                        ),
                        SizedBox(width: 8.0),
                        ElevatedButton(
                          onPressed: () {
                            for (var documentId in selectedDocumentIds) {
                              databaseController.delete(documentId);
                            }
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DatabaseView(),
  ));
}
