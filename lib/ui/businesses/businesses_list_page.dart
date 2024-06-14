import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/businesses/businesses_bloc.dart';
import '../../bloc/businesses/businesses_events.dart';
import '../../bloc/businesses/businesses_states.dart';
import '../../values/app_enums.dart';

import 'business_list_item.dart';

class BusinessesPage extends StatefulWidget {
  const BusinessesPage({super.key});

  @override
  State<BusinessesPage> createState() => _BusinessesPageState();
}

class _BusinessesPageState extends State<BusinessesPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // The user has reached the end of the list
        context.read<BusinessesBloc>().add(BusinessesFetched());
      }
    });

    context.read<BusinessesBloc>().add(BusinessesFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Yelp Businesses',
          style: TextStyle(
            fontSize: 56.r,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: BlocBuilder<BusinessesBloc, BusinessesStates>(
        builder: (context, state) {
          if (state.businessesStatus == BusinessesStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.businessesStatus == BusinessesStatus.loaded) {
            return ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: 32.r),
              itemCount: state.businessesList.length,
              itemBuilder: (context, index) {
                return BusinessListItem(state.businessesList[index]);
              },
            );
          } else {
            return const Center(
              child: Text('Failed to fetch businesses'),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
