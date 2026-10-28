//
//  DashboardData.swift
//  Swift6ConcurrencyNetworkingDemo
//
//  Created by Devangi Shah on 10/15/26.
//

import Foundation

/// Groups all datasets required to render the dashboard.
struct DashboardData: Sendable{
    
    /// Contains the users returned by the user request.
    let users :[User]
    
    /// Contains the posts returned by the post request.
    let posts :[Post]
    
    /// Contains the products returned by the product request.
    let products :[Product]
}
