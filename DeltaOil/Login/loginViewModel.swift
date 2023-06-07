//
//  loginViewModel.swift
//  DeltaOil
//
//  Created by Amr Sobhy on 06/06/2023.
//

import Foundation


import Combine

import SwiftUI


class loginViewModel:ObservableObject {
    
    @AppStorage("userData") var userData = Data()
     var userSession :userSetting!

    @Published var showHome:Bool = false

    
    
    @Published var mobileTextField:String = ""
    @Published var nameTextField:String = ""
    @Published var emailTextField:String = ""
    @Published var passwordTextField:String = ""
    @Published var addressTextField:String = ""
    
    @Published var inlineErrors = (name:"",email:"",passwod:"",mobile:"",address:"",city:"",password:"")
    
    @Published  var selectedCity : CitiesModel = CitiesModel(id: "-1", name: "")
    @Published  var selectedArea : AreasModel = AreasModel(id: "",name: "")
    
    @Published var selectPlaceHolder = (city:"برجاء اختيار المحافظة" , area:"برجاء اختيار المنطقة")
    
    @Published var showAreaSection = false
    
    @Published var cities :[CitiesModel] = []
    @Published var areas :[AreasModel] = []
    
    @Published var isloading:Bool = false
    @Published var hasError :Bool = false
    @Published var error: SignupError?
    @Published var cancellable = Set<AnyCancellable>()
    private var bag = Set<AnyCancellable>()
    
    
    
    
    
    var nameValid:AnyPublisher<inputValidationError,Never>{
        $nameTextField
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map{
                if $0.count >= 4 {
                    self.inlineErrors.name = ""
                    return  inputValidationError.valid
                }else{
                    self.inlineErrors.name = ($0.isEmpty) ? "" : inputValidationError.name.errorDescription
                    return   inputValidationError.name
                }
            }
            .eraseToAnyPublisher()
    }
    var mobileValid:AnyPublisher<inputValidationError,Never>{
        $mobileTextField
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
        
            .map{
                if $0.count == 11 {
                    self.inlineErrors.mobile = ""
                    
                    return  inputValidationError.valid
                }else{
                    self.inlineErrors.mobile = ($0.isEmpty) ? "" :inputValidationError.mobile.errorDescription
                    
                    return   inputValidationError.mobile
                }
            }
            .eraseToAnyPublisher()
    }
    
    let emailPred = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    var emailValid:AnyPublisher<inputValidationError,Never>{
        $emailTextField
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map{
                if self.emailPred.evaluate(with: $0) {
                    self.inlineErrors.email = ""
                    
                    return  inputValidationError.valid
                }else{
                    self.inlineErrors.email = ($0.isEmpty) ? "" : inputValidationError.email.errorDescription
                    return   inputValidationError.email
                }
            }
            .eraseToAnyPublisher()
    }
    
    var passwordValid:AnyPublisher<inputValidationError,Never>{
        $passwordTextField
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map{
                if $0.count > 5 {
                    self.inlineErrors.password = ""
                    return  inputValidationError.valid
                }else{
                    self.inlineErrors.password = ($0.isEmpty) ? "" : inputValidationError.password.errorDescription
                    return   inputValidationError.password
                }
            }
            .eraseToAnyPublisher()
    }
    var addressValid:AnyPublisher<inputValidationError,Never>{
        $addressTextField
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map{
                if $0.count > 4 {
                    self.inlineErrors.address = ""
                    return  inputValidationError.valid
                }else{
                    self.inlineErrors.address = ($0.isEmpty) ? "" : inputValidationError.address.errorDescription
                    return   inputValidationError.address
                }
            }
            .eraseToAnyPublisher()
    }
    var cityValid:AnyPublisher<inputValidationError,Never>{
        $selectedCity
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map{
                if $0.id != "-1" {
                    self.inlineErrors.city = ""
                    return  inputValidationError.valid
                }else{
                    self.inlineErrors.city =  inputValidationError.city.errorDescription
                    return   inputValidationError.city
                }
            }
            .eraseToAnyPublisher()
    }
    
    
    
    private var allInputValid :AnyPublisher<Bool,Never>{
        let validate1 =  Publishers.CombineLatest4(nameValid, mobileValid, emailValid, passwordValid)
            .map{ name , mobile , email , password in
                if name.inputStatus ==  true && mobile.inputStatus == true && email.inputStatus == true && password.inputStatus == true {
                    return true
                }
                return false
            }
            .eraseToAnyPublisher()
        let validate2 =  Publishers.CombineLatest(addressValid,cityValid )
            .map{ address , city  in
                if address.inputStatus ==  true && city.inputStatus == true  {
                    return true
                }
                return false
            }
            .eraseToAnyPublisher()
        
        return Publishers.CombineLatest(validate1, validate2)
            .map{ first , second in
                if first ==  true && second == true  {
                    return true
                }
                return false
            }
            .eraseToAnyPublisher()
        
        
    }
    
    @Published var isFormValid:Bool = false
    init() {

        
        allInputValid
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellable)
    }
    
    func setUp(session:userSetting){
        self.userSession = session
    }
    
    func getCities() {
        
        guard let url = URL(string: EndPoint.cityUrl) else { return  }
        isloading = true
        URLSession.shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: responseCityModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] status in
                self?.isloading = false
                switch status {
                case .failure(let error):
                    self?.hasError = true
                    
                    self?.error = SignupError.custom(error: error)
                default:break
                }
                
            }) { [weak self] city  in
                if city.status ==  true {
                    self?.showAreaSection = true
                    self?.cities = city.cities ?? []
                }else{
                    self?.showAreaSection = false
                    self?.error = SignupError.customMessage(error: "no data found")
                }
            }
            .store(in: &bag)
    }
    func getAreas() {
        
        guard selectedCity.id != "-1" else {
            return
        }
        guard let urlComp = NSURLComponents(string: EndPoint.areaUrl) else { return  }
        let _ = print(urlComp)
        
        let _ = print("amr")
        
        urlComp.queryItems = [URLQueryItem(name: "city_id", value: selectedCity.id)]
        
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: responseAreaModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] status in
                self?.isloading = false
                switch status {
                case .failure(let error):
                    self?.hasError = true
                    self?.error = SignupError.custom(error: error)
                default:break
                }
                
            }) { [weak self] areas  in
                if areas.status ==  true {
                    self?.showAreaSection = true
                    self?.areas = areas.areas ?? []
                }else{
                    self?.showAreaSection = false
                    self?.error = SignupError.customMessage(error: "no data found")
                }
            }
            .store(in: &bag)
    }
    func signUp(){
        
        if !isFormValid {
            self.hasError = true
            self.error = SignupError.customMessage(error: "برجاء ملئ البيانات اولا")

            return
        }
        guard let urlComponent = NSURLComponents(string: EndPoint.signupUrl) else {
            return
        }
        urlComponent.queryItems = [
            URLQueryItem(name: "name", value: nameTextField),
            URLQueryItem(name: "mobile", value: mobileTextField),
            URLQueryItem(name: "password", value: passwordTextField),
            URLQueryItem(name: "email", value: emailTextField),
            URLQueryItem(name: "city_id", value: selectedCity.id),
            URLQueryItem(name: "area_id", value: selectedArea.id),
            URLQueryItem(name: "address", value: addressTextField)
        ]
        let _ = print(urlComponent.queryItems)
        
        var urlRequest = URLRequest(url: urlComponent.url!)
        urlRequest.httpMethod = "GET"
        URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: signupresponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] status in
                self?.isloading = false
                switch status {
                case .failure(let error):
                    self?.hasError = true
                    self?.error = SignupError.custom(error: error)
                default:break
                }
                
            }){ [weak self] data  in
                if data.status ==  true {
                    do {
                        
                    //    self?.userData = try JSONEncoder().encode(data.data)
                        self?.userSession.userInfo = data.data
                        self?.showHome.toggle()
                    }
                    catch{
                        
                    }
                }else{
                    self?.hasError = true
                    self?.error = SignupError.customMessage(error: data.message ?? "")
                }
            }
            .store(in: &bag)
        
        
    }
}
