import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yelp_app/model/business_model.dart';
import 'package:yelp_app/utils/api_manager.dart';
import 'package:yelp_app/values/app_assets.dart';

class BusinessRepository {
  final List<BusinessModel> businesses = [];
  int paginationOffset = 0;
  bool testWithJson = false;

  Future<List<BusinessModel>> getBusinesses() async {
    // Fetch businesses from API
    try {
      if (!testWithJson) {
        String apiUrl =
            'https://api.yelp.com/v3/businesses/search?location=San+Francisco&limit=10&offset=$paginationOffset';
        //debugPrint('API URL: $apiUrl');

        final response = await ApiManager.getAPI(
          apiUrl,
          {
            'Authorization':
                'Bearer bza6Hp9uiEWv2F86OSEycfB9Sc7-7G9FfMZ1JgtQM3cqSpEnG6CsF_IzpEmouNAdfiXcvmL4DSbMqbsp6jmWpyKJ-DG7-FzN3hfqXxjvQ_jfgvZQWXr5yN9pdIrjZXYx'
          },
        );

        if (response.statusCode == 200) {
          paginationOffset += 10;
          final data = response.body;
          final json = jsonDecode(data);

          for (final business in json['businesses']) {
            businesses.add(BusinessModel.fromJson(business));
          }

          return businesses;
        } else {
          throw Exception('Failed to load businesses');
        }
      } else {
        // Load the JSON file as a string
        String jsonString = await rootBundle.loadString(Assets.yelpJson);

        // Decode the JSON string
        final json = jsonDecode(jsonString);

        for (final business in json['businesses']) {
          businesses.add(BusinessModel.fromJson(business));
        }

        return businesses;
      }
    } catch (e, stackTrace) {
      debugPrint('Error: $e');
      debugPrint('Stack Trace: $stackTrace');
      throw Exception('Failed to load businesses');
    }
  }
}
