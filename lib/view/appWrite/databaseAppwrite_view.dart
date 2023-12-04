import 'package:flower_store/controllers/DatabaseController.dart';
import 'package:flower_store/model/model.dart';
import 'package:flower_store/provider/appWrite_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatabaseView extends StatefulWidget {
  @override
  _DatabaseView createState() => _DatabaseView();
}

int _selectedIndex = 2;

class _DatabaseView extends State<DatabaseView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final DatabaseProvider databaseProvider = DatabaseProvider();
  final DatabaseController databaseController = DatabaseController();

  List<Map<String, dynamic>> flowers = [];
  List<String> selectedDocumentIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flower Database',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xFFFFDDE4),
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
            SizedBox(height: 4),
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
                            final documentId = flower['\$id'];
                            print(flower['\$id']);
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
                            print(selectedDocumentIds);
                            for (var documentId in selectedDocumentIds) {
                              databaseController.update(
                                documentId,
                                nameController.value.text,
                                descriptionController.value.text,
                              );
                            }
                          },
                          child: Text('Update'),
                        ),
                        SizedBox(width: 8.0),
                        ElevatedButton(
                          onPressed: () {
                            databaseProvider
                                .deleteSelectedFlowers(selectedDocumentIds);
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
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, -2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            _bottomNavBarItems.length,
            (index) => buildBottomNavItem(index),
          ),
        ),
      ),
    );
  }
}

List<BottomNavBarItem> _bottomNavBarItems = [
  BottomNavBarItem(
    icon: Icons.home,
    action: () {
      Get.toNamed("/home");
    },
  ),
  BottomNavBarItem(
    icon: Icons.search,
    action: () {
      Get.toNamed("/webView");
    },
  ),
  BottomNavBarItem(
    icon: Icons.add,
    action: () {
      Get.toNamed("/addImage");
    },
  ),
  BottomNavBarItem(
    icon: Icons.list,
    action: () {
      Get.toNamed("/flowerList");
    },
  ),
  BottomNavBarItem(
    icon: Icons.person,
    action: () {
      Get.toNamed("/profilePage");
    },
  ),
];

Widget buildBottomNavItem(int index) {
  return InkWell(
    onTap: () {
      _bottomNavBarItems[index].action();
    },
    child: Container(
      padding: EdgeInsets.all(10),
      child: Icon(
        _bottomNavBarItems[index].icon,
        size: 30,
        color: _selectedIndex == index ? Color(0xFFFFDDE4) : Colors.grey,
      ),
    ),
  );
}
