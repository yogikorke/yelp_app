import 'package:equatable/equatable.dart';
import 'package:yelp_app/model/business_model.dart';
import '../../values/app_enums.dart';

class BusinessesStates extends Equatable {
  final BusinessesStatus businessesStatus;
  final List<BusinessModel> businessesList;

  const BusinessesStates({
    this.businessesStatus = BusinessesStatus.loading,
    this.businessesList = const <BusinessModel>[],
  });

  BusinessesStates copyWith({List<BusinessModel>? businessesList}) {
    return BusinessesStates(
      businessesList: businessesList != null
          ? [...this.businessesList, ...businessesList]
          : this.businessesList,
      businessesStatus: businessesList != null && businessesList.isNotEmpty
          ? BusinessesStatus.loaded
          : BusinessesStatus.loading,
    );
  }

  @override
  List<Object?> get props => [businessesStatus, businessesList];
}
