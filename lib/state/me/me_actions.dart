class FavoriteRewardRequest {
  final int rewardId;

  FavoriteRewardRequest(this.rewardId);
}

class FavoriteRewardSuccess {
  final Set<int> rewards;

  FavoriteRewardSuccess(this.rewards);
}
