import UIKit

class ViewController: UIViewController {
    
    lazy var game = ConcrntrationGame(numberOfPairsOfCards: (buttonCollection.count + 1 ) / 2) //запуск игры
    var viewColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    var cardBackColor = #colorLiteral(red: 0.008634069934, green: 0.4577476978, blue: 0.8880464435, alpha: 1)
    var emojiCollection: [String] = []
    var emojiDictionary = [Card:String]() // ключами в словаре являются сами карты
    var emojiThemes: [gameTheme] = [
        gameTheme(name: "Sport", emojis: ["⚽️", "⚾️", "🥊", "🏋🏻","🏂", "🚴‍♀️","🏊‍♂️", "🪂","🛼", "🏹","🏇", "🏌️"], backroundColor: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), cardColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)),
        gameTheme(name: "Food", emojis: ["🌭", "🥓", "🍕", "🍗", "🥘", "🌯","🍜", "🍱", "🥪","🥙", "🧀", "🍳"], backroundColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), cardColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)),
        gameTheme(name: "Transport", emojis: ["🚗", "🛴", "🚲","🏍️", "🚃", "⛴️", "✈️", "🚁","🚌", "🏎️", "🚠"], backroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), cardColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)),
        gameTheme(name: "Fruits", emojis: ["🍏", "🍋", "🍉", "🍒", "🥝", "🍍","🥥", "🍌", "🍐","🍊", "🍓", "🍑"], backroundColor: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), cardColor: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)),
        gameTheme(name: "Animals", emojis: ["🐈", "🐇", "🦌", "🦏","🐊", "🦒","🐂", "🐕","🦥", "🦘","🐫", "🐎"], backroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), cardColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)),
        gameTheme(name: "Countries", emojis: ["🇨🇿", "🇨🇮", "🇩🇪", "🇮🇱","🇯🇵", "🇷🇺","🇹🇷", "🇺🇦","🇵🇼", "🇳🇴","🇰🇷", "🇳🇱"], backroundColor: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), cardColor: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)),
        gameTheme(name: "Zodiac", emojis: ["♈︎", "♉︎", "♊︎", "♋︎","♍︎", "♌︎","♎︎", "♐︎","♒︎", "♓︎","♏︎", "♑︎"], backroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), cardColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
    ]
    
    var indexTheme = 0 { // темы emoji
        didSet {
            let theme = emojiThemes[indexTheme] // случайный индекс темы
            print (indexTheme, theme.name)
            emojiDictionary = [Card:String]()
            titleLable.text = theme.name // выводим название темы
            emojiCollection = theme.emojis // выбираем словарь с emoji по случайному индексу
            viewColor = theme.backroundColor // выводим цвет фона игры
            cardBackColor = theme.cardColor // выводим цвет карты
            updateViewGame()
        }
    }
    //var keys: [String] {
    // return Array(emojiThemes.keys)
    //}
    
    override func loadView() {
        super.loadView()
        setupGame()
    }
    
    struct gameTheme { // структура тем игры
        var name: String
        var emojis: [String]
        var backroundColor: UIColor // цвет фона игры
        var cardColor: UIColor // цвет "рубашки" карточки
    }
    
    func emojiIdentifier(for card: Card) -> String {// дает каждому индексу карточек emoji с тем же идентификатором что и карточка
        if emojiDictionary[card] == nil {// проверяем есть ли emoji в этом словаре
            emojiDictionary[card] = emojiCollection.remove(at: emojiCollection.count.arc4random)
        } //загружает emoji в словарь из массива emojiCollection по случайному индексу
        //        if emojiDictionary[card.identifier] != nil {
        //            return emojiDictionary[card.identifier]!
        //       } else {
        //            return "?"
        //        }
        return emojiDictionary[card] ?? "?" // возвращент значение по ключу
    }
    
    func updateViewFromModel() { // обновление вида модели
        for index in buttonCollection.indices { // проходимся по индексам в массиве кнопок, прописываем что индексы кнопок должны соотвествовать индексу карточек
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp { // если карточка перевернута вверх
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else { //если не перевернута
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0) : cardBackColor
            }
        }
        touchLabel.text = "Touches: \(game.touch)"
        scoreLabel.text = "Score: \(game.score)"
    }
    
    func updateViewGame() {
        view.backgroundColor = viewColor
    }
    
    override func viewDidLoad() { // заполнение пользовательского интерфейса данными до того, как пользователь их увидит
        super.viewDidLoad()
        updateViewFromModel()
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
    @IBAction func buttonAction(_ sender: UIButton) { //выполняется при нажатии какой  кнопки
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
    }
    
    func setupGame() { // получаем случайный индекс темя напрямую из массива
        indexTheme = emojiThemes.count.arc4random
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
