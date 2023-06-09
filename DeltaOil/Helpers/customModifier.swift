//
//  customModifier.swift
//  DeltaOil
//
//  Created by Amr Sobhy on 07/06/2023.
//

import Foundation
import SwiftUI

struct moreItemModifier : ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(height: 55)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .top)
            .foregroundColor(.gray)
            .background(.white)
            .clipped()
            .cornerRadius(10)
            .padding(.horizontal,10)
            .padding(.vertical,5)
        
    }
}
struct headerTitleCustomFont :ViewModifier  {
    func body(content: Content) -> some View {
        content
            .font(.custom("Tajawal-Bold", size: 18))
    }
}
struct labelFont :ViewModifier  {
    func body(content: Content) -> some View {
        content
            .font(.custom("Tajawal-Regular", size: 16))
    }
}
struct titleLabelFont :ViewModifier  {
    func body(content: Content) -> some View {
        content
            .font(.custom("Tajawal-Bold", size: 18))
    }
}
struct buttonCustomFont :ViewModifier  {
    func body(content: Content) -> some View {
        content
            .font(.custom("Tajawal-Regular", size: 17))
    }
}

struct subLabelCustomFont :ViewModifier  {
    func body(content: Content) -> some View {
        content
            .font(.custom("Tajawal-Regular", size: 15))
    }
}

struct textAreaCustomFont :ViewModifier  {
    func body(content: Content) -> some View {
        content
            .font(.custom("Tajawal-Regular", size: 16))
    }
}

struct packageTitleCustomFont :ViewModifier  {
    func body(content: Content) -> some View {
        content
            .font(.custom("Tajawal-Medium", size: 15))
    }
}

struct packageBodyCustomFont :ViewModifier  {
    func body(content: Content) -> some View {
        content
            .font(.custom("Tajawal-Regular", size: 14))
    }
}
