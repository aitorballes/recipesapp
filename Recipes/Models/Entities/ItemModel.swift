import SwiftData

@Model
final class ItemModel {
    @Attribute(.unique) var id: Int
    var name: String
    var icon: String
    var isErased: Bool
    
    init(id: Int, name: String, isErased: Bool = false) {
        self.id = id
        self.name = name
        self.icon = ItemModel.icon(for: name)
        self.isErased = isErased
    }
}

extension ItemModel {
    static func icon(for name: String) -> String {
        let iconMap: [String: String] = [
            "apple": "🍎",
            "avocado": "🥑",
            "bacon": "🥓",
            "banana": "🍌",
            "beef": "🥩",
            "bread": "🍞",
            "broccoli": "🥦",
            "butter": "🧈",
            "cake": "🍰",
            "carrot": "🥕",
            "cheese": "🧀",
            "cherry": "🍒",
            "chicken": "🍗",
            "chocolate": "🍫",
            "coffee": "☕",
            "cookie": "🍪",
            "corn": "🌽",
            "crab": "🦀",
            "croissant": "🥐",
            "detergent": "🧴",
            "diapers": "🧷",
            "eggplant": "🍆",
            "eggs": "🥚",
            "fish": "🐟",
            "flour": "🌾",
            "fries": "🍟",
            "garlic": "🧄",
            "grapes": "🍇",
            "honey": "🍯",
            "hot dog": "🌭",
            "ice": "🧊",
            "ice cream": "🍨",
            "juice": "🧃",
            "kiwi": "🥝",
            "lettuce": "🥬",
            "light bulb": "💡",
            "lobster": "🦞",
            "meat": "🥩",
            "milk": "🥛",
            "mushroom": "🍄",
            "onion": "🧅",
            "orange": "🍊",
            "paper towels": "🧻",
            "pasta": "🍝",
            "peach": "🍑",
            "pear": "🍐",
            "pepper": "🌶️",
            "pizza": "🍕",
            "popcorn": "🍿",
            "potato": "🥔",
            "pork": "🥓",
            "rice": "🍚",
            "salad": "🥗",
            "sausage": "🌭",
            "shampoo": "🧴",
            "shrimp": "🦐",
            "soap": "🧼",
            "soda": "🥤",
            "soup": "🥣",
            "strawberry": "🍓",
            "sugar": "🍬",
            "tea": "🍵",
            "toilet paper": "🧻",
            "tomato": "🍅",
            "toothbrush": "🪥",
            "toothpaste": "🪥",
            "trash bags": "🗑️",
            "water": "💧",
            "watermelon": "🍉",
            "wine": "🍷"
        ]
        return iconMap[name.lowercased()] ?? "🛒"
    }
}

