//
//  Service.swift
//  DeltaOil
//
//  Created by Mac on 07/02/2023.
//

import Foundation
import Combine



protocol RequestProtocol {
    var path:String {get}
    var parameters:[URLQueryItem] {get}
    var method:httpMethod {get}
    func setUrl()->URL?
}
extension RequestProtocol {
    func setUrl() -> URLComponents? {
        var urlComponent = URLComponents()
        urlComponent.path = "\(EndPoint.baseUrl) + \(path)"
        urlComponent.queryItems = parameters
        return urlComponent
      //  return urlc
    }
}
enum httpMethod :String {
    case get = "GET"
    case post = "POST"
}


enum EndPoint {
    static let baseUrl = "https://imextrading-co.com/deltaoil/"
    static let signupUrl = "\(EndPoint.baseUrl)global/signup"
    static let sliderUrl = "\(EndPoint.baseUrl)global/get_sliders"
    static let get_packages = "\(EndPoint.baseUrl)global/get_packages"
}
extension EndPoint {
    static let cityUrl = "\(EndPoint.baseUrl)global/cities"
    static let areaUrl = "\(EndPoint.baseUrl)global/areas"
}
enum orderEndPoint {
    static let getOrders = "\(EndPoint.baseUrl)orderapi/get_orders"
    static let newRequest = "\(EndPoint.baseUrl)orderapi/save_order"
}


struct endPointModel {
    var path:String
    var queryItem:[URLQueryItem] = []
}


protocol NetworkProtocol{
    
    func fetchData<T:Decodable>(type:T.Type,urlRequest:URLRequest,completion: @escaping (Result<T,Error>)->Void)
    

}
extension NetworkProtocol {
}

enum netWorkError :Error {
    case badRequest
    case error(error:String)
    var description:String {
        switch self {
        case .badRequest:
        
            return "url is not valid"
        default:
            return "anonymus error"
        }
    }
}
final class NetworkLayer:NetworkProtocol {
    var cancellable : AnyCancellable?
    
    func fetchData<T>(type: T.Type, urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
        print(urlRequest.url)
        
        
        self.cancellable = URLSession.shared.dataTaskPublisher(for: urlRequest)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink { response in
                switch response {
                case .failure(let error):
                    print(error.localizedDescription)
                    
                    completion(Result.failure(netWorkError.error(error: error.localizedDescription)));
                    break;
                case .finished:
                    break;
                }
            } receiveValue: { result in
                completion(Result.success(result))
            }

    }
    
    func saveData<T>(type: T.Type, urlRequest: URLRequest, completion: @escaping (Result<String, Error>) -> Void) where T : Decodable {
        let task = URLSession.shared.dataTask(with: urlRequest) { data , _ , error in
            guard let data = data , error == nil else {
                completion(Result.failure(netWorkError.error(error: error?.localizedDescription ?? "")))
                return
            }
            do {
                let getresponse = try JSONDecoder().decode(responseSave.self, from: data)
                DispatchQueue.main.async {
                    print(getresponse)
                    if getresponse.status {
                        completion(Result.success(getresponse.message))
                    }else{
                        completion(Result.failure(netWorkError.error(error: getresponse.message)))
                    }
                }
            }
            catch (let error){
                completion(Result.failure(netWorkError.error(error: error.localizedDescription ?? "")))
            }
        }
        task.resume()
    }
    
    
}
