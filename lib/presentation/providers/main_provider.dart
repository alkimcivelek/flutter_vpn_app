import 'package:riverpod/riverpod.dart';

class MainState {
  final int selectedIndex;

  const MainState({this.selectedIndex = 0});

  MainState copyWith({int? selectedIndex}) {
    return MainState(selectedIndex: selectedIndex ?? this.selectedIndex);
  }
}

class MainNotifier extends StateNotifier<MainState> {
  MainNotifier() : super(const MainState());

  void changeIndex(int index) {
    if (index >= 0 && index <= 2) {
      state = state.copyWith(selectedIndex: index);
    }
  }

  void navigateToCountries() => changeIndex(0);
  void navigateToDisconnect() => changeIndex(1);
  void navigateToSettings() => changeIndex(2);
}

final mainProvider = StateNotifierProvider<MainNotifier, MainState>((ref) {
  return MainNotifier();
});

final selectedIndexProvider = Provider<int>((ref) {
  return ref.watch(mainProvider).selectedIndex;
});
