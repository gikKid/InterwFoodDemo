import Foundation

final class PizzaRequest<Resource:APIResource> {
    let resource:Resource
    
    init(resource:Resource) {
        self.resource = resource
    }
    
}

extension PizzaRequest:NetworkRequest {
    
    func decode(_ data: Data) -> [Resource.ModelType]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        var wrapper:[Resource.ModelType]?
        
        do {
            let results = try decoder.decode(WrapperPizza<Resource.ModelType>.self, from: data)
            wrapper = results.pizzas
        } catch (let error) {
            //TODO: Handling error and show user !!!
            print(error)
        }
        return wrapper
    }
    
    func execute(withCompletion completion: @escaping ([Resource.ModelType]?, Error?) -> Void) {
        self.load(resource.url, withCompletion: completion)
    }
}
