import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:yelp_app/repository/business_repository.dart';
import 'businesses_events.dart';
import 'businesses_states.dart';

class BusinessesBloc extends Bloc<BusinessesEvent, BusinessesStates> {
  BusinessRepository businessRepository = BusinessRepository();

  BusinessesBloc() : super(const BusinessesStates()) {
    on<BusinessesFetched>(getBusinesses);
  }

  FutureOr<void> getBusinesses(
    BusinessesFetched event,
    Emitter<BusinessesStates> emit,
  ) async {
    await businessRepository.getBusinesses().then((businesses) {
      emit(state.copyWith(businessesList: businesses));
    }).onError((error, stackTrace) {
      emit(state.copyWith(businessesList: []));
    });
  }
}
