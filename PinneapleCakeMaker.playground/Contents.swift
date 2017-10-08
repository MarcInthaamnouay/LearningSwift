//: Playground - noun: a place where people can play

import UIKit

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
        "佳德": 7,
        "新東陽": 7,
        "佳德": 10,
        "台北犁記": 8
    ]
}

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
            return Pineapple(name: "Cayenne", origin: "Venezuela", cultivationCountry: nil)
        case .queen:
            return Pineapple(name: "Queen", origin: "Malaysia", cultivationCountry: nil)
        case .redSpanish:
            return Pineapple(name: "Red Spannish", origin: "Mexico", cultivationCountry: nil)
        case .abacaxi:
            return Pineapple(name: "Abacaxi", origin: "Brazil", cultivationCountry: nil)
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
        return Const.manufacturerList[self.rawValue]!
    }
}

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

struct Pineapple {
    var name  : String
    var origin: String?
    var cultivationCountry: String?
}

struct Manufacturer {
    var name   : String
    var city   : String
    var ranking: Int?
}

struct Ingredient {
    var name    : String
    var calories: Double
}

struct Cake {
    var pinneappleType: Pineapple
    var manufacturer  : Manufacturer
    var ingredientList: [Ingredient]?
    
    /**
     Init: We override the init as we want to have already some properties in the ingredientList
     
     - parameters: 
        - type: Pinneaple, a type of pineapple
        - seller: A manufacturer
     */
    init(type: Pineapple, seller: Manufacturer) {
        self.pinneappleType = type
        self.manufacturer = seller
        self.ingredientList = [
            BasicIngredient.butter.getBasicIngredient(),
            BasicIngredient.eggYolk.getBasicIngredient(),
            BasicIngredient.flour.getBasicIngredient()
        ]
    }
}

// UI below


