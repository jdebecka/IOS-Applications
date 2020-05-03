import UIKit

var str = "Hello, playground"


enum JokeType: CaseIterable {
case dadJoke
case mumJoke
case random
case chucknorris

static let allValues = [dadJoke, mumJoke, random, chucknorris]

var description: String{
    switch self {
    case .dadJoke:
        return "Dad Joke"
    case .mumJoke:
        return "Mum Joke"
    case .random:
        return "Random"
    case .chucknorris:
        return "Chuck Norris"
    }
}

var requestString: String {
    switch self {
    case .dadJoke:
        return "dadjoke"
    case .mumJoke:
        return "yomama"
    case .random:
        return "random"
    case .chucknorris:
        return "chucknorris"
    }
}
}

let listValue = JokeType.allValues

listValue[1].description
