import SwiftUI
import SwiftData

// Similar to App.jsx or App.vue - the main component
// Like the root component in React/Vue
struct ContentView: View {
    @Environment(\.modelContext) private var modelContext  // Like React Context or Vue's provide/inject
    @Query private var gameStates: [GameState]  // Like using a database hook (e.g., React Query, Apollo)
    
    // Like the render() method in React or template in Vue
    var body: some View {
        NavigationStack {  // Like React Router's BrowserRouter or Vue Router
            List {  // Like a <ul> with custom styling
                Section("Categories") {  // Like a section component with heading
                    // Like .map() in React/Vue for rendering lists
                    ForEach(Category.allCases, id: \.self) { category in
                        // Like React Router's Link or Vue Router's router-link
                        NavigationLink(destination: GameView(category: category)) {
                            HStack {  // Like flexbox row layout
                                Text(category.rawValue)
                                    .font(.headline)  // Like CSS font-weight
                                Spacer()  // Like CSS flex: 1
                                // Like conditional rendering with optional chaining in JavaScript
                                if let bestScore = gameStates.first(where: { $0.selectedCategory == category.rawValue })?.bestScore {
                                    Text("Best: \(bestScore)")
                                        .foregroundStyle(.secondary)  // Like CSS color: var(--secondary-color)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Find Pairs")  // Like setting page title in React/Vue
        }
    }
} 