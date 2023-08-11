class Buyer {
  List<int> bids;
  String name;
  Buyer({
    required this.bids,
    required this.name,
  });

  int highestBid() {
    if (bids.isNotEmpty) {
      return bids
          .reduce((valueMax, value) => valueMax > value ? valueMax : value);
    }
    return 0;
  }
}
