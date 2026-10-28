//
//  Product.swift
//  Swift6ConcurrencyNetworkingDemo
//
//  Created by Devangi Shah on 10/15/26.
//

import Foundation

/// Represents a product returned by the networking layer.
struct Product: Codable,Identifiable,Sendable{
    
    /// Uniquely identifies the product.
    let id : Int
    
    /// Stores the product's display name.
    let name : String
    
    /// Stores the product price in the configured currency.
    let price : Double
}
