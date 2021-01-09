class RedirectionFound implements  Exception{

  @override
  String toString(){
    return "Too Many Redirection.";
  }
}




class ResourceNotFound implements Exception{
  String message;
  ResourceNotFound(this.message);
  @override
  String toString(){
    return "Resource ${this.message} Not Found";
  }
}

class UnProccedEntity implements Exception{
  @override
  String toString(){
    return "Missing fieldes";
  }
}

class LoginFaild implements Exception{
  @override
  String toString(){
    return "Credential Rejected";
  }
}

class PropertyIsRequiered implements Exception{
  String field;
  PropertyIsRequiered(this.field);

  @override
  String toString(){
    return "Property  ${this.field}Is Requiered ";
  }
}
