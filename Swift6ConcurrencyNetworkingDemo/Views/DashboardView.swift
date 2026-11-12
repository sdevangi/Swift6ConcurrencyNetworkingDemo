//
//  DashboardView.swift
//  Swift6ConcurrencyNetworkingDemo
//
//  Created by Devangi Shah on 10/15/26.
//

import SwiftUI


/// Displays the dashboard and its users, posts, and products.
struct DashboardView: View{
    
    /// Stores the observable ViewModel for this view's lifetime.
    @State private var viewModel : DashboardViewModel
    
    /// Initializes the view with its injected ViewModel.
    /// - Parameter viewModel: The ViewModel that supplies dashboard state.
    init(viewModel: DashboardViewModel) {
        // Initializes SwiftUI state with the supplied observable reference.
        self.viewModel = viewModel
    }
    
    /// Describes the dashboard's complete SwiftUI interface.
    var body: some View{
        
        // Provides navigation and a title for the dashboard screen.
        NavigationStack{
            
            // Allows the dashboard content to scroll vertically.
            ScrollView{
                
                // Arranges the dashboard sections with consistent spacing.
                VStack(alignment: .leading, spacing: 24){
                    
                    // Displays the dashboard title and subtitle.
                    header
                    
                    // Shows progress while dashboard data is loading.
                    if viewModel.isLoading{
                        loadingView
                    }
                    
                    // Displays the current error, if one exists.
                    if let error = viewModel.errorMessage{
                        errorMessage(error)
                    }
                    
                    // Renders the users returned by the service.
                    userSection
                    
                    // Renders the posts returned by the service.
                    postSection
                    
                    // Renders the products returned by the service.
                    productSection
                }
                // Adds space around the dashboard content.
                .padding()
            }
            // Sets the navigation bar title.
            .navigationTitle("Dashboard")
            .toolbar{
                
                // Adds a reload action to the navigation ba
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reload"){
                        // Creates a task so the synchronous button action
                        // can call the asynchronous loading method.
                        Task{
                            await viewModel.loadDashboard()
                        }
                    }
                    // Prevents reloading while a load is already in progress.
                    .disabled(viewModel.isLoading)
                }
            }
            // Loads dashboard data when the view's task starts.
            .task {
                await viewModel.loadDashboard()
            }
        }
    }
}
// MARK: - Header
private extension DashboardView{
    
    /// Builds the title and subtitle displayed at the top of the screen.
    var header:some View{
        
        // Stacks the title and subtitle vertically.
        VStack(alignment: .leading, spacing: 8){
            
            // Displays the name of the demo project.
            Text("Swift 6 Networking")
                .font(.title.bold())
            
            // Explains the concurrency concept demonstrated by the app.
            Text("Concurrent reuquest using async/await")
                .foregroundStyle(.secondary)
        }
        
    }
}

// MARK: - Loading
private extension DashboardView{
    
    /// Builds the loading indicator shown during data retrieval.
    var loadingView: some View{
        
        // Places the spinner and status message side by side.
        HStack{
            
            // Displays SwiftUI's standard progress indicator.
            ProgressView()
            
            // Explains why the dashboard is temporarily loading.
            Text("Loading Dashboard....")
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Error
private extension DashboardView{
    
    /// Builds a styled error message.
    /// - Parameter message: The error text supplied by the ViewModel.
    /// - Returns: A view that displays the error prominently.
    func errorMessage (_ message : String) -> some View{
        
        // Renders the error text using a warning color.
        Text(message)
            .foregroundStyle(.red)
            
            // Adds internal spacing around the message.
            .padding()
            
            // Expands the error container to the available width.
            .frame(maxWidth: .infinity)
            
            // Adds a subtle background behind the error.
            .background(Color.red.opacity(0.1))
        
            // Rounds the corners of the error container.
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Users
private extension DashboardView{
    
    /// Builds the section containing all loaded users.
    var userSection : some View{
        
        // Groups the section title and user rows vertically.
        VStack(alignment: .leading, spacing: 12)
        {
            // Labels the users section.
            Text("Users")
                .font(.headline)
            
            // Creates a row for each identifiable user.
            ForEach(viewModel.users){ user in
                
                // Groups the user's name and email vertically.
                VStack(alignment: .leading, spacing: 4)
                {
                    // Displays the user's name.
                    Text(user.name)
                        .font(.body.bold())
                    
                    // Displays the user's email in secondary text.
                    Text(user.email)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
            }
        }
    }
}

// MARK: - Posts
private extension DashboardView{
    
    /// Builds the section containing all loaded posts.
    var postSection : some View{
        
        // Groups the section title and post rows vertically.
        VStack(alignment: .leading, spacing: 12)
        {
            // Labels the posts section.
            Text("Posts")
                .font(.headline)
            
            // Creates a row for each identifiable post.
            ForEach(viewModel.posts){ post in
                
                // Groups the post title and body vertically.
                VStack(alignment: .leading, spacing: 4)
                {
                    // Displays the post's title.
                    Text(post.title)
                        .font(.body.bold())
                    
                    // Displays the post's descriptive content.
                    Text(post.body)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
            }
        }
    }
}

// MARK: - Products
private extension DashboardView{
    
    /// Builds the section containing all loaded products.
    var productSection : some View{
        
        // Groups the section title and product rows vertically.
        VStack(alignment: .leading, spacing: 12)
        {
            // Labels the products section.
            Text("Products")
                .font(.headline)
            
            // Creates a row for each identifiable product.
            ForEach(viewModel.products){ product in
                
                // Places the product name and price on one line.
                HStack{
                    // Displays the product's name.
                    Text(product.name)
                    
                    // Pushes the price to the trailing edge.
                    Spacer()
                    
                    // Displays the product price in US dollar format.
                    Text(product.price,format: .currency(code: "USD"))
    
                }
                
            }
        }
    }
}
