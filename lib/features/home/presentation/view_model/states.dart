abstract class HomeStates {}

class InitialHomeStates extends HomeStates {}

// Navigation
class ChangeNavBarState extends HomeStates {}

// Get chats
class GetChatsFromFirebaseSuccessState extends HomeStates {}

class GetChatsFromFirebaseLoadingState extends HomeStates {}

class GetChatsFromFirebaseErrorState extends HomeStates {}

class GetChatsFromLocalSuccessState extends HomeStates {}

class GetChatsFromLocalLoadingState extends HomeStates {}

class GetChatsFromLocalErrorState extends HomeStates {}

// User Info

class GetUserInfoSuccessState extends HomeStates {}

class GetUserInfoLoadingState extends HomeStates {}

class GetUserInfoErrorState extends HomeStates {}
