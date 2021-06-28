//
//  ItemCell.swift
//  POSForCustomers
//
//  Created by 花逢坂詩織 on 2021/6/22.
//

import SwiftUI

struct ItemCell: View {
    @EnvironmentObject var userdata: Userdata
    @State var scannedCode: Item
    let cellWidth: CGFloat = UIScreen.main.bounds.width * 5/6
    let cellHeight: CGFloat = UIScreen.main.bounds.height * 1/10
    
    func getIndex(item: Item) -> Int {
        for i in 0..<userdata.items.count {
            if scannedCode.code == userdata.items[i].code {
                return i
            }
        }
        return -1
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .shadow(radius: 2)
                .foregroundColor(Color(red: 248/255, green: 248/255, blue: 255/255))
                .frame(width: cellWidth, height: cellHeight)
            HStack {
                Text(scannedCode.code)
                    .font(.headline)
                    .frame(width: cellWidth * 6/10)
                    .padding(.leading)
                
                Divider()
                
                VStack {
                    HStack {
                        Image(systemName: "bag")
                        
                        Image(systemName: "minus.circle")
                            .onTapGesture {
                                if scannedCode.itemCount > 0 {
                                    userdata.items[getIndex(item: scannedCode)].itemCount -= 1
                                    if scannedCode.itemCount == 0 {
                                        // todo: 删除商品
                                        userdata.items.remove(at: getIndex(item: scannedCode))
                                    }
                                }
                            }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .shadow(radius: 1)
                                .foregroundColor(Color(red: 245/255, green: 245/255, blue: 245/255))
                                .frame(width: 25, height: 25)
                            Text("\(userdata.items[getIndex(item: scannedCode)].itemCount)")
                                .bold()
                        }
                        
                        Image(systemName: "plus.circle")
                            .onTapGesture {
                                if scannedCode.itemCount < userdata.items[getIndex(item: scannedCode)].stock {
                                    userdata.items[getIndex(item: scannedCode)].itemCount += 1
                                }
                            }
                    }
                    .padding(.trailing)
                    
                    HStack {
                        Image(systemName: "yensign.circle")
                        Text("3")
                            .bold()
                    }
                    .padding(.trailing)
                }
                .frame(width: cellWidth * 4/10)
                .padding(.trailing, 15)
            }
            .padding()
        }
        .frame(width: cellWidth, height: cellHeight)
        .padding(2)
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ItemCell(scannedCode: Item(code: "ABCDE-12345", id: 0))
    }
}
