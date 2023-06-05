//
//  fetchingImage.swift
//  DeltaOil
//
//  Created by Mac on 28/01/2023.
//

import Foundation
import SwiftUI
import Combine
struct fetchUrlImage:View{
    let imageUrl:String
    @State var data:Data?
    
    var body: some View {
    
        if let data = data , let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .scaledToFit()
        }else{
            Image(systemName: "video")
                .resizable()
                .scaledToFit()
                .onAppear{loadImageFromUrl()}
        }
    }
    func loadImageFromUrl(){
        
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        
        URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: {  data , _ , error in
            self.data = data
            
        }).resume()
    }
}
