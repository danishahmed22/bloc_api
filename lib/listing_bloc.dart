import 'package:api_block_banner/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ListingEvent {}

class FetchListingEvent extends ListingEvent {}

abstract class ListingState {}

class ListingInitialState extends ListingState {}

class ListingLoadedState extends ListingState {
  final List<String> listingData;
  ListingLoadedState(this.listingData);
}

class ListingErrorState extends ListingState {
  final String error;
  ListingErrorState(this.error);
}

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  final ApiService apiService;

  ListingBloc(this.apiService) : super(ListingInitialState());

  @override
  Stream<ListingState> mapEventToState(ListingEvent event) async* {
    if (event is FetchListingEvent) {
      yield ListingInitialState();

      try {
        final listingData = await apiService.fetchListingData();
        yield ListingLoadedState(listingData);
      } catch (e) {
        yield ListingErrorState('Error fetching listing data');
      }
    }
  }
}
