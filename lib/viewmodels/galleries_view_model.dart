import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puppicasso/apis/galleries_api.dart';
import 'package:puppicasso/models/galleries_resp.dart';

// API Provider
final galleriesApiProvider = Provider((ref) => GalleriesAPI());

// ViewModel Provider
final galleriesViewModelProvider = StateNotifierProvider<GalleriesViewModel, GalleriesState>((ref) {
  final api = ref.read(galleriesApiProvider);
  return GalleriesViewModel(api);
});

class GalleriesState {
  final GalleriesResp? data;
  final bool isLoading;
  final String? errorMessage;

  GalleriesState({
    this.data,
    this.isLoading = false,
    this.errorMessage,
  });

  GalleriesState copyWith({
    GalleriesResp? data,
    bool? isLoading,
    String? errorMessage,
  }) {
    return GalleriesState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class GalleriesViewModel extends StateNotifier<GalleriesState> {
  final GalleriesAPI api;

  GalleriesViewModel(this.api) : super(GalleriesState());

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
