# Swift6ConcurrencyNetworkingDemo

A portfolio project demonstrating modern Swift 6 concurrency concepts through a practical networking layer.

## Key Features

- Concurrent data fetching using async let
- Clean networking abstraction using protocols
- Mock and URLSession-based network clients
- Swift 6 data-race safety with Sendable
- MainActor-isolated ViewModel
- Async error handling and task cancellation
- SwiftUI dashboard using the Observation framework
- MVVM architecture with separation of concerns

## Architecture

The project follows MVVM architecture. The dashboard service concurrently fetches users, posts, and products, while the observable view model manages UI state and cancellation. The networking layer handles API requests and response decoding using mock or URLSession-based clients.

## Technologies

- Swift 6
- SwiftUI
- Foundation
- Observation (@Observable)
- URLSession
- Structured Concurrency
- async/await and async let
- Actors and Sendable
- @MainActor and Actor Isolation
- MVVM Architecture
- Protocol-Oriented Programming

## Getting Started

Open the project in Xcode, configure Swift 6 language mode, and run it on an iOS Simulator. The app uses mock data by default and does not require a backend.

To enable real networking, inject `URLSessionNetworkClient` with the base URL of an API that provides compatible `/users`, `/posts`, and `/products` endpoints.

