import Foundation
import SwiftUI

// Similar to a React/Vue component's logic layer
// Comparable to a Redux slice or Vuex store module with actions and state
@MainActor  // Like ensuring code runs on the main thread (similar to UI thread in web)
class GameViewModel: ObservableObject {  // Like React's useState or Vue's reactive data
    @Published var cards: [Card] = []  // Similar to React's useState or Vue's ref
    @Published var moves = 0
    @Published var startTime: Date?
    @Published var elapsedTime: TimeInterval = 0
    @Published var gameCompleted = false
    
    // Like private methods in a React component
    private var timer: Timer?
    private var selectedCards: [Card] = []
    
    // Similar to a Redux action creator or Vuex action
    func startNewGame(category: Category) {
        // Reset game state (like dispatching a RESET_GAME action in Redux)
        moves = 0
        gameCompleted = false
        elapsedTime = 0
        selectedCards = []
        startTime = Date()
        
        // Create and shuffle cards (like a Redux reducer creating new state)
        var newCards: [Card] = []
        let pairs = category.pairs.shuffled().prefix(8) // Take 8 pairs for 4x4 grid
        
        for pair in pairs {
            newCards.append(Card(content: pair.emoji, isEmoji: true))
            newCards.append(Card(content: pair.word, isEmoji: false))
        }
        
        cards = newCards.shuffled()
        startTimer()
    }
    
    // Like setInterval in JavaScript
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self, let startTime = self.startTime else { return }
            self.elapsedTime = Date().timeIntervalSince(startTime)
        }
    }
    
    // Similar to an event handler in React/Vue
    // Like a Redux thunk or Vuex action handling user interaction
    func cardTapped(_ card: Card) {
        guard !gameCompleted else { return }
        
        // Find the index of the tapped card (like finding an item in array in JavaScript)
        guard let index = cards.firstIndex(where: { $0.id == card.id }),
              !cards[index].isMatched,
              !cards[index].isFaceUp,
              selectedCards.count < 2 else { return }
        
        // Update card state (like setState in React)
        cards[index].isFaceUp = true
        selectedCards.append(cards[index])
        
        // Check for match if we have two cards
        if selectedCards.count == 2 {
            moves += 1
            
            let firstCard = selectedCards[0]
            let secondCard = selectedCards[1]
            
            let isMatch = checkForMatch(firstCard, secondCard)
            
            // Like setTimeout in JavaScript for animation timing
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let self = self else { return }
                
                // Update matched status (like updating state in Redux)
                if isMatch {
                    self.cards.indices.forEach { index in
                        if self.cards[index].id == firstCard.id || self.cards[index].id == secondCard.id {
                            self.cards[index].isMatched = true
                        }
                    }
                } else {
                    // Flip cards back
                    self.cards.indices.forEach { index in
                        if self.cards[index].id == firstCard.id || self.cards[index].id == secondCard.id {
                            self.cards[index].isFaceUp = false
                        }
                    }
                }
                
                self.selectedCards = []
                self.checkGameCompletion()
            }
        }
    }
    
    // Like a utility function in JavaScript/TypeScript
    private func checkForMatch(_ card1: Card, _ card2: Card) -> Bool {
        guard card1.isEmoji != card2.isEmoji else { return false }
        
        let emojiCard = card1.isEmoji ? card1 : card2
        let wordCard = card1.isEmoji ? card2 : card1
        
        for category in Category.allCases {
            if let pair = category.pairs.first(where: { $0.emoji == emojiCard.content }) {
                return pair.word == wordCard.content
            }
        }
        
        return false
    }
    
    // Like checking win condition in a game component
    private func checkGameCompletion() {
        if cards.allSatisfy({ $0.isMatched }) {
            gameCompleted = true
            timer?.invalidate()
        }
    }
    
    // Like a utility function for formatting in JavaScript
    func formatTime(_ timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
} 