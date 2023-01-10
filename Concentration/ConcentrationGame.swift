//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Anastasiia Alyaseva on 20.10.2022.
//

import Foundation

class ConcrntrationGame {
    var cards = [Card]()
    var touch = 0
    var score = 0
    var seenCards: Set<Int> = []
    
    struct Points {
        static let matchPoints = 2
        static let penaltyPoints = 1
    }
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            touch += 1
            if let matchingIndex = indexOfOneAndOnlyFaceUpCard, matchingIndex != index {
                if cards[matchingIndex].identifier == cards[index].identifier {
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                    score += Points.matchPoints
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                if seenCards.contains(index) {
                    score -= Points.penaltyPoints
                }
                seenCards.insert(index)
            } else {
                for flipDown in cards.indices {
                    cards[flipDown].isFaceUp = false

                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
    func resetGame() {
        touch = 0
        score = 0
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [ card, card]
            cards = cards.shuffled()
        }
    }
}

