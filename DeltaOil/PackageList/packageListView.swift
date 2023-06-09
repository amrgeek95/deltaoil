//
//  packageListView.swift
//  DeltaOil
//
//  Created by Amr Sobhy on 09/06/2023.
//

import SwiftUI

struct packageListView: View {
    let package:packageModel = packageModel(id: "", name: "باكيدج اللمه", description: "", image: "https://imextrading-co.com/deltaoil/package_img/10kilo.jpeg", size: "5")
    @StateObject var packageVM = packageViewModel()
    let containerWidth = UIScreen.main.bounds.size.width / 2.5

    var body: some View {
       
        VStack(alignment:.leading) {
            
            VStack{
                ForEach(packageVM.packageItem, id: \.id) { package in
                    HStack(spacing:2){
                        fetchUrlImage(imageUrl: package.image)
                            .frame(height: containerWidth, alignment: .leading)
                            .frame(maxWidth:containerWidth)
                            .cornerRadius(10)
                        VStack(alignment:.leading) {
                            
                            Text("\(package.name) = (\(package.size) كجم)")
                                .modifier(packageTitleCustomFont())
                                .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
                                .font(.body)
                                .foregroundColor(Color.primary)
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.leading)
                            Text(package.description)
                                .modifier(packageBodyCustomFont())
                                .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
                                .font(.caption)
                                .foregroundColor(Color.secondary)
                        }
                        .frame(minWidth: 0,maxWidth: .infinity)
                        .padding(.leading,20)

                     }
                    .padding()
                    .frame(maxWidth: .infinity,idealHeight: containerWidth + 50)
                    .background(Color("lightGreenBox"))
                    .cornerRadius(10)
                }
            }
            
        }.onAppear{
            packageVM.getPackages(size: "100")
        }

    }
}

struct packageListView_Previews: PreviewProvider {
    static var previews: some View {
        packageListView()
    }
}
