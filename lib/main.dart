import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_block_banner/api_service.dart';
import 'package:api_block_banner/banner_bloc.dart';
import 'package:api_block_banner/listing_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<BannerBloc>(
            create: (BuildContext context) => BannerBloc(ApiService()),
          ),
          BlocProvider<ListingBloc>(
            create: (BuildContext context) => ListingBloc(ApiService()),
          ),
        ],
        child: Builder(
          builder: (context) {
            return HomeScreen();
          },
        ),
      ),
    );
  }
}

// home_screen.dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter BLoC Sample'),
      ),
      body: Column(
        children: [
          // Display Banner images using BlocBuilder<BannerBloc, BannerState>
          Builder(
            builder: (context) {
              return BlocBuilder<BannerBloc, BannerState>(
                builder: (context, state) {
                  if (state is BannerLoadedState) {
                    final bannerImages = state.bannerImages;
                    return Column(
                      children: bannerImages.map((image) => GestureDetector(
                        onTap: (){
                          final launchUrl = "https://www.youtube.com/watch?v=ceMsPBbcEGg";
                          LaunchMode.externalApplication;
                          launch(launchUrl);
                        },
                        child: AspectRatio(
                            aspectRatio: 16/9,
                            child: Image.network(image)
                        ),
                      ))
                          .toList(),
                    );
                  } else if (state is BannerErrorState) {
                    return Text(state.error);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              );
            }
          ),
          // Display Listing data using BlocBuilder<ListingBloc, ListingState>
          Builder(
            builder: (context) {
              return BlocBuilder<ListingBloc, ListingState>(
                builder: (context, state) {
                  if (state is ListingLoadedState) {
                    final listingData = state.listingData;
                    return Column(
                      children: listingData
                          .map((item) => GestureDetector(
                        onTap: (){
                          final launchUrl = "https://www.youtube.com/watch?v=ceMsPBbcEGg";
                          LaunchMode.externalApplication;
                          launch(launchUrl);
                        },
                        child: AspectRatio(
                            aspectRatio: 16/9,
                            child: Image.network(item)
                        ),
                      ))
                          .toList(),
                    );
                  } else if (state is ListingErrorState) {
                    return Text(state.error);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              );
            }
          ),
        ],
      ),
    );
  }
}

