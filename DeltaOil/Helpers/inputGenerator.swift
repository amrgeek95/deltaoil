//
//  inputGenerator.swift
//  DeltaOil
//
//  Created by Mac on 02/02/2023.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct inputGenerator: View {
    @Binding var input : String
    var placeHolder: String
    var isSecure : Bool
    var label:String
    var contentType:UITextContentType?
    var keyBoardType : UIKeyboardType?
    var borderColor = appColors.greenColor
    var prompt:String = ""
    var body: some View {
        VStack(alignment:.leading){
            
            labelDefaultView(labelTitle: label)
            if isSecure {
                SecureField(text: $input,
                            label: {
                    Text("")
                    //   Text("dasdas")
                }).padding()
                    .background(Color("textBackgroundGrayColor"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("greenColor"), lineWidth: 0.5)
                    )
                    .multilineTextAlignment(.leading)
            }else{
                TextField(text: $input,
                          label: {
                    Text("")
                    //   Text("dasdas")
                })
                .textContentType(contentType ?? .givenName)
                .keyboardType(keyBoardType ?? .default)
                    .padding()
                    .background(Color("textBackgroundGrayColor"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(borderColor, lineWidth: 0.5)
                    )
                    .multilineTextAlignment(.leading)
            }
            if !prompt.isEmpty {
                Text(prompt)
                    .font(.caption)
                    .foregroundColor(Color.red)
                
            }
            
            
        }
        
    }
}

struct inputGenerator_Previews: PreviewProvider {
    static var previews: some View {
        inputGenerator(input: .constant(""), placeHolder: "hello", isSecure: false,label: "js[dg ",contentType: UITextContentType.telephoneNumber,keyBoardType: UIKeyboardType.default)
        
    }
}
