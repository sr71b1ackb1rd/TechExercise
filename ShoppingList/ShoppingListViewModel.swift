//
//  ShoppingListViewModel.swift
//  ShoppingList
//
//  Created by Md Ruman Islam on 7/7/23.
//

import Foundation

class ShoppingListViewModel {
    struct Item {
        let title: String
        let detail: String
        var hasCheckmark: Bool
    }
    
    private(set) var items: [Item] = []
    
    func loadData() {
        items = [
            Item(title: "Item A", detail: "50 lb", hasCheckmark: true),
            Item(title: "Item B", detail: "1", hasCheckmark: false),
            Item(title: "Item C", detail: "2 lb", hasCheckmark: true)
        ]
    }
    
    var numberOfItems: Int {
        return items.count
    }
    
    func item(at index: Int) -> Item {
        return items[index]
    }
    
    func deleteItem(at index: Int) {
        items.remove(at: index)
    }
    
    func addItem(_ item: Item) {
        items.insert(item, at: 0)
    }
    
    func toggleCheckmark(at index: Int) {
        items[index].hasCheckmark.toggle()
    }
}
