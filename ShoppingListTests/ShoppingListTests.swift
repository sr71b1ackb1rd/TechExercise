//
//  ShoppingListTests.swift
//  ShoppingListTests
//
//  Created by Md Ruman Islam on 16/6/23.
//

import XCTest
@testable import ShoppingList

final class ShoppingListTests: XCTestCase {
    
    var viewModel: ShoppingListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ShoppingListViewModel()
        viewModel.loadData()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testLoadData() {
        XCTAssertEqual(viewModel.numberOfItems, 3)
    }
    
    func testDeleteItem() {
        viewModel.deleteItem(at: 0)
        XCTAssertEqual(viewModel.numberOfItems, 2)
    }
    
    func testItem() {
        let item = viewModel.item(at: 0)
        XCTAssertEqual(item.title, "Item A")
        XCTAssertEqual(item.detail, "50 lb")
        XCTAssertTrue(item.hasCheckmark)
    }
    
    func testToggleCheckmark() {
        viewModel.toggleCheckmark(at: 0)
        let item = viewModel.item(at: 0)
        XCTAssertFalse(item.hasCheckmark)
    }
    
    func testAddItem() {
        let newItem = ShoppingListViewModel.Item(title: "Item D", detail: "10 lb", hasCheckmark: false)
        viewModel.addItem(newItem)
        
        XCTAssertEqual(viewModel.numberOfItems, 4)
        
        let item = viewModel.item(at: 0)
        XCTAssertEqual(item.title, "Item D")
        XCTAssertEqual(item.detail, "10 lb")
        XCTAssertFalse(item.hasCheckmark)
    }

    func testReload() {
        viewModel.loadData()
        XCTAssertEqual(viewModel.numberOfItems, 3)
    }
    
}
