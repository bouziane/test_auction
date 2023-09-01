import '../domain/entities/buyer.dart';
import '../domain/entities/product.dart';
import '../domain/usecases/auction_usecases.dart';
import 'package:test/test.dart';

void main() {
  late AuctionUseCase auctionUseCase;
  late List<Buyer> buyers;
  late Product product;

  setUp(() {
    auctionUseCase = AuctionUseCase();

    buyers = [
      Buyer(bids: [110, 130], name: 'A'),
      Buyer(bids: [], name: 'B'),
      Buyer(bids: [125], name: 'C'),
      Buyer(bids: [105, 115, 90], name: 'D'),
      Buyer(bids: [132, 135, 140], name: 'E'),
    ];
  });

  test("Validate no bids are above the reserve price of 200", () {
    final product = Product(reservedPrice: 200);
    final areValidBids = auctionUseCase.areThereValidBids(buyers, product);
    expect(areValidBids, false);
  });

  test("Validate there are bids above the reserve price of 100", () {
    final product = Product(reservedPrice: 100);
    final areValidBids = auctionUseCase.areThereValidBids(buyers, product);
    expect(areValidBids, true);
  });

  test("Should return the buyer with the highest bid", () {
    buyers = [
      Buyer(bids: [110, 130], name: 'A'),
      Buyer(bids: [], name: 'B'),
      Buyer(bids: [125], name: 'C'),
      Buyer(bids: [105, 115, 1000], name: 'D'),
      Buyer(bids: [132, 135, 140], name: 'E'),
    ];
    Buyer bestBuyer = auctionUseCase.findHighestBidder(buyers);

    expect(bestBuyer.name, "D");
  });

  test("Validate bids equal to the reserve price should be considered valid",
      () {
    product = Product(reservedPrice: 130);
    buyers = [
      Buyer(bids: [110, 130], name: 'A'),
      Buyer(bids: [], name: 'B'),
      Buyer(bids: [125], name: 'C'),
      Buyer(bids: [105, 115, 90], name: 'D'),
      Buyer(bids: [120, 125, 128], name: 'E'),
    ];

    final areValidBids = auctionUseCase.areThereValidBids(buyers, product);
    expect(areValidBids, true);
  });
  test("Should return the correct winning price based on different scenarios",
      () {
    // Second highest bid is above the reserve price
    product = Product(reservedPrice: 100);
    buyers = [
      Buyer(bids: [110, 130], name: 'A'),
      Buyer(bids: [125], name: 'C'),
      Buyer(bids: [132, 135, 140], name: 'E'),
    ];

    var winner = auctionUseCase.findHighestBidder(buyers);
    var winningPrice =
        auctionUseCase.findWinningPrice(buyers, product.reservedPrice, winner);
    expect(winningPrice, equals(130)); // Second highest bid is 130

    // Second highest bid is equal to the reserve price
    product = Product(reservedPrice: 130);
    buyers = [
      Buyer(bids: [110, 130], name: 'A'),
      Buyer(bids: [125], name: 'C'),
      Buyer(bids: [132, 135, 140], name: 'E'),
    ];

    winner = auctionUseCase.findHighestBidder(buyers);
    winningPrice =
        auctionUseCase.findWinningPrice(buyers, product.reservedPrice, winner);
    expect(winningPrice, equals(130));

    // Second highest bid is below the reserve price
    product = Product(reservedPrice: 130);
    buyers = [
      Buyer(bids: [110, 120], name: 'A'),
      Buyer(bids: [115], name: 'C'),
      Buyer(bids: [132, 135, 140], name: 'E'),
    ];

    winner = auctionUseCase.findHighestBidder(buyers);
    winningPrice =
        auctionUseCase.findWinningPrice(buyers, product.reservedPrice, winner);
    expect(winningPrice, equals(130));
  });
}
