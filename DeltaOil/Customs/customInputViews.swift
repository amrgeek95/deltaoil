//
//  customInputViews.swift
//  DeltaOil
//
//  Created by Mac on 29/01/2023.
//

import Foundation
import SwiftUI
struct labelDefaultView :View {
    var labelTitle : String
    var body:some View {
        Text(labelTitle)
            .foregroundColor(.secondary)
            .font(.custom("Tajawal-Regular", size: 20))

    }
}
struct errorMessageLabel : View {
    var labelTitle : String
    var body:some View {
        Text(labelTitle)
            .font(.footnote)
            .multilineTextAlignment(.trailing)
            .foregroundColor(.red)
    }
}

struct inputCustomView_Previews: PreviewProvider {
    static var previews: some View {
        labelDefaultView(labelTitle: "amr" )
    }
}
