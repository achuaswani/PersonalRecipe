//
//  Recipe.swift
//  Aswani
//
//  Created by Aswani on 11/26/20.
//  Copyright © 2020 Aswani. All rights reserved.
//
import Foundation

struct Recipe: Decodable, Encodable {
    var id: String = UUID().description
    let title: String
    var category: String
    let description: String?
    let image: String?
    let ingredients: String
    let steps: String?
    let tips: String?
    let author: String?
    let dateTime: String?
    func recipeData() -> Data? {
        let recipeDictionary =  [
            "id": self.id,
            "title": self.title,
            "category": self.category,
            "description": self.description ?? "",
            "image": self.image ?? "",
            "ingredients": self.ingredients,
            "steps": self.steps ?? "",
            "tips": self.tips ?? "",
            "author": self.author ?? ""
        ]
        guard let data = try? JSONEncoder().encode(recipeDictionary) else {
            return nil
        }
        return data
    }
}
