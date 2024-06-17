import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yelp_app/bloc/businesses/businesses_bloc.dart';
import 'package:yelp_app/bloc/businesses/businesses_events.dart';
import 'package:yelp_app/bloc/businesses/businesses_states.dart';
import 'package:yelp_app/model/business_model.dart';
import 'package:yelp_app/values/app_enums.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BusinessesBloc', () {
    late BusinessesBloc businessesBloc;

    // Mock data from the provided JSON
    late String mockJson;
    var mockBusinesses = <BusinessModel>[];

    setUp(() async {
      businessesBloc = BusinessesBloc();
      mockJson = await rootBundle.loadString('assets/json/yelp.json');
      // Parsing the mock data into a list of BusinessModel
      mockBusinesses = (jsonDecode(mockJson)['businesses'] as List)
          .map((business) => BusinessModel.fromJson(business))
          .toList();
    });

    tearDown(() {
      businessesBloc.close();
    });

    test('initial state is BusinessesStates', () {
      expect(businessesBloc.state, const BusinessesStates());
    });

    blocTest<BusinessesBloc, BusinessesStates>(
      'emits [BusinessesStates] with loaded status when BusinessesFetched is added and repository returns data',
      build: () => BusinessesBloc(),
      act: (bloc) => bloc.add(BusinessesFetched()),
      wait: const Duration(seconds: 3),
      expect: () => [
        isA<BusinessesStates>()
            .having((state) => state.businessesStatus, 'status',
                BusinessesStatus.loaded)
            .having((state) => state.businessesList, 'list', mockBusinesses),
      ],
    );
  });
}
