//
//  MenuList.swift
//  iOS Meta Capstone Project
//
//  Created by Cristina on 2023-09-15.
//

import Foundation

struct MenuList: Decodable{
    let menu: [MenuItem]
}

struct MenuItem: Decodable{
    let title:String
    let image:String
    let price:String
    let description:String
}
