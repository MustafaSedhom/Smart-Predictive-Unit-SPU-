import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/machine_card_data.dart';

class MachineProvider extends ChangeNotifier {
  late Box box;

  List<MachineCardData> _systemCards = [];

  List<MachineCardData> _customCards = [];

  List<MachineCardData> get cards => [..._systemCards, ..._customCards];

  List<MachineCardData> get customCards => _customCards;
List<MachineCardData> get systemCards => _systemCards;
  Future<void> initStorage() async {
    box = await Hive.openBox('machinesBox');
    loadFromStorage();
  }
  void loadFromStorage() {
    final data = box.get('cards', defaultValue: []);

    print("Loaded : ${data.length}");

    _customCards = (data as List)
        .map((e) => MachineCardData.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    notifyListeners();
  }
  void saveToStorage() {
    final data = _customCards.map((e) => e.toJson()).toList();

    box.put('cards', data);

    print("Saving cards count = ${_customCards.length}");
  }
  void setSystemCards(List<MachineCardData> cards) {
    _systemCards = cards;
    notifyListeners();
  }
  void addCard(MachineCardData card) {
    _customCards.add(card);
    saveToStorage();
    notifyListeners();
  }
  void removeCard(int index) {
    if (index < 0 || index >= _customCards.length) return;

    _customCards.removeAt(index);
    saveToStorage();
    notifyListeners();
  }
  void updateCard(int index, MachineCardData card) {
    if (index < 0 || index >= _customCards.length) return;

    _customCards[index] = card;
    saveToStorage();
    notifyListeners();
  }
  void clear() {
    _customCards.clear();
    saveToStorage();
    notifyListeners();
  }
}
