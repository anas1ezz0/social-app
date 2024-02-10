class FavouritesDataModel
{
bool? status;
String? message ;

FavouritesDataModel.fromJson(Map<String , dynamic>json )
{
status = json['status'];
message = json['message']  ;
}
}