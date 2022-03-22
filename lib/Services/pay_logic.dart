import 'package:flowerdecorations/project_imports.dart';

///This class will help to change the state of the SelectionPage with the use of ChangeNotifier
class PayLogic with ChangeNotifier {
  double total = 0.0;

  ///This function will help to calculate the total cost of all the selected items
  void calculateTotal(List<Map<String, dynamic>> items) {
    double _total = 0.0;
    if (items.isEmpty) {
      _total = 0.0;
    } else {
      for (var item in items) {
        _total += double.parse(item['price']);
      }
      total = _total;
    }
    notifyListeners();
  }

  ///getter variable for total
  double get totalPay => total;
}
