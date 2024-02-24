import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:valuta/data/repository/currency_repository_impl.dart';
import 'package:valuta/util/status.dart';
import '../../data/source/model/response/currency_model.dart';

part 'currency_event.dart';

part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyBloc() : super(CurrencyState()) {
    on<CurrencyEvent>((event, emit) async {
      emit(state.copyWith(status: Status.LOADING));
      final repository = CurrencyRepositoryImpl();
      try {
        var abc = event as InitialCurrencyEvent;
        final data = await repository.getCurrency(abc.date);
        emit(state.copyWith(status: Status.SUCCESS, data: data));
      } catch (e) {
        emit(state.copyWith(status: Status.ERROR));
      }
    });
  }
}
