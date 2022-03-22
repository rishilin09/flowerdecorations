import 'package:flowerdecorations/project_imports.dart';

///For creating Invoice
class Invoice {
  final String title;
  final UserData userdata;
  final SelectedItems selectedItems;
  final DateTime date;
  final String payMethod;

  Invoice(
      {required this.title,
      required this.userdata,
      required this.selectedItems,
      required this.date,
      required this.payMethod});
}

///For storing selected items
class SelectedItems {

  final double total;
  final String occasion;
  final List<Map<String, dynamic>> selectedItems;

  SelectedItems(
      {required this.selectedItems,
      required this.occasion,
      required this.total});
}
