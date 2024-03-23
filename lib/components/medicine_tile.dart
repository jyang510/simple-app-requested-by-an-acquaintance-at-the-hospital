import 'package:flutter/material.dart';
import '../models/medicine.dart';

class MedicineTile extends StatelessWidget {
  final Medicine medicine;
  void Function() onPressed;
  final Widget icon;

  MedicineTile({
    Key? key,
    required this.medicine,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: ListTile(
        title: medicine.type.length == 1 && medicine.type[0] != "기본"
            ? Text("${medicine.type[0]}")
            : Text("${medicine.name}"),
        subtitle: medicine.type.length == 1
            ? Text("${medicine.price[0]}")
            : Text(medicine.type.join(", ")),
        leading: Container(
          width: 80, // Adjust according to your preference
          height: 80, // Adjust according to your preference
          child: medicine.imagePath == ""
              ? SizedBox()
              : Image.asset(
                  medicine.imagePath,
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),
        ),
        trailing: IconButton(
          icon: icon,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
