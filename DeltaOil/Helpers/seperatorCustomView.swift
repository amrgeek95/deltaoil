//
//  seperatorCustomView.swift
//  DeltaOil
//
//  Created by Mac on 12/02/2023.
//

import SwiftUI

struct seperatorCustomView: View {
    @State var type:String = ""
    var body: some View {
        switch type {
        case "horizontal":
            Rectangle()
                .fill(appColors.seperatorColor)
                .frame(height:1)
        case "vertical":
            Rectangle()
                .fill(appColors.seperatorColor)
                .frame(width:1)
            
            
        default:
            Rectangle()
                .fill(appColors.seperatorColor)
                .frame(width:1)
        }
        
    }
}

struct seperatorCustomView_Previews: PreviewProvider {
    static var previews: some View {
        seperatorCustomView()
    }
}
