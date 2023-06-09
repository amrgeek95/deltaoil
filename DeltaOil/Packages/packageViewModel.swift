//
//  File.swift
//  DeltaOil
//
//  Created by Mac on 28/01/2023.
//

import Foundation
import SwiftUI
import Combine


enum apiError :Error{
    case badUrl
    
    var description:String {
        switch self {
        case .badUrl:
            return "bad"
        default:
            return ""
        }
    }
}

class packageViewModel : ObservableObject {
    @Published var packageItem:[packageModel] = []
    @Published var packageItemone:packageModel = packageModel.init(id: "1", name: "Amora", description: "Ahmed hassan youssef",image: "",size:
    "0")
    @Published var textOnSubmitAction = "عرض الهدايا المتاحة"

    var cancellable = Set<AnyCancellable>()
    
    init () {
        newpackage(type: responseData.self) { result in
            
            switch(result) {
                
            case .success(let data):
                print("dine")
            case .failure(let error):
                print("done")
            }
        
        }
    }
    
    
    
    func newpackage<T:Decodable>(type : T.Type,completion:@escaping (Result<T,apiError>) ->Void){
        guard let url = URL(string: "")else{
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard  error != nil else{
                completion(Result.failure(apiError.badUrl))
                return
            }
            do {
                guard let newdata = data else{
                    return
                }
                let decodedData = try JSONDecoder().decode(type, from: newdata)

                completion(Result.success(decodedData))
                
            }catch {
                
            }
            
        }.resume()
    }
    
    func getPackages (size:String = ""){

        guard let url = URL(string:"https://imextrading-co.com/deltaoil/global/packages?size=\(size)") else {
            return
        }
        print(url)
        
         URLSession.shared.dataTaskPublisher(for: url)

            .map(\.data)
            .decode(type: responseData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("error")
                    break;
                default:
                    print("error")
                    break;
                }
            }, receiveValue: { [weak self] data in
                DispatchQueue.main.async {
                    self?.packageItem = data.data
                    self?.textOnSubmitAction = "تأكيد"
                }
            })
            .store(in: &cancellable)
        
    }
    
    func getPackagess () {
        guard let url = URL(string:"https://imextrading-co.com/deltaoil/global/packages") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data , _ , error in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let getresponse = try JSONDecoder().decode(responseData.self, from: data)
                DispatchQueue.main.async {
                    self.packageItem = getresponse.data
                }
            }
            catch (let error){
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
