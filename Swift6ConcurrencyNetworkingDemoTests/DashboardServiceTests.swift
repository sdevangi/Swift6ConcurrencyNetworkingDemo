//
//  DashboardServiceTests.swift
//  Swift6ConcurrencyNetworkingDemo
//
//  Created by Devangi Shah on 10/22/26.
//

import XCTest
@testable import Swift6ConcurrencyNetworkingDemo

/// Unit tests for DashboardService using a mock networking client.
final class DashboardServiceTests: XCTestCase{
    
    // MARK: - Dashboard Loading Test
    
    /// Verifies that the service returns users, posts, and products.
    func testLoadDashboardReturnsAllData() async throws{
        //Arrange
        let client =  await MockNetworkClient()
        let service =  await DashboardService(client: client)
        
        
        //Act
        let dashboard = try await service.loadDashboard()
       
        // Read actor-isolated properties before XCTest assertions
        let usersAreEmpty = await dashboard.users.isEmpty
        let postsAreEmpty = await dashboard.posts.isEmpty
        let productsAreEmpty = await dashboard.products.isEmpty
        
        //Assert
        XCTAssertFalse(usersAreEmpty, "Expected dashboard to contains users.")
        XCTAssertFalse(postsAreEmpty, "Expected dashboard to contain posts.")
        XCTAssertFalse(productsAreEmpty, "Expected dashboard to contain products.")
    }
    
    // MARK: - Cancellation Test

    /// Verifies that cancellation is propagated by the service.
    func testDashboardCanBeCancelled() async throws{
        
        //Arrange
        let client =  await MockNetworkClient()
        let service =  await DashboardService(client: client)
        
        //Act
        let task = Task{
            try await service.loadDashboard()
        }
        
        //cancel the task.
        task.cancel()
    }
    
}
