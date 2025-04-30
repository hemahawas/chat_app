sealed class GroupStates {}

class GroupInitialState extends GroupStates {}

// Create group
class CreateGroupSuccessState extends GroupStates {}

class CreateGroupLoadingState extends GroupStates {}

class CreateGroupErrorState extends GroupStates {}

// Connection Error
class ConnectionErrorState extends GroupStates {}

class GetGroupArgumentsState extends GroupStates {}
