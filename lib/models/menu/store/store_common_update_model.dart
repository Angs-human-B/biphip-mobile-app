import 'package:bip_hip/models/menu/store/store_overview_model.dart';

class StoreCommonUpdateModel {
    Stores? stores;

    StoreCommonUpdateModel({
        required this.stores,
    });

    factory StoreCommonUpdateModel.fromJson(Map<String, dynamic> json) => StoreCommonUpdateModel(
        stores: Stores.fromJson(json["store"]),
    );
}