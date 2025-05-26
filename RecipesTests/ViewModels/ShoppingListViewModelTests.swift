import SwiftData
import Testing
@testable import Recipes

@Suite("ShoppingListViewModelTests")
struct ShoppingListViewModelTests {
    let modelContext = try! makeMockModelContext()
    
    @Test("[addItem] Adding an item should set the state to loaded and clear the newItemName")
    func testAddItemSuccess() {
        let mockRepo = MockItemsPersistenceRepository(modelContext: modelContext)
        let viewModel = ShoppingListViewModel(modelContext: modelContext, repository: mockRepo)
        viewModel.newItemName = "Test Item"
        
        viewModel.addItem()
        
        #expect(mockRepo.addCalled)
        #expect(viewModel.state == .loaded)
        #expect(viewModel.newItemName.isEmpty)
    }
    
    @Test("[addItem] Does not add an item when newItemName is empty")
    func testAddItemEmptyName() {
        let mockRepo = MockItemsPersistenceRepository(modelContext: modelContext)
        let viewModel = ShoppingListViewModel(modelContext: modelContext, repository: mockRepo)
        
        viewModel.addItem()
        
        #expect(!mockRepo.addCalled)
        #expect(viewModel.newItemName.isEmpty)
    }
    
    @Test("[addItem] Fails to add an item and sets the state to error")
    func testAddItemFailure() {
        let mockRepo = MockItemsPersistenceRepository(modelContext: modelContext)
        mockRepo.shouldThrowOnAdd = true
        let viewModel = ShoppingListViewModel(modelContext: modelContext, repository: mockRepo)
        
        viewModel.newItemName = "Test Item"
        
        viewModel.addItem()
        
        #expect(mockRepo.addCalled)
        #expect(viewModel.state == .error(PersistenceError.insertFailed))
    }
    
    @Test("[deleteItem] Deletes the item if it is already marked as erased")
    func testDeleteItemWhenIsErased() {
        let mockRepo = MockItemsPersistenceRepository(modelContext: modelContext)
        let viewModel = ShoppingListViewModel(modelContext: modelContext, repository: mockRepo)
        let item = ItemModel.testData
        item.isErased = true
        
        viewModel.deleteItem(item)
        
        #expect(mockRepo.deleteCalled)
        #expect(!mockRepo.markAsDeletedCalled)
        #expect(viewModel.state == .loaded)
    }

    @Test("[deleteItem] Marks the item as erased if it is not already erased")
    func testDeleteItemWhenIsNotErased() {
        let mockRepo = MockItemsPersistenceRepository(modelContext: modelContext)
        let viewModel = ShoppingListViewModel(modelContext: modelContext, repository: mockRepo)
        let item = ItemModel.testData

        viewModel.deleteItem(item)
        
        #expect(!mockRepo.deleteCalled)
        #expect(mockRepo.markAsDeletedCalled)
        #expect(viewModel.state == .loaded)
    }

    @Test("[deleteItem] Fails to delete and sets the state to error")
    func testDeleteItemFailure() {
        let mockRepo = MockItemsPersistenceRepository(modelContext: modelContext)
        mockRepo.shouldThrowOnDelete = true
        let viewModel = ShoppingListViewModel(modelContext: modelContext, repository: mockRepo)
        let item = ItemModel.testData
        item.isErased = true

        viewModel.deleteItem(item)
        
        #expect(mockRepo.deleteCalled)
        #expect(viewModel.state == .error(PersistenceError.deleteFailed))
    }
    
    @Test("[deleteItem] Fails to mark as delete and sets the state to error")
    func testMarkAsDeleteItemFailure() {
        let mockRepo = MockItemsPersistenceRepository(modelContext: modelContext)
        mockRepo.shouldThrowOnMarkAsDeleted = true
        let viewModel = ShoppingListViewModel(modelContext: modelContext, repository: mockRepo)
        let item = ItemModel.testData

        viewModel.deleteItem(item)
        
        #expect(mockRepo.markAsDeletedCalled)
        #expect(viewModel.state == .error(PersistenceError.updateFailed))
    }

    @Test("[restoreItem] Restores an item successfully")
    func testRestoreItemSuccess() {
        let mockRepo = MockItemsPersistenceRepository(modelContext: modelContext)
        let viewModel = ShoppingListViewModel(modelContext: modelContext, repository: mockRepo)
        let item = ItemModel.testData

        viewModel.restoreItem(item)
        
        #expect(mockRepo.restoreCalled)
        #expect(viewModel.state == .loaded)
    }

    @Test("[restoreItem] Fails to restore and sets the state to error")
    func testRestoreItemFailure() {
        let mockRepo = MockItemsPersistenceRepository(modelContext: modelContext)
        mockRepo.shouldThrowOnRestore = true
        let viewModel = ShoppingListViewModel(modelContext: modelContext, repository: mockRepo)
        let item = ItemModel.testData
        item.isErased = true

        viewModel.restoreItem(item)
        
        #expect(mockRepo.restoreCalled)
        #expect(viewModel.state == .error(PersistenceError.updateFailed))
    }

        
}

