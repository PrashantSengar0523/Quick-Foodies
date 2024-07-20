class ProductModel {
  String id;
  String image;
  String name;
  String description;
  String price;
  String calories;
  String rating;
  String category;

  ProductModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.description,
      required this.price,
      required this.calories,
      required this.rating,
      required this.category
      }
    );

    Map<String,dynamic> toJson(){
      return{
        'ID':id,
        'Image':image,
        'Name':name,
        'Description':description,
        'Price':price,
        'Calories':calories,
        'Rating':rating,
        'Category':category
      };
    }

    factory ProductModel.fromMap(Map<String,dynamic> data){
      return ProductModel(
        id: data['Id']??'',
        image: data['Image']??'',
        name: data['Name']??'',
        description: data['Description']??'',
        price: data['Price']??'',
        calories: data['Calories']??'112',
        rating: data['Rating']??'4.1',
        category: data['Category']??'',
        );
    }
}
