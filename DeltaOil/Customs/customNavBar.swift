//
//  customNavBar.swift
//  DeltaOil
//
//  Created by Mac on 21/01/2023.
//

import SwiftUI

struct customNavBar: View {
    var title:String
    var backBtnHidden:Bool = false
    var subBtnHidden:Bool = true
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            ZStack{
                
                Image("headerShape")
                    .resizable()
                VStack{
                    HStack{
                        if !backBtnHidden {
                            Button(action: {
                                dismiss()
                            }, label: {
                                Image("back")
                            })
                        }
                        
                        Spacer()
                        titleView
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            
                        })
                    }
                    .padding(.top,60)
                    .padding(.horizontal,30)
                    .padding(.bottom,20)
                    .accentColor(.white)
                    Spacer()
                    RoundedCornersShape(corners: [.topLeft, .topRight], radius: 100.0)
                        .fill(Color.white)
                        .frame(width: UIScreen.main.bounds.size.width, height: 50, alignment: .bottom)
                        .offset(y:0)
                }
                
                
            }
            .ignoresSafeArea()
            .frame(height: 130.0, alignment: .top)
            Spacer()
        }
        
        
        
        
    }
}
extension customNavBar {
    private var titleView : some View {
        Text(title)
            .foregroundColor(Color.white)
        
    }
}

struct customNavBar_Previews: PreviewProvider {
    static var previews: some View {
        customNavBar(title: "Title",backBtnHidden: false)
            .previewLayout(.sizeThatFits)
            
    }
}
