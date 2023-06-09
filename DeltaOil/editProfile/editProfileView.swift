//
//  editProfileView.swift
//  DeltaOil
//
//  Created by Amr Sobhy on 08/06/2023.
//

import SwiftUI

struct editProfileView: View {
    @EnvironmentObject var session: userSetting
    
    @StateObject var editProfileVM = editProfileViewModel()
    @State var showHome = false
    var body: some View {
        NavigationView{
            ScrollView {
                customNavBar(title: "الملف الشخصي",backBtnHidden: false)
                    .frame(minHeight: 130.0,maxHeight: 130.0)
                VStack(alignment:.trailing,spacing: 20){
                    Section {
                        nameTextInput
                        mobileNumberView
                        emailTextInput
                        addressTextInput
                        cityPickerInput
                        areaPickerInput
                        actionBtn
                            .disabled(!editProfileVM.isFormValid)
                            .opacity(editProfileVM.isFormValid ? 1:0.5)
                    }
                }.padding(.horizontal,20)
                    .padding(.bottom,20)
            }
            .alert(editProfileVM.error?.errorDescription ?? "", isPresented: $editProfileVM.hasError) {
                Button("OK", role: .cancel) { }
            }
            .alert(editProfileVM.alertMessage, isPresented: $editProfileVM.showalert, actions: {
                Button(action: {
                    showHome = true
                }, label: {
                    Text("حسنا")
                })
            })
            .fullScreenCover(isPresented: $showHome) {
                tabView(tabSelection: 3)
            }
            .onAppear{
                
                editProfileVM.setUp(session: session)
                editProfileVM.getCities()
            }
            .ignoresSafeArea()
        }
        .onTapGesture {
                  self.hideKeyboard()
                }
    }
}
extension editProfileView {
    var nameTextInput : some View {
        inputGenerator(input: $editProfileVM.nameTextField,
                       placeHolder: "برجاء كتابة الاسم", isSecure: false,
                       label: "الاسم",contentType: .name,keyBoardType: .default,
                       prompt: editProfileVM.inlineErrors.name)
        
    }
    var mobileNumberView : some View {
        inputGenerator(input: $editProfileVM.mobileTextField,
                       placeHolder: "الموبايل",
                       isSecure: false,
                       label: "الموبايل",
                       contentType: .telephoneNumber,keyBoardType: .asciiCapableNumberPad
                       ,prompt: editProfileVM.inlineErrors.mobile)
    }
    
    var emailTextInput : some View {
        inputGenerator(input: $editProfileVM.emailTextField, placeHolder: "برجاء كتابة البريد الالكتروني بشكل صحيح", isSecure: false, label: "البريد الالكتروني",contentType: .emailAddress,keyBoardType: .emailAddress,prompt: editProfileVM.inlineErrors.email)
        
    }
    
    
    var addressTextInput : some View {
        
        inputGenerator(input: $editProfileVM.addressTextField, placeHolder: "برجاء كتابة العنوان", isSecure: false, label: "العنوان",contentType: .fullStreetAddress,keyBoardType: .default,prompt: editProfileVM.inlineErrors.address)
        
        
    }
}
extension editProfileView {
    var cityPickerInput : some View {
        VStack(alignment:.trailing){
            labelDefaultView(labelTitle: editProfileVM.selectPlaceHolder.city)
                .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)

            Menu(editProfileVM.selectPlaceHolder.city) {
                Picker(selection: $editProfileVM.selectedCity, label: Text("")) {
                    ForEach(editProfileVM.cities, id: \.self) { city in
                        Text(city.name)
                    }
                }.onChange(of: editProfileVM.selectedCity) { _ in
                    editProfileVM.selectPlaceHolder.city = editProfileVM.selectedCity.name
                    editProfileVM.getAreas()
                }
            }
            .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
            .padding()
            .background(appColors.textBGGrayColor)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(appColors.greenColor, lineWidth: 0.5)
            )
            .foregroundColor(appColors.greenColor)
            
        }
    }
    var areaPickerInput : some View {
        
        VStack(alignment:.trailing){
            labelDefaultView(labelTitle: "برجاء اختيار المنطقة")
                .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
            Menu(editProfileVM.selectPlaceHolder.area) {
                Picker(selection: $editProfileVM.selectedArea, label: Text("")) {
                    ForEach(editProfileVM.areas, id: \.self) { area in
                        Text(area.name ?? "" )
                    }
                }.onChange(of: editProfileVM.selectedArea) { _ in
                    editProfileVM.selectPlaceHolder.area = editProfileVM.selectedArea.name ?? "amr"
                }
            }
            .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
            .padding()
            .background(appColors.textBGGrayColor)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(appColors.greenColor, lineWidth: 0.5)
            )
            .foregroundColor(appColors.greenColor)
        }
    }
}

extension editProfileView {
    var actionBtn : some View{
        Button(action: {
            editProfileVM.saveAction()
        }, label: {
            Text("حفظ ")
                .modifier(buttonCustomFont())
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .top)
                .padding()
                .foregroundColor(Color.white)
                .background(Color("greenColor"))
                .cornerRadius(10)
            
        }).fullScreenCover(isPresented: $editProfileVM.dataSaved) {
            tabView()
        }
    }
}


struct editProfileView_Previews: PreviewProvider {
    static var previews: some View {
        editProfileView()
            .environmentObject(userSetting())
    }
}
