class AccordLabels {
  // Dynamic functions for overall use
  static String requireMessage(String fieldName) => "$fieldName is required!";
  static String invalidMessage(String fieldName) =>
      "Invalid $fieldName, please update it and check again";

  // All possible dialogbox/snackbar labels
  static const String okay = "Okay";
  static const String cancel = "Cancel";
  static const String close = "Close";
  static const String delete = "Delete";
  static const String logout = "Log out";
  static const String tryAgain = "Try again";
  static const String imagePrieviewLabel = "Image preview";
  static const String save = "Save";
  static const String stayIn = "Stay in";
  static const String confirm = "Confirm";
  static const String galleryOptionLabel = "Choose from gallery";
  static const String cameraOptionLabel = "Open camera";
  static const String keep = "Keep";

  // Login & register screen labels
  static const String greet = "Welcome back!";
  static const String loginGuide = "Login to the Accord!";
  static const String forgotPassword = "Forgot password?";
  static const String askRegister = "Don't have an account? ";
  static const String username = "Username";
  static const String password = "Password";
  static const String login = "Login";

  static const String registerTag = "Get yourself a new Account.";
  static const String firstName = "First name";
  static const String lastName = "Last name";
  static const String email = "Email";
  static const String register = "Register";
  static const String passwordLengthMessage =
      "Password must be atleast 6 character!";
  static const String askLogin = "Already have an account? ";

  // Cart & order screen labels
  static String fieldEssentialMessage(String fieldName) =>
      "$fieldName info is essential!";
  static const String cartScreenTitle = "My cart";
  static const String emptyCartMessage = "No books added to the cart.";
  static const String orderInfoHeader = "Order info";
  static const String grandTotal = "Grand total";
  static const String proceedToOrder = "Proceed to order";
  static const String orderScreenTitle = "Shipping address";
  static const String onlinePaymentText = "Online Payment";
  static const String cashOnDeliveryText = "Cash On Delivery";
  static const String requireFullNameMessage = "Please state your full name!";
  static const String requirePhoneNumberMessage =
      "Please insert your phone number!";
  static const String fullName = "Full name";
  static const String phoneNumber = "Phone number";
  static const String province = "State/Province";
  static const String city = "City";
  static const String area = "Area";
  static const String physicalAddress = "Physical address";
  static const String coordinates = "Co-ordinates (Optional)";
  static const String coordinatesExample = "eg(78.1523,182.16553)";
  static const String paymentMethod = "Payment method";
  static const String submitButton = "Submit";
  static const String total = "Total";

  // // // Home Screen labels
  static const String addBookLabel = "Add book";
  // Search screen labels
  static const String searchForBooksLabel = "Search for books";
  static const String emptySearchHisotyLabel = "Search & explore new books";
  static const String initialSearchPageLabel = "Start your book exploration";

  // Category screen labels
  static const String allCategoriesLabel = "All categories";
  static const String categoriesLabel = "Categories";
  static const String viewAll = "View all";

  // Book view screen labels
  static const String featuredBooksLabel = "Featured books";
  static const String availableForExchange = "Available for exchange";
  static const String requestExchangeBook = "Send exchange request";
  static const String requestedBookLabel = "Requested book:";
  static const String bookInOffer = "Book in offer:";
  static const String ratingAndReviewTitle = "Ratings and reviews";
  static const String viewMore = "View more";
  static const String bookPriceLabel = "Book's price";
  static const String addToCartLabel = "Add to cart";

  // Profile screen lables
  static const String myProfile = "My profile";
  static const String favorites = "Favorites";
  static const String myOrders = "My orders";
  static const String myRequests = "My requests";
  static const String changePassword = "Change password";
  static const String editDetails = "Edit details";
  static const String editBook = "Edit book";
  static const String deleteBook = "Delete book";
  static const String logoutLable = "Logout";
  static const String noBookPostedLabel = "You have not posted any book yet.";
  static const String notAvailableForExchange = "Not available for exchange.";

  // Update profile screen labels.
  static const String changeFullNameButtonLabel = "Change Full Name";
  static const String changePhoneNumberButtonLabel = "Change Phone Number";
  static String updateSuccessMessage(String updateField) =>
      "Your ${updateField.toLowerCase()} has been updated.";

  //Review Book Screen Labels
  static const String addReviewLabel = "Write your review";
  static const String editReviewLabel = "Edit your review";
  static const String postReviewButtonLabel = "Post review";
  static const String deleteReviewButtonTitle = "Delete your review";

  static const String addReviewScreenTitle = "Review book";
  static const String rateBookSectionLabel = "Rate this Book";

  // Post & edit book screen labels
  static const String postBookTitle = "Post your Book";
  static const String positiveBookConditionValue = "New";
  static const String negativeBookConditionValue = "Old";
  static const String positiveBookExchangebleValue = "Yes";
  static const String negativeBookExchangableValue = "No";
  static const String image = "Image";
  static const String bookName = "Book name";
  static const String authorName = "Author's name";
  static const String category = "Category";
  static const String ifNoCategory = "No category available.";
  static const String ifCategory = "Select category";
  static const String price = "Price";
  static const String description = "Book description";
  static const String condition = "Condition";
  static const String exhangable = "Exchangable";
  static const String postBook = "Post book";
  static const String addImage = "Add image";

  static const String updateBookTitle = "Update your book";
  static const String updateBook = "Update book";

  // Request screen labels
  static const String outgoingRequestLabel = "Outgoing requests";
  static const String incomingRequestLabel = "Incoming requests";
  static String emptyRequestMessage(String requestTab) =>
      "Your $requestTab is empty.";

  // change password screen labels
  static const String oldPassword = "Old password";
  static const String newPassword = "New password";
  static const String confirmNewPassword = "Confirm new password";

  //notificaton
  static const String notificationScreenTitle = "Notifications";

  // my order
  static const String myorderScreenTitle = "My orders";

  //my request
  static const String myrequestScreenTitle = "My requests";
  static const String editRequestLabel = "Edit your request";
  static const String deleteRequestLabel = "Delete your request";
  static const String deleteIncommingRequestLabel = "Delete request";
  static const String acceptRequestLabel = "Accept request";
  static const String declineRequestLabel = "Decline request";

  // add to cart snackbar
  static const String viewcart = "View cart";
  static const String cartSuccessMessage = "Successfully added to cart";

  // Error labels
  static const String connectionErrorMessage =
      "Error while connecting to the server";
}
