import '../entities/buyer.dart';
import '../entities/product.dart';

class AuctionUseCase {
  bool areThereValidBids(List<Buyer> buyers, Product product) {
    for (Buyer buyer in buyers) {
      for (int bid in buyer.bids) {
        if (bid > product.reservedPrice) {
          return true;
        }
      }
    }
    return false;
  }

  Buyer findHighestBid(List<Buyer> buyers) {
    return buyers.reduce((highestBuyer, buyer) =>
        highestBuyer.highestBid() > buyer.highestBid() ? highestBuyer : buyer);
  }
}
