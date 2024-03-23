import 'package:daramge/components/medicine_tile.dart';
import 'package:daramge/models/medicine.dart';
import 'package:daramge/models/medicine_shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BagPage extends StatefulWidget {
  const BagPage({Key? key}) : super(key: key);

  @override
  _BagPageState createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MedicineShop>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            '담은 약',
            style: TextStyle(fontSize: 24.0, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.teal, // Similar to ShopPage
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: value.userBag.length,
                    itemBuilder: (context, index) {
                      Medicine eachMedicine = value.userBag[index];
                      return MedicineTile(
                        medicine: eachMedicine,
                        icon: Icon(Icons.delete),
                        onPressed: () => _removeFromBag(context, eachMedicine),
                      );
                    },
                  ),
                ),
                SizedBox(
                    height: 16.0), // Add some space between the list and button
                // Display total price
                if (value.userBag
                    .isNotEmpty) // Show total price explanation only if bag is not empty
                  Text(
                    '${_expainTotalPrice(value.userBag)}',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ElevatedButton(
                  onPressed: () => _payNow(context, value.userBag),
                  child: Text(
                    '${_calculateTotalPrice(value.userBag)}',
                    style: TextStyle(fontSize: 23.0, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Similar to ShopPage
                    padding: EdgeInsets.all(8.0), // Increase button padding
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _removeFromBag(BuildContext context, Medicine medicine) {
    Provider.of<MedicineShop>(context, listen: false)
        .removeItemFromBag(medicine);
    setState(() {}); // Update the state to reflect the changes
  }

  void _payNow(BuildContext context, List<Medicine> userBag) {
    // Access the MedicineShop instance
    MedicineShop medicineShop =
        Provider.of<MedicineShop>(context, listen: false);

    // Clear the user bag
    // medicineShop.clearUserBag();
    userBag.clear(); // Clear the user bag

    // Notify listeners to trigger a rebuild of the UI
    medicineShop.notifyListeners();
  }

  String _calculateTotalPrice(List<Medicine> userBag) {
    double totalValue = 0.0;
    for (Medicine medicine in userBag) {
      totalValue += medicine.price[0];
    }
    return totalValue
        .toStringAsFixed(0); // Convert totalValue to string and return
  }

  String _expainTotalPrice(List<Medicine> userBag) {
    List<int> positivePrices = [];
    List<int> negativePrices = [];

    // 가격이 양수인 약들과 음수인 약들을 각각의 리스트에 추가
    for (Medicine medicine in userBag) {
      if (medicine.price[0] < 0) {
        negativePrices.add(medicine.price[0].abs());
      } else {
        positivePrices.add(medicine.price[0]);
      }
    }

    // 가격을 오름차순으로 정렬
    positivePrices.sort((b, a) => a.compareTo(b));
    negativePrices.sort();

    // 양수 가격을 먼저 나열하고, 음수 가격을 나열
    String result = '';
    for (int price in positivePrices) {
      result += price.toString() + ' ';
    }
    for (int price in negativePrices) {
      result += '-' + price.toString() + ' ';
    }

    // 마지막에 공백 제거
    if (result.isNotEmpty) {
      result = result.trim();
    }
    return result;
  }
}
