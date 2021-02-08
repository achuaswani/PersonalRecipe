//
//  Recipe.swift
//  Aswani
//
//  Created by Aswani on 11/26/20.
//  Copyright © 2020 Aswani. All rights reserved.
//

struct Recipe: Decodable {
    let id: String?
    let title: String
    let description: String?
    let image: String?
    let ingredients: String
    let steps: String?
    let tips: String?
    let author: String?
    let dateTime: String?
}
