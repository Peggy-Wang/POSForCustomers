//
//  StaffView.swift
//  POSForCustomers
//
//  Created by 花逢坂詩織 on 2021/6/24.
//

import SwiftUI

struct StaffView: View {
    @EnvironmentObject var userdata: Userdata
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.uturn.left")
                    .padding(.leading)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                
                Spacer()
                Text("库存")
                    .bold()
                
                Spacer()
                Image(systemName: "gearshape")
                    .padding(.trailing)
            }
        
            ZStack {
                Rectangle()
                    .foregroundColor(Color(red: 245/255, green: 245/255, blue: 245/255))
            }
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.height * 4/5)
            
            HStack {
                
            }
        }
    }
}

struct StaffView_Previews: PreviewProvider {
    static var previews: some View {
        StaffView()
    }
}
