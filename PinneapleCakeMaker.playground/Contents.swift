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
}

extension Const {
    
    /**
     Add a manufacturer in the list of manufacturer
     
     - paramters:
        city: the name of the city
        name: the name of the company
     
     - returns:
        
     */
    mutating func addManufacturer(city: String, name: String) {
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
     Return a manufacturer information based on the name and the city
     
     - parameters:
        - name: The name of the company
     
     - returns:
        - tuple composed of the (name, city, ranking)
     
     In the case of an unknown manufacturer is pass this method will throw
     
     */
    func getManufacturerByDistrict(name: String) throws -> (name: String, city: String){
        let collection = Const.manufacturerList[self.rawValue]
        let manName = collection?.filter{$0 == name}
        
        if (manName == nil) {
           throw PineappleError.unknownManufacturer
        }
        
        return (manName![0], self.rawValue)
    }
}

struct Pineapple {
    var name  : String
    var origin: String?
    var cultivationCountry: String?
}

struct Manufacturer {
    var name   : String
    var country: String
    var ranking: UInt8
}

struct Ingredient {
    var name    : String
    var calories: Double
}

struct Cake {
    var pinneappleType: Pineapple
    var manufacturer  : Manufacturer
    var ingredientList: [Ingredient]
}

// UI below

