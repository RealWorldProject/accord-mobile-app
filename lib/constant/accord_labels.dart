class AccordLabels {
  // Dynamic functions for overall use
  static String requireMessage(String fieldName) => "$fieldName is required!";
  static String invalidMessage(String fieldName) =>
      "Invalid $fieldName, please update it and check again";

  // All possible dialogbox/snackbar labels
  static const String okay = "Okay";
  static const String cancel = "Cancel";
  static const String delete = "Delete";
  static const String logout = "Log Out";
  static const String tryAgain = "Try Again";
  static const String imagePrieviewLabel = "Image Preview";
  static const String save = "Save";
  static const String stayIn = "Stay In";
  static const String confirm = "Confirm";

  // Login & register screen labels
  static const String greet = "Welcome Back!";
  static const String loginGuide = "Login to the Accord!";
  static const String forgotPassword = "Forgot Password?";
  static const String askRegister = "Don't have an account? ";
  static const String username = "Username";
  static const String password = "Password";
  static const String login = "Login";

  static const String registerTag = "Get yourself a new Account.";
  static const String firstName = "First Name";
  static const String lastName = "Last Name";
  static const String email = "Email";
  static const String register = "Register";
  static const String passwordLengthMessage =
      "Password must be atleast 6 character!";
  static const String askLogin = "Already have an account? ";

  // Cart & order screen labels
  static String fieldEssentialMessage(String fieldName) =>
      "$fieldName info is essential!";
  static const String cartScreenTitle = "My Cart";
  static const String emptyCartMessage = "No books added to the cart.";
  static const String orderInfoHeader = "Order Info";
  static const String grandTotal = "Grand Total";
  static const String proceedToOrder = "Proceed To Order";
  static const String orderScreenTitle = "Shipping Address";
  static const String onlinePaymentText = "Online Payment";
  static const String cashOnDeliveryText = "Cash On Delivery";
  static const String requireFullNameMessage = "Please state your full name!";
  static const String requirePhoneNumberMessage =
      "Please insert your phone number!";
  static const String fullName = "Full Name";
  static const String phoneNumber = "Phone Number";
  static const String province = "State/Province";
  static const String city = "City";
  static const String area = "Area";
  static const String physicalAddress = "Physical Address";
  static const String coordinates = "Co-ordinates (Optional)";
  static const String paymentMethod = "Payment Method";
  static const String submitButton = "Submit";

  // // // Home Screen labels
  static const String addBookLabel = "Add Book";
  // Search screen labels
  static const String searchForBooksLabel = "Search for Books";
  static const String emptySearchHisotyLabel = "Search & Explore new books";
  static const String initialSearchPageLabel = "Start your book exploration";

  // Category screen labels
  static const String allCategoriesLabel = "All Categories";
  static const String categoriesLabel = "Categories";
  static const String viewAll = "View All";

  // Book view screen labels
  static const String featuredBooksLabel = "Featured Books";
  static const String availableForExchange = "Available for Exchange";
  static const String requestBook = "Request Book";
  static const String requestedBookLabel = "Requested Book:";
  static const String bookInOffer = "Book In Offer:";
  static const String ratingAndReviewTitle = "Rating & Reviews";
  static const String viewMore = "View More";
  static const String bookPriceLabel = "Book's Price";
  static const String addToCartLabel = "Add to Cart";

  // Profile screen lables
  static const String myProfile = "My Profile";
  static const String favorites = "Favorites";
  static const String myOrders = "My Orders";
  static const String myRequests = "My Requests";
  static const String changePassword = "Change Password";
  static const String editDetails = "Edit Details";
  static const String editBook = "Edit Book";
  static const String deleteBook = "Delete Book";
  static const String noBookPostedLabel = "You have not posted any book yet.";
  static const String notAvailableForExchange = "Not available for exchange.";
  //Review Book Screen Labels
  static const String addReviewButtonTitle = "Write a Review";
  static const String submitReviewButtonTitle = "Submit Review";
  static const String editReviewButtonTitle = "Edit Your Review";
  static const String deleteReviewButtonTitle = "Delete Your Review";

  // Post & edit book screen labels
  static const String postBookTitle = "Post your Book";
  static const String positiveBookConditionValue = "New";
  static const String negativeBookConditionValue = "Old";
  static const String positiveBookExchangebleValue = "Yes";
  static const String negativeBookExchangableValue = "No";
  static const String image = "Image";
  static const String bookName = "Book Name";
  static const String authorName = "Author's Name";
  static const String category = "Category";
  static const String ifNoCategory = "No category available.";
  static const String ifCategory = "Select category";
  static const String price = "Price";
  static const String description = "Book Description";
  static const String condition = "Condition";
  static const String exhangable = "Exchangable";
  static const String postBook = "Post Book";
  static const String addImage = "Add Image";

  static const String updateBookTitle = "Update your Book";
  static const String updateBook = "Update Book";

  // Request screen labels
  static const String outgoingRequestLabel = "Outgoing Requests";
  static const String incomingRequestLabel = "Incoming Requests";
  static String emptyRequestMessage(String requestTab) =>
      "Your $requestTab is empty.";

  // Error labels
  static const String connectionErrorMessage =
      "Error while connecting to the server";
}
