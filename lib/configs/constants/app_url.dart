class AppUrl {
  AppUrl._();

  // base url
  static const String baseUrl = "https://go-server-ikbn.onrender.com/api/app";

  //auth
  static const String auth = "https://go-server-ikbn.onrender.com/api/auth";

  static const String login = "$auth/login";

  static const String register = "$auth/register";

  static const String forgotPassword = "$auth/forgot_password";

  static const String changePassword = "https://go-server-ikbn.onrender.com/api/app/user/change_password";

  // google
  static const String authGoogle = "$auth/google";

  static const String googleLogin = "$authGoogle/login";

  static const String googleCallback = "$authGoogle/callback";

  //trip
  static const String trip = "$baseUrl/trip/";

  //home
  static const String banner = "$baseUrl/banner/";

  static const String category = "$baseUrl/category/";

  static const String place = "$baseUrl/place/";

  static const String placeTrip = "$baseUrl/place/suggest/";

  static const String placeDetail = "$baseUrl/place/";

  static const String placeComment = "$baseUrl/place/";

  static const String updateComment = "$baseUrl/comment/";

  //admin url
  static const String admin = "$baseUrl/admin";

  static const String logInAdmin = "$admin/login.php";

  static const String readOrderAdmin = "$admin/read_orders.php";

  //user url
  static const String users = "$baseUrl/user";

  static const String validateEmail = "$users/validate_email.php";

  static const String signUpUser = "$users/signup.php";

  static const String logInUser = "$users/login.php";

  static const String getUserFromToken = "$users/info";

  //up load image url
  static const String upLoadImage = "https://go-server-ikbn.onrender.com/api/upload/";

  //items url
  static const String items = "$baseUrl/items";

  static const String uploadNewItem = '$items/upload.php';

  static const String searchItem = '$items/search.php';

  //clothes url
  static const String clothes = "$baseUrl/clothes";

  static const String trendingClothes = '$clothes/trending.php';

  static const String newClothes = '$clothes/all.php';

  //cart url
  static const String cart = "$baseUrl/cart";

  static const String additem = '$cart/add.php';

  static const String cartList = '$cart/read.php';

  static const String updateCartItem = '$cart/update.php';

  static const String deleteCartItem = '$cart/delete.php';

  //favorite
  static const String favorite = "$baseUrl/favorite";

  static const String addFavorite = "$favorite/add.php";

  static const String deleteFavorite = '$favorite/delete.php';

  static const String validateFavorite = '$favorite/validate_favorite.php';

  static const String readFavorite = '$favorite/read.php';

  //order
  static const String order = "$baseUrl/order";

  static const String neworder = "$order/add.php";

  static const String readOrder = "$order/read.php";

  static const String readHistoryOrder = "$order/read_history.php";

  static const String updateStatusOrder = "$order/update_status.php";

  static const hostImages = "$baseUrl/transactions_proof_images/";
}
