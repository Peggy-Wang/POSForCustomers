//
//  Userdata.swift
//  POSForCustomers
//
//  Created by 花逢坂詩織 on 2021/6/22.
//

import Foundation
import SwiftUI

struct Item: Identifiable {
    var code: String = ""
    var price: Int = 3
    var total: Int = 0
    var itemCount: Int = 1
    var stock: Int = 100
    var id: Int = 0
    
    init(code: String, id: Int) {
        self.code = code
        self.id = id
    }
}

class Userdata: ObservableObject {
    @Published var items: [Item]
    
    init() {
        self.items = []
    }
    
    func getTotal() -> Int {
        var total: Int = 0
        
        for item in items {
            total += item.price * item.itemCount
        }
        return total
    }
}

