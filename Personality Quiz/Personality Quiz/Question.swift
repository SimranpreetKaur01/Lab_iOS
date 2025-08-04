struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}
enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: AnimalType
}
enum AnimalType: Character {
    case lion = "🦁", cat = "🐈", panda = "🐼", bull = "🦬"
    
    var definition: String {
        switch self {
        case .lion:
            return "You are incredibly outgoing. You surround yourself with people you love and enjoy activities with friends."
        case .cat:
            return "Mischievous, yet ,ild-tempered, you enjoy doing things on your own terms."
        case .panda:
            return "You love to eat and sleep. You are calm and quiet"
        case .bull:
            return "Strong and aggressive, you are always ready to defend yourself."
        }
    }
}
