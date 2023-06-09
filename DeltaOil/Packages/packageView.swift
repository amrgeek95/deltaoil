//
//  packageView.swift
//  DeltaOil
//
//  Created by Mac on 22/01/2023.
//

import SwiftUI
import Combine
struct pcgItem:View {
    let package:packageModel
    @State var package_count = 0
    
    @Binding var max_count:Int
    @Binding var currentOilCount:Int
    @State var itemPackage : requestPackage!
    
    @EnvironmentObject var packageEnviroment : packageEnviromentObject
    
    
    var body: some View {
        
        VStack(alignment:.leading) {
            HStack(spacing:2){
                fetchUrlImage(imageUrl: package.image)
                    .frame(height: 60, alignment: .leading)
                    .frame(maxWidth:60)
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
                .padding(.horizontal,10)
                HStack{
                    Button(action: {
                        plusAction()
                    }, label: {
                        Image("plusBtn")
                    })
                    Text("\(package_count)")
                    Button(action: {
                        minusAction()
                    }, label: {
                        Image("minusBtn")

                    })
                }
                .frame(maxWidth: 80)
             }
            .padding()
            .frame(maxWidth: .infinity,idealHeight: 100)
            .background(Color("lightGreenBox"))
            .cornerRadius(10)
        }.onAppear{
            itemPackage = requestPackage(id: package.id, size: Int(package.size) ?? 0, quantiy: 0)
        }
        .onChange(of: packageEnviroment.currentPackages) { newValue in
            print("new package enviroment \(newValue)")

            if newValue.isEmpty {
                package_count = 0
            }else{
                for i in newValue.indices {
                    if newValue[i].id == package.id {
                        package_count = newValue[i].quantiy
                        break;
                    }
                    print("value changed package enviroment\(newValue)")

                }
            }
           
        }
    }
    
    func plusAction(){
        
        if let size = Int(package.size ){
            if size <= (max_count - currentOilCount) {
                currentOilCount += size
                var check = false
                for i in packageEnviroment.currentPackages.indices {
                    if packageEnviroment.currentPackages[i].id == package.id {
                        packageEnviroment.currentPackages[i].quantiy += 1
                        package_count = packageEnviroment.currentPackages[i].quantiy
                        check = true
                        break;
                    }
                }
                if !check{
                    itemPackage.quantiy = 1
                    package_count = 1
                    packageEnviroment.currentPackages.append(itemPackage)
                }
            }
        }
        
    }
    func minusAction(){
        if let size = Int(package.size ){
            if package_count != 0 {
                currentOilCount -= size
               
                for i in packageEnviroment.currentPackages.indices {
                    if packageEnviroment.currentPackages[i].id == package.id {
                        if package_count == 0 {
                            packageEnviroment.currentPackages.remove(at: i)
                            package_count = 0
                        }else{
                            packageEnviroment.currentPackages[i].quantiy -= 1
                            package_count = packageEnviroment.currentPackages[i].quantiy
                        }
                        
                    }
                }
                
            }
        }
    }
}

struct packageView: View {
    @StateObject var packageVM = packageViewModel()
    @State var maxCount = 100
    @State var currentOilCount = 5
    @State var itemPackage = [requestPackage(id: "", size: 0, quantiy: 0)]
    var body: some View {
        VStack {
        ForEach(packageVM.packageItem, id: \.id) { package in
            pcgItem(package: package,max_count: $maxCount,currentOilCount: $currentOilCount)
           }
        }
        .onAppear{
            packageVM.getPackages()
        }
    }
}
struct packageView_Previews: PreviewProvider {
    static var previews: some View {
        packageView()

        
    }
}
