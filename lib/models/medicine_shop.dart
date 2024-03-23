import "package:flutter/material.dart";
import "medicine.dart";

class MedicineShop extends ChangeNotifier {
  // Medicine for sale list
  final List<Medicine> _bag = [
    Medicine(
        name: "감기 및 통증 수액",
        type: ["기본"],
        price: [50000],
        imagePath: "lib/images/감기.png"),
    Medicine(
        name: "10분 수액",
        type: ["기본"],
        price: [30000],
        imagePath: "lib/images/수액.jpg"),
    Medicine(
        name: "장염 수액",
        type: ["기본"],
        price: [80000],
        imagePath: "lib/images/장염.png"),
    Medicine(
        name: "영양제",
        type: ["유한쓰리챔버", "오마프", "닥터라민"],
        explanation: [
          "기력회복, 영양보충, 신경기능 회복",
          "기력회복, 영양보충, 신경기능 회복",
          "뇌와 간에 좋은 영양제"
        ],
        price: [120000, 110000, 70000],
        imagePath: "lib/images/영양제.png"),
    Medicine(
        name: "피로회복",
        type: ["프리미엄", "활력", "스페셜", "고용량 비타민C"],
        explanation: [
          "종합영양제, 피로회복, 간질환 치료, 향산화, 에너지 상승, 스트레스 해소등 코로나 회복 주사",
          "만성피로, 간기능 개선, 활력 개선, 체력 유지, 기력 회복에 도움",
          "만성피로, 간기능 장애, 갱년기 증상 개선에 도움",
          "피로회복, 면역 효과, 스트레스 해소, 체력유지에 도움"
        ],
        price: [120000, 100000, 80000, 70000],
        imagePath: "lib/images/피로회복.png"),
    Medicine(
        name: "주사 추가",
        type: ["리포토신1", "리포토신2", "싸이모신", "글루타치온", "미네랄"],
        // explanation: [],
        price: [30000, 50000, 80000, 30000, 30000],
        imagePath: "lib/images/주사기.png"),
    Medicine(name: "D.C", type: ["기본"], price: [-10000], imagePath: ""),
  ];

  // Method to add a new medicine to the bag
  void addMedicine(Medicine medicine) {
    _bag.add(medicine);
    notifyListeners(); // Notify listeners to update the UI
  }

  // Method to remove a medicine from the bag
  void addItemToList(Medicine medicine) {
    _bag.remove(medicine);
    notifyListeners(); // Notify listeners to update the UI
  }

  // user cart
  List<Medicine> _userBag = [];

  // get coffee list
  List<Medicine> get medicineBag => _bag;

  // get user cart
  List<Medicine> get userBag => _userBag;

  // add item to cart
  void addItemToBag(Medicine medicine) {
    _userBag.add(medicine);
    _userBag.sort((b, a) => a.price[0].compareTo(b.price[0]));
  }

  // remove tiem from cart
  void removeItemFromBag(Medicine medicine) {
    _userBag.remove(medicine);
  }

  // remove tiem from cart
  void removeAllFromBag(Medicine medicine) {
    for (var i = 0; i < _userBag.length; i++) {
      _userBag.remove(medicine);
    }
  }
}
