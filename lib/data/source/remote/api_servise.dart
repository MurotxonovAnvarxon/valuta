import 'package:valuta/data/source/model/response/currency_model.dart';

abstract class ApiServise {
  Future<List<CurrencyModel>> getCurrencyData(String data);
}
