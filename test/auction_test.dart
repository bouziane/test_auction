import '../domain/entities/buyer.dart';
import '../domain/entities/product.dart';
import '../domain/usecases/auction_usecases.dart';
import 'package:test/test.dart';

void main() {
  late AuctionUseCase auctionUseCase;
  late List<Buyer> buyers;

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
    Buyer bestBuyer = auctionUseCase.findHighestBid(buyers);

    expect(bestBuyer.name, "D");
  });
}
