import 'package:valuta/data/source/model/response/currency_model.dart';
import 'package:valuta/data/source/remote/api_servise.dart';
import 'package:dio/dio.dart';

class ApiServiseImpl extends ApiServise {
  final _dio = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      baseUrl: 'https://cbu.uz',
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60)));

  Future<List<CurrencyModel>> getCurrency() async {
    try {
      final response = await _dio.get('/uz/arkhiv-kursov-valyut/json/');
      return (response.data as List).map((e) => CurrencyModel.fromJson(e)).toList();

    } on DioException catch (e) {
      return [];
    }
  }
  Future<List<CurrencyModel>> getCurrencyData(String data) async {
    try {
      final response = await _dio.get('/uz/arkhiv-kursov-valyut/json/all/$data/');
      return (response.data as List).map((e) => CurrencyModel.fromJson(e)).toList();

    } on DioException catch (e) {
      return [];
    }
  }

}
