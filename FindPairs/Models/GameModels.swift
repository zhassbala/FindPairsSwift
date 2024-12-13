import Foundation
import SwiftData

// Similar to TypeScript enum or JavaScript object with predefined values
// Like having a constants file in React/Angular for app-wide values
enum Category: String, CaseIterable {
    case animals = "Animals"
    case fruits = "Fruits"
    case vehicles = "Vehicles"
    
    // Like a computed property in Vue.js or a selector in Redux
    // Similar to a getter in JavaScript class
    var pairs: [(emoji: String, word: String)] {
        switch self {
        case .animals:
            return [
                ("🐶", "dog"),
                ("🐱", "cat"),
                ("🐼", "panda"),
                ("🐨", "koala"),
                ("🦁", "lion"),
                ("🐯", "tiger"),
                ("🐮", "cow"),
                ("🐷", "pig")
            ]
        case .fruits:
            return [
                ("🍎", "apple"),
                ("🍌", "banana"),
                ("🍇", "grapes"),
                ("🍊", "orange"),
                ("🍓", "strawberry"),
                ("🍐", "pear"),
                ("🍍", "pineapple"),
                ("🥝", "kiwi")
            ]
        case .vehicles:
            return [
                ("🚗", "car"),
                ("🚌", "bus"),
                ("✈️", "plane"),
                ("🚲", "bicycle"),
                ("🏍️", "motorcycle"),
                ("🚂", "train"),
                ("🚁", "helicopter"),
                ("⛵️", "boat")
            ]
        }
    }
}

// Similar to a TypeScript interface or type
// Like a React component's Props type definition
struct Card: Identifiable, Equatable {
    let id = UUID()  // Like React's key prop or Angular's trackBy
    let content: String
    let isEmoji: Bool
    var isFaceUp = false
    var isMatched = false
}

// Similar to a Mongoose/TypeORM model
// Like a Redux state slice or Vuex module state
@Model  // Similar to @Entity decorator in TypeORM
class GameState {
    var selectedCategory: String  // Like a piece of Redux state
    var moves: Int
    var startTime: Date?
    var endTime: Date?
    var bestScore: Int
    
    // Similar to a constructor in JavaScript class
    init(selectedCategory: String = Category.animals.rawValue,
         moves: Int = 0,
         startTime: Date? = nil,
         endTime: Date? = nil,
         bestScore: Int = 0) {
        self.selectedCategory = selectedCategory
        self.moves = moves
        self.startTime = startTime
        self.endTime = endTime
        self.bestScore = bestScore
    }
} 