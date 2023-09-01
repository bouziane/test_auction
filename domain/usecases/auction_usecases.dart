import '../entities/buyer.dart';
import '../entities/product.dart';

class AuctionUseCase {
  bool areThereValidBids(List<Buyer> buyers, Product product) {
    for (Buyer buyer in buyers) {
      for (int bid in buyer.bids) {
        if (bid >= product.reservedPrice) {
          return true;
        }
      }
    }
    return false;
  }

  Buyer findHighestBidder(List<Buyer> buyers) {
    return buyers.reduce((highestBuyer, buyer) =>
        highestBuyer.highestBid() > buyer.highestBid() ? highestBuyer : buyer);
  }

  int findWinningPrice(List<Buyer> buyers, int reservedPrice, Buyer winner) {
    buyers.remove(winner);
    var highestBidFromLoser = buyers.fold(
        0,
        (highestBid, buyer) =>
            buyer.highestBid() > highestBid ? buyer.highestBid() : highestBid);
    return highestBidFromLoser >= reservedPrice
        ? highestBidFromLoser
        : reservedPrice;
  }
}
