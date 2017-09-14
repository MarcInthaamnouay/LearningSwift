//: Playground - noun: a place where people can play

import Cocoa

// Enum

struct Ingredient {
    var name: String
    var calories: Double
    var quantity: Double
}

struct Packaging {
    var size: Int
    var name: String
    var tag : String
}

struct BobbaMisc {
    var vendor: String
    var price : Double
    var currency: String
}

// Enum type of different supported currencies
// Each currencies take a double (the price) and a String (the currency of the price atm)
// Price is based are convert into dollar first then back to the target currency
enum Currencies: Double {
    case euro   = 0.841425
    case dollar = 1
    case ntd    = 0.033301
    case yen    = 0.009127
    case yuan   = 0.153041
}


// Method link to the bubble tea is in the protocol

protocol BobbaDecorator {
    func getMostCaloricIngredient() -> Ingredient?
    func getIngredientByName(name: String) -> Ingredient?
    func getPrice(currency: String) -> Double
}

// Create a bobba !
struct Bobba : BobbaDecorator {

    var ingredients: [Ingredient]
    var package: Packaging
    var info: BobbaMisc
    
    // Implement the method link to the BobbaDecorator
    func getIngredientByName(name: String) -> Ingredient? {
        var n: Ingredient?
        
        ingredients.map({
            ingredient in
            
            if (name == ingredient.name) {
                n = ingredient
            }
        })
        
        return n
    }
    
    // Get the most caloric ingredient of the bobba
    func getMostCaloricIngredient() -> Ingredient? {
        var ing: Ingredient? = nil
        var calorie: Double = 0
        
        ingredients.map({
            ingredient in
            
            if (calorie < ingredient.calories) {
                ing = ingredient
                calorie = ingredient.calories
            }
        })
        
        return ing
    }
    
    // Get Current Currency Enum
    // Get the enum based value of the price set for the bubble tea
    private func getCurrentCurrencyEnum() -> Currencies {
        switch info.currency.lowercased() {
        case "dollar":
            return Currencies.dollar
        case "euro":
            return Currencies.euro
        case "ntd":
            return Currencies.ntd
        case "yen":
            return Currencies.yen
        case "yuan":
            return Currencies.yuan
        default:
            return Currencies.dollar
        }
    }
    
    // Convert the price to different currency input by the user (enum)
    func getPrice(currency: String) -> Double {
        
        // Constant getting the currency
        let bobbaCurrency : Currencies = getCurrentCurrencyEnum()
        // Variable to store the price
        var newPrice: Double
        
        // Convert the price
        func convertPrice(target: Currencies, from: Currencies) -> Double {
            // First get the dollar value
            // from.rawValue is the currency comparing to the dollar value
            return (from.rawValue * info.price) * target.rawValue
        }
        
        // @TODO should support some currency to convert in and out
        // @TODO should make an Enum
        switch currency.lowercased() {
            case "euro":
                newPrice = convertPrice(target: Currencies.euro, from: bobbaCurrency)
            case "dollar":
                newPrice = convertPrice(target: Currencies.dollar, from: bobbaCurrency)
            case "ntd":
                newPrice = convertPrice(target: Currencies.ntd, from: bobbaCurrency)
            case "yen":
                newPrice = convertPrice(target: Currencies.yen, from: bobbaCurrency)
            case "yuan":
                newPrice = convertPrice(target: Currencies.yuan, from: bobbaCurrency)
            default:
                return info.price
        }
        

        return newPrice
    }
}


// Should i create a class for creating the bobba ?
// is a decorator
class bobbaMaker {
    
    var ingredients: [Ingredient]?
    var package: Packaging?
    var misc: BobbaMisc?
    
    init(pkg: Packaging, misc: BobbaMisc) {
        self.ingredients = []
        self.package = pkg
        self.misc = misc
    }

    // AddIngredients, add ingredients to the class
    func addIngredients(ing: Ingredient) -> bobbaMaker {
        self.ingredients?.append(ing)
        
        return self
    }
    
    
    // buildBobba build the bubble tea
    func buildBobba() -> Bobba? {
        
        if (self.ingredients == nil ||
            self.misc == nil ||
            self.package == nil) {
            
            // @TODO maybe throw an error ?
            return nil
        }
        
        return Bobba(
            ingredients: self.ingredients!,
            package: self.package!,
            info: self.misc!
        )
    }
}

// Just for testing
// Ingredients
let milk = Ingredient(name: "milk", calories: 100.0, quantity: 10)
let tapiocaBubble = Ingredient(name: "tapioca", calories: 300.0, quantity: 40)

// Packaging
let pack = Packaging(size: 10, name: "bubble tea with green tea", tag: "tea")

// Calories
let price = BobbaMisc(vendor: "stuff", price: 20.0, currency: "ntd")


let greenMilkTeaBobba = bobbaMaker(pkg: pack, misc: price)
let bobba = greenMilkTeaBobba.addIngredients(ing: milk)
                             .addIngredients(ing: tapiocaBubble)
                             .buildBobba()

// Trying some bobba protocol method
print(bobba?.getPrice(currency: "euro"))
print(bobba?.getIngredientByName(name: "milk"))
print(bobba?.getMostCaloricIngredient())







