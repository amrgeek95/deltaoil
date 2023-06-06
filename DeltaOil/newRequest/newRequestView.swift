//
//  newRequestView.swift
//  DeltaOil
//
//  Created by Mac on 29/01/2023.
//




import SwiftUI
import Combine
struct requestErrorMessages{
    var oilAmountError : String
    var notesError : String
    var packageError : String
}
class packageEnviromentObject:ObservableObject {
    @Published var currentPackages : [requestPackage] = []
}


struct newRequestView: View {
    @EnvironmentObject var userObject:userSetting
    
    @StateObject var newRequestVM:newRequestViewModel = newRequestViewModel()
    @StateObject var packageVM = packageViewModel()
    @StateObject var packageEnviroment : packageEnviromentObject = packageEnviromentObject()
    
    
    
    var body: some View {
        ScrollView{
            ZStack {
                VStack(alignment:.leading) {
                    oilamountText
                    errorMessageLabel(labelTitle: newRequestVM.errorMessages.oilAmountError)
                    Rectangle()
                        .fill(Color.secondary)
                        .frame(maxWidth: .infinity,idealHeight: 1)
                        .padding(.vertical,20)
                    
                    errorMessageLabel(labelTitle: newRequestVM.errorMessages.packageError)
                    VStack{
                        ForEach(packageVM.packageItem, id: \.id) { package in
                            pcgItem(package: package,max_count: $newRequestVM.maxOilCount,currentOilCount: $newRequestVM.currentOilCount)
                                .frame(minWidth: 0,maxWidth: .infinity)
                                .environmentObject(packageEnviroment)
                        }
                    }
                    errorMessageLabel(labelTitle: newRequestVM.errorMessages.notesError)
                        .multilineTextAlignment(.leading)
                    
                    notesText
                    Button(action: {
                        if packageVM.packageItem.isEmpty {
                            packageVM.getPackages(size: newRequestVM.newRequestObject.oil_amount)
                        }else{
                            newRequestVM.submitAction()
                        }

                       // newRequestVM.submitAction()
                    }, label: {
                        if newRequestVM.loadingChecker {
                            HStack{
                                ProgressView()
                                Text("برجاء الانتظار")
                                    .padding()
                            }
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.white)
                            .background(appColors.greenColor)
                            .cornerRadius(10)
                            .opacity(0.7)

                        }else{
                            Text(packageVM.textOnSubmitAction)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.white)
                                .background(appColors.greenColor)
                                .cornerRadius(10)
                            
                        }
                        
                    })
                    .disabled(newRequestVM.loadingChecker)
                    
                }
                
                
            }
            .padding(.horizontal,20)
            
            
        }
        .alert("عفوا", isPresented: $newRequestVM.showAlert, actions: {
            Button(action: {
                newRequestVM.alertErrorMessage = ""
                newRequestVM.showAlert = false
            }, label: {
                Text("حسنا")
            })
        })
        .onAppear{
            newRequestVM.setup(package:packageEnviroment,session: userObject)
//            packageVM.getPackages()
        }
        
        .navigationBarHidden(true)
        .padding(.bottom,50)
        .ignoresSafeArea()
    }
}

struct newRequestView_Previews: PreviewProvider {
    static var previews: some View {
        newRequestView()
            .environmentObject(packageEnviromentObject())
            .environmentObject(userSetting())
        
    }
}
extension newRequestView {
    var oilamountText : some View {
        VStack(alignment: .leading) {
            labelDefaultView(labelTitle: "الكمية المتوقعة للزيت")
            HStack{
                TextField(text: $newRequestVM.newRequestObject.oil_amount ,
                          label: {
                    Text("الكمية المتوقعة ( حد ادني ٢ كجم) ")
                    //   Text("dasdas")
                })
                .textContentType(.telephoneNumber)
                .keyboardType(.asciiCapableNumberPad)
                .onChange(of: newRequestVM.newRequestObject.oil_amount){ newvalue in
                    guard let oilamount = Int(newvalue) else {
                        return
                    }
                    newRequestVM.validateOilInput(newvalue: newvalue)
                    packageVM.packageItem.removeAll()
                    if oilamount < 3 {
                        newRequestVM.errorMessages.oilAmountError = "لا يمكن اختيار اقل من ٢ كيلو زيت"
                        return
                    }
                


                }
                Text("| كجم")
                    .foregroundColor(.gray)
            }
            
            .padding()
            .background(Color("textBackgroundGrayColor"))
            .cornerRadius(10)
//            .overlay(
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(.white, lineWidth: 1.5)
//            )
            
            .multilineTextAlignment(.leading)
        }
    }
}
extension newRequestView {
    var notesText : some View {
        
        VStack(alignment: .leading) {
            if !packageVM.packageItem.isEmpty {
                
                labelDefaultView(labelTitle: "ملاحظات اضافيه  ")
                TextField(text: $newRequestVM.newRequestObject.notes ,
                          label: {
                    Text("يمكنك كتابة ملاحظات اضافيه .... ")
                    //   Text("dasdas")
                })
                .textContentType(.addressState)
                .keyboardType(.default)
                .padding()
                .background(Color("textBackgroundGrayColor"))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("greenColor"), lineWidth: 0.5)
                )
                .multilineTextAlignment(.leading)
                .frame(height: 100)
            }
            
        }
    }
}
