//
//  Post.swift
//  Swift6ConcurrencyNetworkingDemo
//
//  Created by Devangi Shah on 10/15/26.
//

import Foundation

/// Represents a post retrieved from the networking service.
struct Post : Codable,Identifiable,Sendable{
    
    /// Uniquely identifies the post.
    let id : Int
    
    /// Contains the post's title.
    let title : String
    
    /// Contains the post's descriptive content.
    let body : String
}
