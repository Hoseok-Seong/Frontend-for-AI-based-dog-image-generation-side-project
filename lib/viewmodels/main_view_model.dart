import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puppicasso/apis/main_api.dart';
import 'package:puppicasso/models/main_resp.dart';

// API Provider
final mainApiProvider = Provider((ref) => MainAPI());

// ViewModel Provider
final mainViewModelProvider = StateNotifierProvider<MainViewModel, MainState>((ref) {
  final api = ref.read(mainApiProvider);
  return MainViewModel(api);
});

class MainState {
  final MainResp? data;
  final bool isLoading;
  final String? errorMessage;

  MainState({
    this.data,
    this.isLoading = false,
    this.errorMessage,
  });

  MainState copyWith({
    MainResp? data,
    bool? isLoading,
    String? errorMessage,
  }) {
    return MainState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class MainViewModel extends StateNotifier<MainState> {
  final MainAPI api;

  MainViewModel(this.api) : super(MainState());

  Future<void> fetchData(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    try {
      final data = await api.fetchData(context);
      state = state.copyWith(data: data, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}