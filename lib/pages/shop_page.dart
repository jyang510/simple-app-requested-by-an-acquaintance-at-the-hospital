import 'package:daramge/components/create_tile.dart';
import 'package:daramge/components/medicine_tile.dart';
import 'package:daramge/components/option_tile.dart';
import 'package:daramge/models/medicine.dart';
import 'package:daramge/models/medicine_shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  void addToBag(Medicine medicine) async {
    if (medicine.price.length > 1) {
      medicine = await showDialog(
        context: context,
        builder: (context) => MedicineDetailsDialog(medicine: medicine),
      );
    }

    Provider.of<MedicineShop>(context, listen: false).addItemToBag(medicine);

    await showDialog(
      context: context,
      builder: (context) => Center(
        child: AlertDialog(
          content: Container(
            width:
                MediaQuery.of(context).size.width * 0.7, // 70% of screen width
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "약을 담았습니다",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20), // Add some vertical space
                Text(
                  "${medicine.type.length == 1 && medicine.type[0] != "기본" ? medicine.type[0] : medicine.name}, ${medicine.price[0]}원",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addNewMedicine() async {
    final newMedicine = await showAddMedicineDialog(context);
    print(1);
    print(newMedicine);
    // if (newMedicine != null) {
    //   // Add the new medicine to your data source or perform any other necessary action
    //   Provider.of<MedicineShop>(context, listen: false).addMedicine(
    //     Medicine(
    //       name: "새로운 약",
    //       type: ["기본"],
    //       price: [10000],
    //       imagePath: "lib/images/1.png",
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MedicineShop>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            '연세소래메디칼 수액리스트',
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.builder(
                    itemCount: value.medicineBag.length,
                    itemBuilder: (context, index) {
                      Medicine eachMedicine = value.medicineBag[index];
                      return MedicineTile(
                        medicine: eachMedicine,
                        icon: Icon(Icons.add),
                        onPressed: () => addToBag(eachMedicine),
                      );
                    },
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Align(
              //     alignment: Alignment.bottomRight,
              //     child: ElevatedButton(
              //       onPressed: () => addNewMedicine(),
              //       child: Text(
              //         '새로운 약 추가',
              //         style: TextStyle(color: Colors.white),
              //       ),
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.teal,
              //         padding: EdgeInsets.all(16.0),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
