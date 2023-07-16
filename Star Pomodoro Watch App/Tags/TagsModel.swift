//
//  TagsModel.swift
//  Star Pomodoro Watch App
//
//  Created by Henrique Marques on 11/07/23.
//

import Foundation

struct TagsScreenModel: Identifiable {
    let id = UUID()
    let tagName: String
}

class TagsScreenModelPopulate: ObservableObject {
    
    @Published var data: [TagsScreenModel] = []
    
    init() {
        data.append(contentsOf: [TagsScreenModel(tagName: "Study"), TagsScreenModel(tagName: "Work"), TagsScreenModel(tagName: "Program")])
    }
    
    func addData(_ tagName: String) {
        data.append(TagsScreenModel(tagName: tagName))
    }
    func removeTag(atIndex: IndexSet) {
        data.remove(atOffsets: atIndex)
    }
    
}
