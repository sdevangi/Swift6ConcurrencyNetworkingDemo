//
//  DashboardViewModel.swift
//  Swift6ConcurrencyNetworkingDemo
//
//  Created by Devangi Shah on 10/15/26.
//

import Foundation
import Observation

@MainActor
@Observable

/// Owns dashboard state and coordinates UI-facing asynchronous operations.
/// MainActor ensures its mutable UI state is accessed on the main actor.
final class DashboardViewModel{
    
    /// Users displayed by the dashboard.
    private(set) var users: [User] = []
    
    /// Posts displayed by the dashboard.
    private(set) var posts: [Post] = []
    
    /// Products displayed by the dashboard.
    private(set) var products: [Product] = []
    
    /// Indicates whether a dashboard request is currently in progress.
    private(set) var isLoading = false
    
    /// Contains a user-readable error message when loading fails.
    private(set) var errorMessage: String?
    
    /// Service responsible for loading dashboard data.
    private let service : DashboardService
    
    /// Injects the service used to retrieve dashboard data.
    /// - Parameter service: The dashboard networking service.
    init(service: DashboardService) {
        // Retains the service without coupling the ViewModel to a concrete client.
        self.service = service
    }
    
    /// Loads dashboard data and updates the observable UI state.
    /// Errors are handled here so the view can display an appropriate message.
    func loadDashboard() async{
        
        // Prevents duplicate loads while an existing load is in progress.
        guard !isLoading else{
            return
        }
        
        // Shows the loading state before starting the asynchronous operation.
        isLoading = true
        
        // Clears any previous error before retrying.
        errorMessage = nil
        
        // Resets the loading state on every exit path, including thrown errors.
        defer {
            isLoading = false
        }
        
        do{
            // Suspends while the service retrieves all dashboard datasets.
            let dashboard = try await service.loadDashboard()
            
            // Updates the users displayed by the UI.
            users = dashboard.users
            
            // Updates the posts displayed by the UI.
            posts = dashboard.posts
            
            // Updates the products displayed by the UI.
            products = dashboard.products
            
        }catch is CancellationError{
            // Handles cooperative cancellation without displaying it as an error.
            print("Request Cancelled.")
        } catch{
            // Publishes a readable error message for the view to display.
            errorMessage = error.localizedDescription
        }
    }
    
    /// Clears dashboard content and any displayed error.
    /// Useful when implementing a reset or logout workflow.
    func reset(){
        
        // Removes all users from the dashboard state.
        users = []
        
        // Removes all posts from the dashboard state.
        posts = []
        
        // Removes all products from the dashboard state.
        products = []
        
        // Clears any existing error message.
        errorMessage = nil
    }
    
}
