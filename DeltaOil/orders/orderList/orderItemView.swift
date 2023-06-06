//
//  orderItemView.swift
//  DeltaOil
//
//  Created by Mac on 12/02/2023.
//

import SwiftUI



struct orderItemView: View {
     @State var orderDetailM:orderDetailModel
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .stroke(appColors.borderGrayColor, lineWidth: 2)
                .background(appColors.textBGGrayColor)
            VStack(alignment: .leading){
                HStack{
                    Image(systemName: "person")
                        .font(.body)
                        .foregroundColor(appColors.darkGreenColor)
                    Text("رقم الطلب : \(orderDetailM.id)")
                        .font(.body)
                        .foregroundColor(appColors.darkGreenColor)
                        
                    Spacer()
//                    Text(orderDetailM.statusMessage)
//                        .padding(10)
//                        .background(.white)
//                        .cornerRadius(10)
//                        .font(.title3)
//                        .foregroundColor(appColors.greenColor)
//                        .overlay {
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(appColors.greenColor)
//                        }
                    
                }
                seperatorCustomView(type: "horizontal")
                    .padding(.horizontal,20)
                HStack(alignment: .center){
                    orderItemBottmView(title:"الكمية ", subTitle: "\(orderDetailM.oilAmount) كجم")
                    Spacer()
                    seperatorCustomView(type: "vertical")
                    Spacer()
                    orderItemBottmView(title: "تاريخ الطلب", subTitle: orderDetailM.created)

                }
            }
            .padding()

        }
        .frame(maxWidth: .infinity,maxHeight: 130)
        .padding()
    }
}

struct orderItemBottmView: View {
    @State var title :String
    @State var subTitle :String
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .foregroundColor(.gray)
            Text(subTitle)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
}

struct orderItemView_Previews: PreviewProvider {
    static var previews: some View {
        let orderM:orderDetailModel = orderDetailModel()
        orderItemView(orderDetailM: orderM)
            
            
    }
}
