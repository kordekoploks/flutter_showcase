
import 'package:eshop/data/models/product/pagination_data_model.dart';
import 'package:eshop/data/models/product/price_tag_model.dart';
import 'package:eshop/data/models/product/product_model.dart';
import 'package:eshop/data/models/product/product_response_model.dart';
import 'package:eshop/data/models/user/authentication_response_model.dart';

import 'package:eshop/data/models/user/user_model.dart';
import 'package:eshop/domain/usecases/product/get_product_usecase.dart';
import 'package:eshop/domain/usecases/user/sign_in_usecase.dart';
import 'package:eshop/domain/usecases/user/sign_up_usecase.dart';

//products
final tProductModel = ProductModel(
  id: "1",
  name: "name",
  description: "description",
  priceTags: [PriceTagModel(id: "1", name: "name", price: 100)],
  images: const ["image"],
  createdAt: DateTime(2000),
  updatedAt: DateTime(2000),
);

final tProductModelList = [tProductModel, tProductModel];
final tProductModelListFuture =
    Future<List<ProductModel>>.value([tProductModel, tProductModel]);

const tFilterProductParams = FilterProductParams();

//product response
final tProductResponseModel = ProductResponseModel(
  meta: PaginationMetaDataModel(
    page: 0,
    pageSize: 0,
    total: 0,
  ),
  data: [
    tProductModel,
    tProductModel,
  ],
);

//price tag
final tPriceTagModel = PriceTagModel(id: "1", name: "name", price: 100);

//user
const tUserModel = UserModel(
  id: '1',
  firstName: 'Text',
  lastName: 'Text',
  email: 'text@gmail.com',
  phoneNumber: "012345678",
);

//
const tAuthenticationResponseModel =
    AuthenticationResponseModel(token: 'token', user: tUserModel);
//params
const tSignInParams = SignInParams(username: 'username', password: 'password');
const tSignUpParams = SignUpParams(firstName: 'firstName', lastName: 'lastName', email: 'email', password: 'password',phoneNumber: 012345678);
