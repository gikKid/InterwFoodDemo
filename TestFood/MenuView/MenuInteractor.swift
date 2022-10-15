import Foundation

final class MenuInteractor: PresenterToInteractorMenuProtocol {
    
    var presenter: InteractorToPresenterMenuProtocol?
    
    func fetchData() {
        let pizzaResource = PizzaResource()
        
        let apiRequest = PizzaRequest(resource: pizzaResource)
        apiRequest.execute(withCompletion: { [weak self] (pizza, error) in
            if let error = error {
                self?.presenter?.fetchDataFailure(error: error.localizedDescription)
                return
            }
            guard let pizza = pizza else {
                self?.presenter?.fetchDataFailure(error: "Coudnt get data")
                return}
            self?.presenter?.fetchDataSuccessful(pizza: pizza)
        })
    }
    
    
    
    
}
