import 'package:flutter/material.dart';
import 'package:daramge/models/medicine.dart';

class MedicineDetailsDialog extends StatefulWidget {
  final Medicine medicine;

  MedicineDetailsDialog({required this.medicine});

  @override
  _MedicineDetailsDialogState createState() => _MedicineDetailsDialogState();
}

class _MedicineDetailsDialogState extends State<MedicineDetailsDialog> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // Set AlertDialog's background color to white
        dialogBackgroundColor: Colors.white,
      ),
      child: AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              widget.medicine.price.length,
              (index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: GestureDetector(
                  onTap: () async {
                    // if (!(widget.medicine.explanation.isEmpty)) {
                    //   await showDialog(
                    //     context: context,
                    //     builder: (context) => AlertDialog(
                    //       title: Text(
                    //         '${widget.medicine.type[index]}',
                    //         textAlign:
                    //             TextAlign.center, // Center align the title text
                    //         style: TextStyle(),
                    //       ),
                    //       titlePadding:
                    //           EdgeInsets.all(20), // Add padding to the title
                    //       content: Text(
                    //         '${widget.medicine.explanation[index]}', // Add explanation
                    //         textAlign:
                    //             TextAlign.center, // Center align the content text
                    //         style: TextStyle(
                    //           color:
                    //               Colors.black, // Font color of the content text
                    //         ),
                    //       ),
                    //       actions: [
                    //         TextButton(
                    //           onPressed: () {
                    //             Navigator.of(context).pop();
                    //           },
                    //           child: Text('Close'),
                    //         ),
                    //       ],
                    //     ),
                    //   );
                    // }
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width *
                        0.6, // Adjust the width here
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? Colors.teal[700] // Change color when selected
                          : Colors.teal[300], // Default color
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.medicine.type[index]}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white, // Change color to white
                            ),
                          ),
                          widget.medicine.explanation.isEmpty
                              ? SizedBox(height: 2)
                              : Text(
                                  '${widget.medicine.explanation[index]}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color:
                                        Colors.white, // Change color to white
                                  ),
                                ),
                          SizedBox(height: 2),
                          Text(
                            '${widget.medicine.price[index]}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white, // Change color to white
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
          TextButton(
            onPressed: () {
              // Return the selected index to the caller
              if (selectedIndex != null) {
                Navigator.of(context).pop(
                  Medicine(
                    name: widget.medicine.name,
                    price: [widget.medicine.price[selectedIndex!]],
                    type: [widget.medicine.type[selectedIndex!]],
                    imagePath: widget.medicine.imagePath,
                  ),
                );
              }
            },
            child: Text('Select'),
          ),
        ],
      ),
    );
  }
}
