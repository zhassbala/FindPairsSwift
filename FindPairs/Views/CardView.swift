import SwiftUI

// Similar to a reusable React/Vue component
// Like a Card.jsx or Card.vue component
struct CardView: View {
    let card: Card  // Like props in React/Vue
    
    // Like the render() method in React or template in Vue
    var body: some View {
        ZStack {  // Like CSS position: relative with children absolute
            let base = RoundedRectangle(cornerRadius: 12)
            Group {  // Like a React.Fragment or Vue template
                base.fill(.white)  // Like CSS background-color: white
                base.strokeBorder(lineWidth: 2)  // Like CSS border
                if card.isFaceUp {  // Like conditional rendering in React/Vue
                    Text(card.content)
                        .font(card.isEmoji ? .system(size: 40) : .title)  // Like CSS font-size
                        .minimumScaleFactor(0.5)  // Like CSS scale
                        .padding(4)  // Like CSS padding
                }
            }
            .opacity(card.isMatched ? 0.5 : 1)  // Like CSS opacity
        }
        .foregroundStyle(card.isMatched ? .gray : .blue)  // Like CSS color
        .rotation3DEffect(  // Like CSS transform with transition
            .degrees(card.isFaceUp ? 0 : 180),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
        // Like CSS transitions
        .animation(.easeInOut(duration: 0.3), value: card.isFaceUp)
        .animation(.easeInOut(duration: 0.3), value: card.isMatched)
    }
} 