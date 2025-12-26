import Foundation
import Combine

class APIService {
    private var cancellables = Set<AnyCancellable>()
    
    // Fetch images with pagination
    func fetchImages(page: Int, completion: @escaping (Result<ImageResponse, Error>) -> Void) {
        let endpoint = "http://localhost:5001/image_list?page=\(page)" // Assuming API supports pagination via `page` parameter
        
        print("server: \(endpoint)")
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ImageResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completionResult in
                switch completionResult {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            }, receiveValue: { response in
                completion(.success(response))
            })
            .store(in: &cancellables)
    }
}

//import Foundation
//import Combine
//
//class APIService {
//    private var cancellables = Set<AnyCancellable>()
//    
//    // Simple fetch method that accepts endpoint and model type
//    func fetch<T: Codable>(endpoint: String, modelType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
//        guard let url = URL(string: endpoint) else {
//            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
//            return
//        }
//        
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map { $0.data } // Extract the data from the response
//            .decode(type: T.self, decoder: JSONDecoder()) // Decode into the model type
//            .receive(on: DispatchQueue.main) // Ensure we are on the main thread for UI updates
//            .sink(receiveCompletion: { completionResult in
//                switch completionResult {
//                case .finished:
//                    break
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }, receiveValue: { decodedModel in
//                completion(.success(decodedModel))
//            })
//            .store(in: &cancellables)
//    }
//}
