part of 'home_page.dart';

class HomeViewModel extends PageViewModel<HomeState, HomeStateStatus> {
  HomeViewModel(BuildContext context) : super(context, HomeState());

  @override
  HomeStateStatus get status => state.status;

  @override
  Future<void> loadData() async {}
}
