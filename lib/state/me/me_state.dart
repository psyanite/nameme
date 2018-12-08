import 'package:meta/meta.dart';

@immutable
class MeState {
  final Set<int> favoriteRewards;
  final Set<int> favoriteStores;

  MeState({
    this.favoriteRewards,
    this.favoriteStores,
  });

  MeState copyWith({Set<int> favoriteRewards, Set<int> favoriteStores}) {
    return MeState(
      favoriteRewards: favoriteRewards ?? this.favoriteRewards,
      favoriteStores: favoriteStores ?? this.favoriteStores,
    );
  }

  @override
  String toString() {
    return '''{
        favoriteRewards: $favoriteRewards,
      }''';
  }
}
