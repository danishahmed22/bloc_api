import 'package:api_block_banner/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BannerEvent {}

class FetchBannerEvent extends BannerEvent {}

abstract class BannerState {}

class BannerInitialState extends BannerState {}

class BannerLoadedState extends BannerState {
  final List<String> bannerImages;
  BannerLoadedState(this.bannerImages);
}

class BannerErrorState extends BannerState {
  final String error;
  BannerErrorState(this.error);
}

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final ApiService apiService;

  BannerBloc(this.apiService) : super(BannerInitialState());

  @override
  Stream<BannerState> mapEventToState(BannerEvent event) async* {
    if (event is FetchBannerEvent) {
      yield BannerInitialState();

      try {
        final bannerImages = await apiService.fetchBannerData();
        yield BannerLoadedState(bannerImages);
      } catch (e) {
        yield BannerErrorState('Error fetching banner data');
      }
    }
  }
}
