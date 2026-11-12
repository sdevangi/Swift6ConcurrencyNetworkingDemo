//
//  NetworkClient.swift
//  Swift6ConcurrencyNetworkingDemo
//
//  Created by Devangi Shah on 10/15/26.
//

import Foundation

/// Defines the networking operations required by the application.
/// Sendable allows conforming clients to be used across concurrency boundaries
/// when their stored state and implementation satisfy Sendable requirements.
protocol NetworkClient: Sendable{
  
    /// Asynchronously retrieves the list of users.
    /// - Returns: An array of decoded User models.
    func fetchUsers() async throws -> [User]

    /// Asynchronously retrieves the list of posts.
    /// - Returns: An array of decoded Post models.
    func fetchPosts() async throws -> [Post]
    
    /// Asynchronously retrieves the list of products.
    /// - Returns: An array of decoded Product models.
    func fetchProducts () async throws -> [Product]
    
}
