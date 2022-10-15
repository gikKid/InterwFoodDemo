import Foundation

struct PizzaResource:APIResource {
    var methodPath: String {
        return ""
    }
    
    typealias ModelType = Pizza
}


// MARK: - Pizza
struct Pizza: Decodable {
    let id: Int
    let name: String
    let ingredients: String
}

//MARK: - Wrapper

struct WrapperPizza<T:Decodable>:Decodable {
    let pizzas:[T]
}

//MARK: - Data Cell View Model
struct DataCellViewModel {
    var title: String
    var descriptText:String
    var price:String
    var image:String
}

//MARK: - Category Cell View Model
struct CategoryCellViewModel {
    var title: String
}
