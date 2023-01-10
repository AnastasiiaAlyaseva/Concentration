//
//  ViewController.swift
//  Concentration
//
//  Created by Anastasiia Alyaseva on 12.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = ConcrntrationGame(numberOfPairsOfCards: (buttonCollection.count + 1 ) / 2)

    var emojiCollection: [String] = []
    var emojiDictionary = [Int:String]()
    var emojiThemes: [String: [String]] = [
        "Sport": ["⚽️", "⚾️", "🥊", "🏋🏻","🏂", "🚴‍♀️","🏊‍♂️", "🪂","🛼", "🏹","🏇", "🏌️"],
        "Food": ["🌭", "🥓", "🍕", "🍗", "🥘", "🌯","🍜", "🍱", "🥪","🥙", "🧀", "🍳"],
        "Transport":  ["🚗", "🛴", "🚲","🏍️", "🚃", "⛴️", "✈️", "🚁","🚌", "🏎️", "🚠"],
        "Fruits": ["🍏", "🍋", "🍉", "🍒", "🥝", "🍍","🥥", "🍌", "🍐","🍊", "🍓", "🍑"],
        "Animals": ["🐈", "🐇", "🦌", "🦏","🐊", "🦒","🐂", "🐕","🦥", "🦘","🐫", "🐎"],
        "Countries": ["🇨🇿", "🇨🇮", "🇩🇪", "🇮🇱","🇯🇵", "🇷🇺","🇹🇷", "🇺🇦","🇵🇼", "🇳🇴","🇰🇷", "🇳🇱"],
        "Zodiac": ["♈︎", "♉︎", "♊︎", "♋︎","♍︎", "♌︎","♎︎", "♐︎","♒︎", "♓︎","♏︎", "♑︎"],
        "Animals 2": ["🦊","🐼","🐻","🐰","🐨","🐯","🦁","🦍", "🐘","🦈","🦒","🐈"],
    ]
    
    var indexTheme = 0 {
        didSet {
            let theme = keys[indexTheme]
            print (indexTheme, theme)
            titleLable.text = theme
            emojiCollection = emojiThemes[theme] ?? []
            emojiDictionary = [Int: String]()
        }
    }
    var keys: [String] {
        return Array(emojiThemes.keys)
    }
    
    override func loadView() {
        super.loadView()
        setupGame()
    }
    
    func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            emojiDictionary[card.identifier] = emojiCollection.remove(at: emojiCollection.count.arc4random)
        }
//        if emojiDictionary[card.identifier] != nil {
//            return emojiDictionary[card.identifier]!
//       } else {
//            return "?"
//        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
    func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.008634069934, green: 0.4577476978, blue: 0.8880464435, alpha: 1)
            }
        }
        touchLabel.text = "Touches: \(game.touch)"
        scoreLabel.text = "Score: \(game.score)"
        
    }
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBAction func newGame(_ sender: UIButton) {
        game.resetGame()
        setupGame()
        updateViewFromModel()
    }
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet weak var touchLabel: UILabel!
    @IBAction func buttonAction(_ sender: UIButton) {
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
    }
        
    }
    
    func setupGame() {
        indexTheme = keys.count.arc4random
    }
}
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
