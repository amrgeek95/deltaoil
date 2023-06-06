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
                        fetchUrlImage(imageUrl: homeVM.sliders.first?.image ?? "")
                            .frame(idealHeight: 200.0,maxHeight: 200)

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

struct homeSliderView: View {
    var containerHeight = UIScreen.main.bounds.size.height * 0.22
    var title:String
    var body: some View {
        ZStack {
            Image("Slider")
                .resizable()
                .clipped()
                .cornerRadius(10)
            HStack{
                Image("Man")
                    .aspectRatio(contentMode: .fit)
                    .padding(.trailing,10.0)
                    .padding(.leading,0)
                    .frame(alignment: .bottom)
                
                Spacer()
                VStack {
                    Spacer()
                    Text(title)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.trailing)
                        .padding(.bottom, 10.0)
                    
                    Text ("استبدل الزيت المستعمل بمواد عينية")
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.trailing)
                }
                .padding([.bottom, .trailing], 10.0)
                .frame( maxHeight: containerHeight)
                
                .clipped()

            }
        }
        .padding(.horizontal,10.0)
        .padding(.bottom,10.0)
        .frame(width: UIScreen.main.bounds.size.width , height: containerHeight)
    }
}

struct homeItemView: View {
    var containerHeight = UIScreen.main.bounds.size.height * 0.17
     var title : String
     var mainIcon : String
     var leftIcon : String
     var itemColor : String
     var body: some View {
         ZStack {
             Rectangle()
             .fill(Color(itemColor))
             .cornerRadius(20.0)
             .padding(.horizontal,10)
             VStack(alignment: .leading){
                 Image(mainIcon)
                     .frame( alignment: .trailing)
                     .padding(.bottom,10)
                 HStack{
                     Text(title)
                         .foregroundColor(Color.primary)
                     Spacer()
                     Image(leftIcon)
                         
                 }
             }
             .padding(.horizontal,30)

         }
         .frame(maxWidth: .infinity, idealHeight: containerHeight,maxHeight:containerHeight)



    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
            .ignoresSafeArea()
            .environmentObject(userSetting())
    }
}
