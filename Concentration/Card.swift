import Foundation

struct Card: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int // уникальный номер каждой карточки
    static var identifierNumber = 0
    static func identifierGenerator() -> Int { // генерируется номер идентификатора
        identifierNumber += 1 // каждый раз будет возвращаться новое число
        return identifierNumber
    }
    init() {
        self.identifier = Card.identifierGenerator() // обращаемся к самому типу Card и вызываем метод его типа
    }
}
