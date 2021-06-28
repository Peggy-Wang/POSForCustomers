//
//  SelectView.swift
//  POSForCustomers
//
//  Created by 花逢坂詩織 on 2021/6/24.
//

import SwiftUI

struct SelectView: View {
    @State var isPresentingCustomerView: Bool = false
    @State var isPresentingStaffView: Bool = false
    
    var body: some View {
        VStack(spacing: UIScreen.main.bounds.height * 1/8) {
            Button(action: {
                isPresentingCustomerView = true
            }) {
                ButtonView(text: "我是顾客",
                           width: UIScreen.main.bounds.width * 2/5,
                           height: UIScreen.main.bounds.height * 1/14,
                           color: .black)
            }
            .fullScreenCover(isPresented: $isPresentingCustomerView) {
                CustomerView().environmentObject(Userdata())
            }
            
            Button(action: {
                isPresentingStaffView = true
            }) {
                ButtonView(text: "我是商家",
                           width: UIScreen.main.bounds.width * 2/5,
                           height: UIScreen.main.bounds.height * 1/14,
                           color: .black)
            }
            .fullScreenCover(isPresented: $isPresentingStaffView) {
                StaffView().environmentObject(Userdata())
            }
        }
    }
}

struct SelectView_Previews: PreviewProvider {
    static var previews: some View {
        SelectView()
    }
}
