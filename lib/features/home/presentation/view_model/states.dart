abstract class HomeStates {}

class InitialHomeStates extends HomeStates {}

// Get chats
class GetChatsFromFirebaseSuccessState extends HomeStates {}

class GetChatsFromFirebaseLoadingState extends HomeStates {}

class GetChatsFromFirebaseErrorState extends HomeStates {}

class GetUserInfoSuccessState extends HomeStates {}

class GetUserInfoLoadingState extends HomeStates {}

class GetUserInfoErrorState extends HomeStates {}
