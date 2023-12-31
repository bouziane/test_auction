import 'dart:core';
import 'domain/entities/buyer.dart';
import 'domain/entities/product.dart';
import 'domain/usecases/auction_usecases.dart';

void main() {
  var product = Product(reservedPrice: 100);
  var buyers = [
    Buyer(bids: [110, 130], name: 'A'),
    Buyer(bids: [], name: 'B'),
    Buyer(bids: [125], name: 'C'),
    Buyer(bids: [105, 115, 90], name: 'D'),
    Buyer(bids: [132, 135, 140], name: 'E'),
  ];

  var auctionUseCase = AuctionUseCase();
  if (auctionUseCase.areThereValidBids(buyers, product)) {
    var winner = auctionUseCase.findHighestBidder(buyers);
    var winningPrice =
        auctionUseCase.findWinningPrice(buyers, product.reservedPrice, winner);
    print("The winner is ${winner.name} with this price: $winningPrice");
  } else {
    print("There is no valid offer");
  }
}
