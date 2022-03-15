class ApiUrl{

//base url
static  String baseUrl="http://hajibabaapi.asollearning.com/api/";

// others url
static  String storeMangerLogin="$baseUrl/StoreManagerLogin";
static  String  updateStoreManagerFirebaseId= '$baseUrl/UpdateStoreManagerFirebaseId';
static  String getStoreManagerById = '$baseUrl/GetStoreManagerById';
static  String dashboardUrl="$baseUrl/StoreDashboard?StoreId=";
static  String resetPasswordUrl="$baseUrl/StoreManagerRequestToChangePassword?StoreMangerId=";
static  String updatePhysicalAddressUrl="$baseUrl/UpdateStoreManagerPhysicalAddress";


//orders url
static  String pendingOrderUrl="$baseUrl/GetStorePendingOrder?StoreId=";
static  String processingOrderUrl="$baseUrl/GetStoreProcessingOrder?StoreId=";
static  String completeOrderUrl="$baseUrl/GetStoreCompletedOrder?StoreId=";
static  String readyForCollectionUrl="$baseUrl/GetStoreReadyForCollectionOrder?StoreId=";
static  String allOrderUrl="$baseUrl/StoreAllOrders?StoreId=";
static  String todayOrderUrl="$baseUrl/GetStoreTodayOrder?StoreId=";

//order detail url
static  String orderDetailUrl="$baseUrl/GetOrderById?OrderId=";

//order status url
static  String allOrderStatusUrl="$baseUrl/GetAllOrderStatus";
static  String updateStatusUrl="$baseUrl/UpdateOrderStatus";








}
