//
//  orderView.swift
//  DeltaOil
//
//  Created by Mac on 12/02/2023.
//

import SwiftUI
import Combine
class orderDetailEnviroment : ObservableObject {
    @Published var orderDetail : orderDetailModel = orderDetailModel()
    @Published var status = 0
}
class orderViewModel: ObservableObject {

    @Published var orderStatus = 0
    @Published var ordersModel : [orderDetailModel] = []
    let networkService = NetworkLayer()
    @Published var showItemDetail = false
    var userSession :userSetting!

    func setup(session:userSetting)  {
        self.userSession = session
    }
    
    func retriveOrders(){
        
        
        guard let urlComponent = NSURLComponents(string: orderEndPoint.getOrders) else {
            return
        }
        urlComponent.queryItems = [
            URLQueryItem(name: "customer_id", value: userSession.userInfo?.id),
            URLQueryItem(name: "status", value:String(orderStatus) )]
     
        let urlRequest = URLRequest(url: urlComponent.url!)
        
        print(urlRequest)
        
        networkService.fetchData(type: orderResponseModel.self, urlRequest: urlRequest) {[weak self] result in
            guard let self = self else{return}
            switch (result){
            case .success(let data):
                print(data.data)
                
                if data.status == true {
                    self.ordersModel = data.data
                }else{
                }
                break;
            case .failure(let error): break;
                 
            }
        }
    }
}

struct orderView: View {
    @EnvironmentObject var userObject:userSetting
    @EnvironmentObject var orderDetailObject : orderDetailEnviroment

    @StateObject var orderVM = orderViewModel()
    var body: some View {
        NavigationView{
            ScrollView{
                customNavBar(title: "الطلبات",backBtnHidden: true)
                VStack {
                    HStack(alignment: .top,spacing: 10) {
                        VStack(alignment:.leading){
                            Text("طلبات مكتملة")
                                .font(.body)
                                .foregroundColor(orderVM.orderStatus == 1 ? .white:appColors.greenColor)
                                .frame(width: .infinity)
                                .padding()
                        }
                        .frame(minWidth: 0,maxWidth: .infinity,minHeight: 60)
                        .background(orderVM.orderStatus == 0 ? .white:appColors.greenColor)
                        .cornerRadius(10)
                        .clipped()
                        .shadow(color: .gray, radius: 1, x: 0, y: 0)

                        .onTapGesture {
                            orderVM.orderStatus = 1
                            orderVM.retriveOrders()
                        }
                        
                        Spacer()
                        Text("طلبات قيد التنفيذ")
                            .font(.body)
                            .foregroundColor(orderVM.orderStatus == 0 ? .white:appColors.greenColor)
                            .cornerRadius(20)
                            .frame(minWidth: 0,maxWidth: .infinity,minHeight: 60)
                        .background(orderVM.orderStatus == 1 ? .white:appColors.greenColor)
                        .cornerRadius(10)
                        .clipped()
                        .shadow(color: .gray, radius: 1, x: 0, y: 0)
                        .onTapGesture {
                            orderVM.orderStatus = 0
                            orderVM.retriveOrders()
                        }
                        Spacer()

                    }
                    .padding(.horizontal)

                    Spacer()
                    ForEach(orderVM.ordersModel, id: \.id){ order in
                        orderItemView(orderDetailM: order)
                            .onTapGesture {
                                orderDetailObject.orderDetail = order
                                orderVM.showItemDetail = true

                            }.sheet(isPresented: $orderVM.showItemDetail) {
                                
                                orderDetailView()
                                    .environmentObject(orderDetailObject)
                            }
                    }
                }
                .onAppear{
                    orderVM.setup(session: userObject)
                    orderVM.retriveOrders()
                }
                
            }
            .ignoresSafeArea()
        }
    }
}

struct orderView_Previews: PreviewProvider {
    static var previews: some View {
        orderView()
            .environmentObject(orderDetailEnviroment())
            .environmentObject(userSetting())

            
        
    }
}
