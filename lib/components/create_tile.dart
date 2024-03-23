import 'package:flutter/material.dart';
import 'package:daramge/models/medicine.dart';

Future<Medicine?> showAddMedicineDialog(BuildContext context) async {
  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imagePathController = TextEditingController();

  return showDialog<Medicine>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('새로운 약 추가'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: '약 이름'),
              ),
              TextField(
                controller: typeController,
                decoration: InputDecoration(labelText: '약 유형'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: '약 가격'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('취소'),
          ),
          TextButton(
            onPressed: () {
              final String name = nameController.text;
              final List<String> type = [typeController.text];
              final int price = int.tryParse(priceController.text) ?? 0;
              final String imagePath = imagePathController.text;

              if (name.isNotEmpty &&
                  type.isNotEmpty &&
                  price > 0 &&
                  imagePath.isNotEmpty) {
                final Medicine newMedicine = Medicine(
                  name: name,
                  type: type,
                  price: [price],
                  imagePath: imagePath,
                );

                Navigator.of(context).pop(newMedicine);
              } else {
                // Show error message or handle invalid input
              }
            },
            child: Text('저장'),
          ),
        ],
      );
    },
  );
}
