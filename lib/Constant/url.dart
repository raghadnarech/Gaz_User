class AppApi {
  static String url = "https://mayadeen-md.com/gaz/public/api";
  static String IMAGEURL = 'https://mayadeen-md.com/gaz/public/storage/';
  static String LOGIN = '/login';
  static String Signup = '/register';
  static String AddAddress = '/add-address';
  static String GetAllMyAddress = '/get-address';
  static String DeleteAddress(int id) => '/delete-address/$id';
  static String GetAllServices = '/get-all-services';
  static String GetAllServiceSuppliers(int idService) =>
      '/get-all-service-suppliers/$idService';
  static String GetCategoriesAsSupplier(int idSupplire) =>
      '/get-categories-as-supplier/$idSupplire';
  static String GetProductSubCat(int idSupplire) =>
      '/get-product-sub-cat/$idSupplire';
  static String GetGazSuppliers = '/get-gaz-suppliers';
  static String GetFeesValues = '/get-fees-values';
  static String ChooseWay(String filter, dynamic IdOrCode) =>
      '/choose-way?$filter=$IdOrCode';
  static String StoreOrder = '/gaz-store-order';
  static String GetMyOrders = '/get-orders-by';
  static String GetOrderById(int id) => '/get-order-by-id/$id';
  static String GetMyCancelOrders = '/get-my-cancel-orders';
  static String ReciveOrderAsUser(int id) => '/recieve-order-as-user/$id';
  static String WalletTransaction = '/wallet-transactions';
  static String GetProfile = '/profile';
  static String UpdateProfile = '/update-user-info';
  static String UpdateCustomChoice = '/update-default';
  static String GetInfo = '/get-info';
  static String SendContact = '/send-contact';
  static String GetNoti = '/get-noti';
  static String Report = '/report';
  static String Rate = '/rate';
  static String GetTickets = '/get-tickets';
  static String GetMyTickets(int id) => '/get-my-ticket/$id';
  static String PostTicket(int id) => '/post-ticket/$id';
  static String SendMessage(int id) => '/send-message/$id';
  static String UpdateOrder(int id) => '/update-order/$id';
  static String CancelOrder(int id) => '/user-cancel-order/$id';
  static String GetAllRegions = '/get-all-regions';
  static String GetAllCities(int id) => '/get-all-cities/$id';
  static String GetAllDistricts(int id) => '/get-all-districts/$id';
  static String GetCountry = '/get-countries';
  static String GetBanks = '/get-banks';
  static String GetCardBanks = '/get-cards';
  static String AddCard = '/add-card';
  static String DeleteCard(int id) => '/delete-card/$id';

  //////////////////////////////////////////////////

  static String StorePoint = '/store-points';
  static String StoreUser = '/store-user';
  static String GetUserCode = '/get-user-code';
}
