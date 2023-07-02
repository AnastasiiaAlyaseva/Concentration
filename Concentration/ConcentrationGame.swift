import Foundation

struct ConcrntrationGame {
    
    struct Points {
        static let matchPoints = 2
        static let penaltyPoints = 1
    }
    
    var cards = [Card]() // массив из карточек (массив из типа Card)
    var touch = 0
    var score = 0
    var seenCards: Set<Int> = []
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    mutating func chooseCard(at index: Int) { // логика игры
        if !cards[index].isMatched { // если нажатая карточка не является совпавшей
            touch += 1
            
            // если мы можем присвоить значение то значит у нас есть одна единств. пер. карточка / нажатая кномпка это не та же ед.пер.карточка
            if let matchingIndex = indexOfOneAndOnlyFaceUpCard, matchingIndex != index {
                if cards[matchingIndex] == cards[index] { // проверяем не совпали ли карточки
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true //меняем состояние, прописываем что катрочки являются совпавшими
                    score += Points.matchPoints
                }
                
                cards[index].isFaceUp = true // переворачиваем карточку
                indexOfOneAndOnlyFaceUpCard = nil // т.к получается 2 перевернутых карточки
                if seenCards.contains(index) {
                    score -= Points.penaltyPoints
                }
                
                seenCards.insert(index)
            } else {
                // переворачиваем все карточки лицом вниз и оставляем перевернутой только ту, которую нажали
                for flipDown in cards.indices {
                    cards[flipDown].isFaceUp = false
                    
                }
                
                cards[index].isFaceUp = true // переворачиваем одну ед.кар. вверх
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    mutating func resetGame() {
        touch = 0
        score = 0
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards { // проходимся по всем числам
            let card = Card() // создание новой карточки путем создания экземпляра структуры
            cards += [ card, card] // заполняет массив парными карточками
            cards = cards.shuffled() // перетасовка карточек
        }
    }
}

extension Collection { // расширение протокола Collection
    
    var oneAndOnly:Element? { // Element такой тип который обобщает  Int,String, Double
        // count - метод у Collection, сообщает кол-во элементов в коллекции, first метод у Collection возвращающий первый элемент коллекции
        return count == 1 ? first : nil // возврашает одну единственную вещь в коллекции или возвращает nil
    }
    
}
