import 'package:octopush/model/mutual_funds.dart';
import 'package:octopush/model/mutual_funds_history.dart';
import 'package:octopush/model/mutual_funds_product.dart';
import 'package:octopush/repository/mutual_funds_history_repository.dart';
import 'package:octopush/service/interval_service.dart';
import 'package:octopush/service/transaction_service.dart';

class MutualFundsService {
  final MutualFundsHistoryRepository _repo;
  final IntervalService _intervalService;
  final TransactionService _transactionService;
  const MutualFundsService(
      this._repo, this._intervalService, this._transactionService);

  Future<bool> buyMutualFunds(MutualFundsProduct product, double amount) async {
    bool success = await _transactionService.purchase("Bought ${product.name}",
        _intervalService.getCurrentInterval(), amount);

    if (!success) return false;

    await _addRecord(product, amount);

    return true;
  }

  Future<void> _addRecord(MutualFundsProduct product, double amount) async {
    var mf = MutualFundsHistory.newDBRecord(
      product.id,
      _intervalService.getCurrentInterval().index,
      amount,
    );

    await _repo.add(mf);
  }

  Future<Map<MutualFundsProduct, double>> getOwnedProducts() async {
    var allMfHistory = await _repo.getAll();

    var allProducts = getAllMutualFundsProduct(getAllMutualFundsCategory());

    var ownedProducts = _getOwnedProductsMap(allProducts);

    allMfHistory.forEach((MutualFundsHistory mf) {
      MutualFundsProduct product = allProducts[mf.productId];
      ownedProducts[product] += mf.amount;
    } );

    return ownedProducts;
  }

  ///Iteratively add each available [MutualFundsProduct] into an empty map, denoting user's owned products
  Map<MutualFundsProduct, double> _getOwnedProductsMap(List<MutualFundsProduct> products){
    Map<MutualFundsProduct, double> ownedProducts = {};

    products.forEach((p) => ownedProducts[p] = 0);

    return ownedProducts;
  }

  List<MutualFunds> getAllMutualFundsCategory(){
    return mutualFundsJson.map((map) => MutualFunds.fromMap(map)).toList();
  }

  List<MutualFundsProduct> getAllMutualFundsProduct(List<MutualFunds> mfs) {
    List<MutualFundsProduct> products = [];

    mfs.forEach((mf) => products.addAll(mf.products));

    return products;
  }
}


const List<Map<String, dynamic>> mutualFundsJson = [
  {
    "category_name": "BNP Paribas",
    "products": [
      {"id": 0, "name": "Rupiah Plus IDR", "type": 0, "yield": 23.55},
      {"id": 1, "name": "Omega", "type": 1, "yield": 50.65},
      {"id": 2, "name": "Persona", "type": 2, "yield": 79.20}
    ]
  },
  {
    "category_name": "Schroder Dana",
    "products": [
      {"id": 3, "name": "Likuid", "type": 0, "yield": 25.95},
      {"id": 4, "name": "Andalan II", "type": 1, "yield": 46.20},
      {"id": 5, "name": "Prestasi Plus", "type": 2, "yield": 83.80}
    ]
  },
  {
    "category_name": "FFS Principal",
    "products": [
      {"id": 6, "name": "Cash Fund", "type": 0, "yield": 32.70},
      {"id": 7, "name": "Total Return Bond Fund", "type": 1, "yield": 41.40},
      {
        "id": 8,
        "name": "Islamic Equity Growth Syariah",
        "type": 2,
        "yield": 80.10
      }
    ]
  }
];