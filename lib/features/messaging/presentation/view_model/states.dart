abstract class MessagingStates {}

// Initial
class MessagingInitialState extends MessagingStates {}

// Get messaging arguments
class GetMessagingArgumentsLoadingState extends MessagingStates {}

class GetMessagingArgumentsSuccessState extends MessagingStates {}

class GetMessagingArgumentsErrorState extends MessagingStates {}

// Send message
class SendMessageLoadingState extends MessagingStates {}

class SendMessageSuccessState extends MessagingStates {}

class SendMessageErrorState extends MessagingStates {}
