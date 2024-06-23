import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puppicasso/apis/picture_create_api.dart';
import 'package:puppicasso/models/picture_create_resp.dart';

// API Provider
final pictureCreateApiProvider = Provider((ref) => PictureCreateAPI());

// ViewModel Provider
final pictureCreateViewModelProvider = StateNotifierProvider<PictureCreateViewModel, PictureCreateState>((ref) {
  final api = ref.read(pictureCreateApiProvider);
  return PictureCreateViewModel(api);
});

class PictureCreateState {
  final PictureCreateResp? data;
  final bool isLoading;
  final String? errorMessage;

  PictureCreateState({
    this.data,
    this.isLoading = false,
    this.errorMessage,
  });

  PictureCreateState copyWith({
    PictureCreateResp? data,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PictureCreateState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class PictureCreateViewModel extends StateNotifier<PictureCreateState> {
  final PictureCreateAPI api;

  PictureCreateViewModel(this.api) : super(PictureCreateState());

  Future<void> fetchData() async {
    state = state.copyWith(isLoading: true);
    try {
      final data = await api.fetchData();
      state = state.copyWith(data: data, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}
