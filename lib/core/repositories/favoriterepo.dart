class FavoriteRepository {
  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<List<Map<String, dynamic>>> fetchFavorites(
      List<Map<String, dynamic>> currentFavorites) async {
    await _simulateDelay();
    return currentFavorites;
  }

  Future<bool> addFavorite(Map<String, dynamic> item,
      List<Map<String, dynamic>> currentFavorites) async {
    await _simulateDelay();

    return true;
  }

  Future<bool> removeFavorite(
      String itemId, List<Map<String, dynamic>> currentFavorites) async {
    await _simulateDelay();
    return true;
  }
}
