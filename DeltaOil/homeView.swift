//
//  homeView.swift
//  DeltaOil
//
//  Created by Mac on 16/01/2023.
//

import SwiftUI

import Combine
class homeViewModel :ObservableObject {
    
    @Published var sliders  = [sliderModel]()
    func getSlider () {
        guard let url = URL(string:EndPoint.sliderUrl) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {[weak self]  data , _ , error in
            guard let data = data , error == nil else {
                return
            }
            guard let self = self else{return}
            
            do {
                let getresponse = try JSONDecoder().decode(sliderResponseModel.self, from: data)
                DispatchQueue.main.async {
                    self.sliders = getresponse.data
                    print(self.sliders)
                    
                }
            }
            catch (let error){
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
struct homeView: View {
    @EnvironmentObject var userObject:userSetting
    @StateObject var homeVM = homeViewModel()

    @State private var showSignUp = false
    @State private var showNewOrder = false
    var body: some View {
        NavigationView{
            ScrollView{
                customNavBar(title: "الرئيسية", backBtnHidden: true, subBtnHidden: false)

                VStack(spacing:0.0) {
                    if !homeVM.sliders.isEmpty {
                        fetchUrlImage(imageUrl: homeVM.sliders.first?.image ?? "",placeHolder: "")
                            .frame(idealHeight: 200.0,maxHeight: 200)
                            .padding(.bottom,15)

                    }
                    newRequestView()

                    Spacer()
                }
                Spacer()
            }
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)

        }
        .onAppear{
            homeVM.getSlider()
        }
        
    }

}
struct RoundedCornersShape: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
            .ignoresSafeArea()
            .environmentObject(userSetting())
    }
}
