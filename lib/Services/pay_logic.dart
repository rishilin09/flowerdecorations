
import 'package:flowerdecorations/project_imports.dart';

class PayLogic with ChangeNotifier {

  double total = 0.0;


  void calculateTotal(List<Map<String,dynamic>> items){
    double _total = 0.0;
    if(items.isEmpty){
      _total = 0.0;
    }
    else {
      for(var item in items){
        _total += double.parse(item['price']);
      }
      total = _total;
    }
    notifyListeners();
  }

  double get totalPay => total;

}