import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:yelp_app/model/business_model.dart';
import 'package:yelp_app/values/app_assets.dart';

class BusinessRepository {
  Future<List<BusinessModel>> getBusinesses() async {
    // Fetch businesses from API
    try {
      final response = await get(
        Uri.parse(
            'https://api.yelp.com/v3/businesses/search?location=San+Francisco&limit=10'),
        headers: {
          'Authorization':
              'Bearer bza6Hp9uiEWv2F86OSEycfB9Sc7-7G9FfMZ1JgtQM3cqSpEnG6CsF_IzpEmouNAdfiXcvmL4DSbMqbsp6jmWpyKJ-DG7-FzN3hfqXxjvQ_jfgvZQWXr5yN9pdIrjZXYx'
        },
      );
      final List<BusinessModel> businesses = [];
      if (response.statusCode == 200) {
        final data = response.body;
        final json = jsonDecode(data);

        for (final business in json['businesses']) {
          businesses.add(BusinessModel.fromJson(business));
        }

        return businesses;
      } else {
        // Load the JSON file as a string
        String jsonString = await rootBundle.loadString(Assets.yelpJson);

        // Decode the JSON string
        final json = jsonDecode(jsonString);

        for (final business in json['businesses']) {
          businesses.add(BusinessModel.fromJson(business));
        }

        return businesses;
        // throw Exception('Failed to load businesses');
      }
    } catch (e, stackTrace) {
      debugPrint('Error: $e');
      debugPrint('Stack Trace: $stackTrace');
      throw Exception('Failed to load businesses');
    }
  }
}
