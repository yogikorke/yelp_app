import 'package:equatable/equatable.dart';

abstract class BusinessesEvent extends Equatable {
  const BusinessesEvent();

  @override
  List<Object> get props => [];
}

class BusinessesFetched extends BusinessesEvent {}
