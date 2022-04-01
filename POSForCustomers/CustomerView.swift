//
//  ContentView.swift
//  POSForCustomers
//
//  Created by 花逢坂詩織 on 2021/6/21.
//

import SwiftUI
import CodeScanner

struct CustomerView: View {
    @EnvironmentObject var userdata: Userdata
    @Environment(\.presentationMode) var presentationMode
    @State var isPresentingScanner: Bool = false
    @State var isPresentingClear:Bool = false
    @State var isSameItem: Bool = false
    @State var itemId: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.uturn.left")
                    .padding(.leading)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                
                Spacer()
                Text("商品列表")
                    .bold()
                
                Spacer()
                Image(systemName: "gearshape")
                    .padding(.trailing)
                    .onTapGesture {
                        isPresentingClear.toggle()
                    }
            }
            
            ZStack(alignment: .topTrailing) {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(red: 245/255, green: 245/255, blue: 245/255))
                        .frame(width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height * 3/4)
                    
                    if userdata.items.isEmpty {
                        Text("购物车里还没有商品")
                            .foregroundColor(.secondary)
                    }
                    
                    ScrollView {
                        VStack {
                            ForEach(userdata.items) { item in
                                if item.itemCount != 0 {
                                    ItemCell(scannedCode: item)
                                }
                            }
                        }
                        .padding(.top)
                    }
                }
                
                if isPresentingClear {
                    Button(action: {
                        userdata.items = []
                        itemId = 0
                    }) {
                        ButtonView(text: "清空",
                                   width: UIScreen.main.bounds.width * 1/4,
                                   height: UIScreen.main.bounds.height * 1/20,
                                   color: .black)
                    }
                    .padding()
                }
            }
            
            HStack {
                HStack {
                    Image(systemName: "cart")
                    Text("合计¥\(userdata.getTotal())")
                        .bold()
                }
                .frame(width: UIScreen.main.bounds.width * 1/3,
                       alignment: .trailing)
                
                
                Button(action: {
                    self.isPresentingScanner = true
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 80)
                            .shadow(radius: 2)
                            .foregroundColor(.black)
                            .frame(width: 80, height: 80)
                        Text("扫码\n添加")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .padding(.bottom)
                }
                .sheet(isPresented: $isPresentingScanner) {
                    self.scannerSheet
                }
                .frame(width: UIScreen.main.bounds.width * 1/3)
                
                Button(action: {
                    // 结账
                }) {
                    ButtonView(text: "结算(\(itemId))",
                               width: UIScreen.main.bounds.width * 1/4,
                               height: UIScreen.main.bounds.height * 1/20,
                               color: .black)
                }
                .frame(width: UIScreen.main.bounds.width * 1/3,
                       alignment: .leading)
            }
        }
    }

    var scannerSheet: some View {
        CodeScannerView(codeTypes: [.qr]) { result in
            switch result {
            case .success(let code):
                isPresentingScanner = false
                // 扫描成功 添加商品
                // 遍历购物车 查找是否存在相同商品
                // 不存在时直接添加商品 存在相同商品时数量+1
                for i in 0..<userdata.items.count {
                    if code == userdata.items[i].code {
                        isSameItem = true
                        userdata.items[i].itemCount += 1
                        print(userdata.items[i].itemCount)
                    }
                }
                if !isSameItem {
                    itemId += 1
                    userdata.items.append(Item(code: code, id: itemId))
                }
                isSameItem = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
