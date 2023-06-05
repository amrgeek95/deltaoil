//
//  orderDetailView.swift
//  DeltaOil
//
//  Created by Mac on 12/02/2023.
//

import SwiftUI
import Combine
class orderDetailViewModel: ObservableObject {
    @Published var detailItem:orderDetailModel = orderDetailModel()
    let columns :[GridItem] = [GridItem(.adaptive(minimum: 200)),GridItem(.adaptive(minimum: 200 ))]
    
    @Published var orderObject : orderDetailEnviroment = orderDetailEnviroment()
    func setup(orderDetail:orderDetailModel){
        self.detailItem = orderDetail
    }
}

struct orderDetailView: View {
    @StateObject var orderDetailVM: orderDetailViewModel = orderDetailViewModel()

    @EnvironmentObject var orderDetailObject : orderDetailEnviroment
    var body: some View {
        ScrollView{
            customNavBar(title: "طلب رقم \(orderDetailVM.detailItem.id)",backBtnHidden: false)
            if let package = orderDetailVM.detailItem.package {
                if !package.isEmpty {
                    VStack(alignment: .leading) {
                        orderItemView(orderDetailM: orderDetailVM.detailItem)
                        VStack{
                            if !orderDetailVM.detailItem.notes.isEmpty {
                                Text("ملاحظات")
                                    .font(.title2)
                                Text(orderDetailVM.detailItem.notes)
                                    
                            }
                            Text("معلومات الطلب")
                                .font(.title2)
                            LazyVGrid(columns: orderDetailVM.columns,alignment: .leading){
                                Text("رقم الطلب")
                                Text(orderDetailVM.detailItem.id)
                                Text("تاريخ الطلب")
                                 Text(orderDetailVM.detailItem.created)
                                Text("العنوان ")
                                 Text(orderDetailVM.detailItem.address)
                                Text("الباكدجات ")
                                 Text("\(package.count) قطع ")
                                    .multilineTextAlignment(.trailing)
                                
                            }
                            LazyVStack{
                                ForEach(package ,id: \.id){ item in
                                    packageViewLoop(name: item.name, quantity: item.quantity)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            .background(appColors.backgroundGreenColor)
                            .cornerRadius(10)
                            .padding(.vertical,50)
                            

                        }
                        .multilineTextAlignment(.leading)
                        .padding()
                        Spacer()
                    }
                }
            }
        }
        .onAppear{
            
            orderDetailVM.setup(orderDetail: orderDetailObject.orderDetail)
            
        }
        .ignoresSafeArea()
    }
}

struct orderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        packageViewLoop(name: "amr", quantity: "5")
            .previewLayout(.sizeThatFits)
    }
}
struct packageViewLoop :View{
    @State var name : String
    @State var quantity : String
    var body: some View {
        HStack{
            Text(name)
            Spacer()
            Text(quantity + "قطع " )
        }
        .padding()
        .frame(maxWidth: UIScreen.main.bounds.maxX)

    }
}
