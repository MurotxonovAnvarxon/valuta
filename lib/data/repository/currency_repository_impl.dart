

import 'package:valuta/data/source/remote/api_serviseimpl.dart';

import '../source/model/response/currency_model.dart';
import 'currency_repository.dart';

class CurrencyRepositoryImpl extends CurrencyRepository{
  final apiService = ApiServiseImpl();
  @override
  Future<List<CurrencyModel>> getCurrency(String data) async {
   final result = await apiService.getCurrencyData(data);
   return result;
  }

}