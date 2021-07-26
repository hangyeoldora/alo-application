//
//  ModelData.swift
//  ALO
//
//  Created by 이한결 on 2021/07/01.
//

import SwiftUI

// Model Data....

struct BagModel: Identifiable {
    var id = UUID().uuidString
    var image: String
    var title: String
    var price: String
}

var bags = [
    BagModel(image: "bag1", title: "Office Bag", price: "40,000"),
    BagModel(image: "bag2", title: "Stylus Bag", price: "24,000"),
    BagModel(image: "bag3", title: "Stylus Bag", price: "134,000"),
    BagModel(image: "bag4", title: "Stylus Bag", price: "29,400"),
    BagModel(image: "bag5", title: "Stylus Bag", price: "20,400"),
    BagModel(image: "bag6", title: "Stylus Bag", price: "33,400"),
]

// For Top Scrooling Tab Buttons....
var scroll_Tabs = ["여성의류", "패션잡화", "디지털/가전", "생활용품", "장터"]
