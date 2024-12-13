import SwiftUI

// Similar to a main page component in React/Vue
// Like Game.jsx or GamePage.vue
struct GameView: View {
    @StateObject private var viewModel = GameViewModel()  // Like React's useState or Vue's setup()
    let category: Category  // Like a route parameter in React Router/Vue Router
    
    // Like the render() method in React or template in Vue
    var body: some View {
        VStack {  // Like a div with display: flex, flex-direction: column
            // Game stats (Like a Header component in React/Vue)
            HStack {  // Like a div with display: flex, flex-direction: row
                VStack(alignment: .leading) {
                    Text("Time: \(viewModel.formatTime(viewModel.elapsedTime))")
                        .font(.headline)  // Like CSS font-weight: bold
                    Text("Moves: \(viewModel.moves)")
                        .font(.headline)
                }
                Spacer()  // Like CSS flex: 1
                Button("Restart") {  // Like <button onClick={...}> in React
                    viewModel.startNewGame(category: category)
                }
                .buttonStyle(.bordered)  // Like CSS classes for button styles
            }
            .padding()  // Like CSS padding
            
            // Game grid (Like a Grid component in React/Vue)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 4), spacing: 8) {
                // Like .map() in React/Vue for rendering lists
                ForEach(viewModel.cards) { card in
                    CardView(card: card)  // Like <Card /> component in React/Vue
                        .aspectRatio(2/3, contentMode: .fit)  // Like CSS aspect-ratio
                        .onTapGesture {  // Like onClick in React or @click in Vue
                            viewModel.cardTapped(card)
                        }
                }
            }
            .padding()
            
            Spacer()  // Like CSS margin-top: auto
        }
        .navigationTitle(category.rawValue)  // Like setting document.title in JavaScript
        .onAppear {  // Like useEffect(() => {}, []) in React or onMounted in Vue
            viewModel.startNewGame(category: category)
        }
        // Like a Modal component in React/Vue
        .alert("Congratulations!", isPresented: .constant(viewModel.gameCompleted)) {
            Button("Play Again") {
                viewModel.startNewGame(category: category)
            }
        } message: {
            Text("You completed the game in \(viewModel.moves) moves and \(viewModel.formatTime(viewModel.elapsedTime))!")
        }
    }
} 