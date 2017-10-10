//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport


/**
 Define the constant to use on the playground
 
 - Important:
 All the properties must be static
 */
struct Const {
    static let country = "Taiwan"
    static var manufacturerList: [String: [String]] = [
        "taipei"   : ["佳德", "新東陽", "郭元益", "台北犁記", "鼎泰豐"],
        "taichung" : ["日出", "紅櫻花", "微熱山丘"],
        "kaoshiung": ["舊振南", "呷百二"],
        "keelung"  : ["李鵠"]
    ]
    
    // Ranking of some manufacturer
    static var manufacturerRanking: [String: Int] = [
        "新東陽": 7,
        "佳德": 10,
        "台北犁記": 8
    ]
}

/**
 Defining the method link to the Const struct
 */
extension Const {
    
    /**
     Add a manufacturer in the list of manufacturer
     
     - paramters:
        city: the name of the city
        name: the name of the company
     
     - returns:
     
     */
    static func addManufacturer(city: String, name: String) {
        // Check if the city is in the list of the manufacturer
        let presence = Const.manufacturerList.filter{$0.key == city}
        
        if (presence.count == 0) {
            Const.manufacturerList[city.lowercased()] = [name]
        } else {
            Const.manufacturerList[city.lowercased()]?.append(name)
        }
    }
}

/**
 Pineapple Error
    only one error ha..
 */
enum PineappleError: Error {
    case unknownManufacturer
}

/**
 Define the main type of pinneaple around the world
 
 - Important:
 Use the getPinneapleByType method in order to retrieve the correct Struct of pinnaple
 */
enum PineappleType {
    case cayenne
    case queen
    case redSpanish
    case abacaxi
    
    /**
     Get Pinneaple By Type return the pinneaple based on the enum you choose
     
     - returns:
     A pinneaple struct 
     
     */
    func getPinneapleByType() -> Pineapple {
        switch self {
        case .cayenne:
            return Pineapple(name: "Cayenne", origin: "Venezuela", cultivationCountry: nil, jamColor: UIColor.PinneapleJamColor.sunnyJam)
        case .queen:
            return Pineapple(name: "Queen", origin: "Malaysia", cultivationCountry: nil, jamColor: UIColor.PinneapleJamColor.juicyJam)
        case .redSpanish:
            return Pineapple(name: "Red Spannish", origin: "Mexico", cultivationCountry: nil, jamColor: UIColor.PinneapleJamColor.honeyJam)
        case .abacaxi:
            return Pineapple(name: "Abacaxi", origin: "Brazil", cultivationCountry: nil, jamColor: UIColor.PinneapleJamColor.redJam)
        }
    }
}


enum ManufacturerList: String {
    case taipei
    case taichung
    case keelung
    case kaohsiung
    
    /**
     Return the ranking of a pinneaple cake manufacturer bsased on the name of the company
     
     - paramters:
        - name: The name of the company
     
     - returns:
        - An optional integer (nil if not present)
     */
    private func getRanking(name: String) -> Int? {
        let rank = Const.manufacturerRanking.filter{$0.key == name}
        if (rank.count == 0) {
            return nil
        }
        
        return rank[0].value
    }
    
    /**
     Return a manufacturer information based on the name and the city
     
     - parameters:
        - name: The name of the company
     
     - returns:
        - tuple composed of the (name, city, ranking)
     
     In the case of an unknown manufacturer is pass this method will throw
     
     */
    func getManufacturerByName(name: String) throws -> Manufacturer {
        let collection = Const.manufacturerList[self.rawValue]
        let manName = collection?.filter{$0 == name}
        
        if (manName?.count == 0) {
           throw PineappleError.unknownManufacturer
        }
        
        
        return Manufacturer(
            name: manName![0],
            city: self.rawValue,
            ranking: self.getRanking(name: manName![0])
        )
    }
    
    /**
     Return all the manufacturer in a city
     
     - returns
        - Array of String with the name of the manufacturer
     */
    func getAllManufacturerByCity() -> [String] {
        if let cityManufacturer = Const.manufacturerList[self.rawValue] {
            return cityManufacturer
        }
        
        return []
    }
}

/**
 Basic Ingredient
 
 Define the basic ingredient for a pineapple cake
 */
enum BasicIngredient {
    case butter
    case eggYolk
    case sugar
    case flour
    case honey
    case cornSyrup
    
    /**
     Return a basic Ingredient based on this enum
     
     - returns:
        Ingredient value
     */
    func getBasicIngredient() -> Ingredient {
        switch self {
        case .butter:
            return Ingredient(name: "Butter", calories: 1290.0)
        case .eggYolk:
            return Ingredient(name: "Egg Yolk", calories: 110.0)
        case .sugar:
            return Ingredient(name: "Sugar", calories: 232.0)
        case .flour:
            return Ingredient(name: "Flour", calories: 915.0)
        case .honey:
            return Ingredient(name: "Honey", calories: 257.75)
        case .cornSyrup:
            return Ingredient(name: "Corn Syrup", calories: 482.5)
        }
    }
}

/**
 Pineapple
 */
struct Pineapple {
    var name  : String
    var origin: String?
    var cultivationCountry: String?
    var jamColor: UIColor
    
    /**
     Set Cultivation Country
     
     - parameters: 
        - country: a name of a country
     */
    mutating func setCultivationCountry(country: String) {
        self.cultivationCountry = country
    }
}

/**
 Manufacturer
 */
struct Manufacturer {
    var name   : String
    var city   : String
    var ranking: Int?
    
    mutating func setRanking(rank: Int) {
        self.ranking = rank
    }
    
    /**
     Push Ranking push a new raking in the list
     */
    private func pushRanking() {
        let presence = Const.manufacturerRanking.filter{$0.key == self.name}
        
        if (presence.count == 0) {
            return;
        }
        
        if let unwrapRank = self.ranking {
            Const.manufacturerRanking[self.name] = unwrapRank
        }
    }
}

/**
 Ingredient
 */
struct Ingredient {
    var name    : String
    var calories: Double
}

/**
 Cake
 */
struct Cake {
    var pinneappleType: Pineapple
    var manufacturer  : Manufacturer
    var ingredientList: [Ingredient]?
    var pastryColor   : UIColor?
    
    /**
     Init: We override the init as we want to have already some properties in the ingredientList
     
     - parameters: 
        - type: Pinneaple, a type of pineapple
        - seller: A manufacturer
     */
    init(type: Pineapple, seller: Manufacturer, color: UIColor) {
        self.pinneappleType = type
        self.manufacturer = seller
        self.ingredientList = [
            BasicIngredient.butter.getBasicIngredient(),
            BasicIngredient.eggYolk.getBasicIngredient(),
            BasicIngredient.flour.getBasicIngredient()
        ]
        self.pastryColor = color
    }
    
    /**
     Return the most caloric ingredient
     
     - returns:
        - maxCaloricIng: return a the most caloric ingredient of the List
     */
    func getMostCaloricIngredient() -> Ingredient? {
        let maxCaloricIng = self.ingredientList?.max{a, b in a.calories < b.calories}
        
        return maxCaloricIng
    }
    
    /**
     Return the total calories
     
     - returns:
        - totalCalories: Optional
     */
    func getTotalCalories() -> Double? {
        let caloriesMap   = self.ingredientList?.map{$0.calories}
        let totalCalories = caloriesMap?.reduce(0) {return $0 + $1}
        
        return totalCalories
    }
}

// UI ---------

// Extends the UIColor to add the pineapple cake color
extension UIColor {
    struct PastryColor {
        static let mandarin = UIColor(red:0.97, green:0.77, blue:0.56, alpha:1.00)
        static let crumble  = UIColor(red:0.97, green:0.90, blue:0.65, alpha:1.00)
        static let sanguine = UIColor(red:0.89, green:0.46, blue:0.40, alpha:1.00)
    }
    
    struct PinneapleJamColor {
        static let sunnyJam = UIColor(red:0.96, green:0.81, blue:0.28, alpha:1.00)
        static let juicyJam = UIColor(red:0.93, green:0.72, blue:0.18, alpha:1.00)
        static let honeyJam = UIColor(red:0.73, green:0.52, blue:0.20, alpha:1.00)
        static let redJam   = UIColor(red:0.84, green:0.36, blue:0.14, alpha:1.00)
    }
}

/**
 Cake Size
 */
enum CakeSize: CGFloat {
    case ten = 40
    case twy = 60
    case thy = 100
}


/**
 UIHandler
 */
class UIHandler {
    
    // inner properties
    let width  = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    let view : UIView
    let cake : UIView
    
    /**
     Init
     */
    init(size: CakeSize) {
        
        self.view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.width, height: self.height))
        self.cake = UIView(frame: CGRect(x: self.width / 2 - size.rawValue , y: self.height / 2 - size.rawValue, width: size.rawValue, height: size.rawValue))
    }
    
    /**
     Make Cake
        - parameters:
            - cake: Cake
     */
    func makeCake(cake: Cake) {
        self.view.backgroundColor = UIColor.white
        // Draw the cake
        self.cake.layer.cornerRadius = 5.0
        self.cake.backgroundColor = cake.pastryColor
        
        // Get the jam 
        let pineappleJam = self.drawInnerCake(pineapple: cake.pinneappleType, size: self.cake.bounds.width)
        
        // Adding these 2 view to the main UIView
        self.cake.addSubview(pineappleJam)
        self.view.addSubview(self.cake)
    }
    
    /**
     draw Inner Cake
        - parameters:
            - pineapple: Pineapple
            - size: CakeSize
     
        - returns:
            - UIView
     */
    private func drawInnerCake(pineapple: Pineapple, size: CGFloat) -> UIView {
        let jamSize = size / 2
        let xyValue = jamSize / 2
   
        let pineappleJam = UIView(frame: CGRect(x: xyValue, y: xyValue, width: jamSize, height: jamSize))
        pineappleJam.backgroundColor = pineapple.jamColor
        pineappleJam.layer.cornerRadius = 20
        
        return pineappleJam
    }
    
    func render() {
        PlaygroundPage.current.liveView = self.view
    }
}

// Test
// Creating pineapple
let cayenne = PineappleType.cayenne.getPinneapleByType()
// Creating company
let company = try ManufacturerList.taipei.getManufacturerByName(name: "新東陽")
// Creating cake
let cake = Cake(type: cayenne, seller: company, color: UIColor.PastryColor.mandarin)

// Appening the cake to the view
let ui = UIHandler(size: CakeSize.thy)
ui.makeCake(cake: cake)
ui.render()



