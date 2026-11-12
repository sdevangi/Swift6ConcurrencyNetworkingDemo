//
//  URLSessionNetworkClient.swift
//  Swift6ConcurrencyNetworkingDemo
//
//  Created by Devangi Shah on 10/15/26.
//

import Foundation


/// Performs real HTTP requests using URLSession.
struct URLSessionNetworkClient : NetworkClient{
   
    /// Stores the base URL shared by all API endpoints.
    private let baseURL : URL
    
    /// Provides the URLSession used to execute network requests
    private let session : URLSession
    
    /// Creates a networking client with an injectable base URL and session.
    /// - Parameters:
    ///   - baseURL: The root URL of the backend API.
    ///   - session: The URLSession used for HTTP requests.
    init(baseURL: URL, session: URLSession = .shared) {
        // Saves the backend URL for subsequent requests.
        self.baseURL = baseURL
        
        // Uses the injected session or URLSession.shared by default.
        self.session = session
    }
    
    /// Fetches and decodes the users endpoint.
    /// - Returns: An array of User models.
    /// - Throws: A networking or decoding error if the request fails.
    func fetchUsers() async throws -> [User] {
        let url = baseURL.appendingPathComponent("/users")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data,response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else{
            throw NetworkError.invalidResponse
        }
        guard 200..<300 ~= httpResponse.statusCode else{
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode([User].self,from: data)
        }catch{
            throw NetworkError.decodingError
        }
    }
    
    /// Fetches and decodes the posts endpoint.
    /// - Returns: An array of Post models.
    /// - Throws: A networking or decoding error if the request fails.
    func fetchPosts() async throws -> [Post] {
        let url = baseURL.appendingPathComponent("/posts")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data,response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else{
            throw NetworkError.invalidResponse
        }
        guard 200..<300 ~= httpResponse.statusCode else{
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode([Post].self,from: data)
        }catch{
            throw NetworkError.decodingError
        }
    }
    
    /// Fetches and decodes the products endpoint.
    /// - Returns: An array of Product models.
    /// - Throws: A networking or decoding error if the request fails.
    func fetchProducts() async throws -> [Product] {
        let url = baseURL.appendingPathComponent("/products")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data,response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else{
            throw NetworkError.invalidResponse
        }
        guard 200..<300 ~= httpResponse.statusCode else{
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode([Product].self,from: data)
        }catch{
            throw NetworkError.decodingError
        }
    }
}
