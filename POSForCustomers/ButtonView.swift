//
//  ButtonView.swift
//  POSForCustomers
//
//  Created by 花逢坂詩織 on 2021/6/22.
//

import SwiftUI

struct ButtonView: View {
    let text: String
    let width: CGFloat
    let height: CGFloat
    let color: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .shadow(radius: 2)
                .foregroundColor(color)
                .frame(width: width,
                       height: height)
            Text(text)
                .foregroundColor(.white)
                .bold()
        }
    }
}
