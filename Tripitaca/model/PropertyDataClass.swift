//
//  PropertyDataClass.swift
//  Tripitaca
//
//  Created by Ernest Mwangi on 26/01/2023.
//

import Foundation

struct PropertyDataClass : Codable{
    var id: Int?
    var name: String?
    var price: String?
    var location: String?
    var coordinates: Coordinates?
    var description: String?
    var facilities: [String]?
    var featuredImage: String?
    var rating: String?
    var rooms: [String]?
}

struct Coordinates: Codable{
    var latitude: Double?
    var longitude: Double?
}

struct FacilityData: Codable{
    var rooms: String?
    var wifi: Bool?
    var swimmingPool: Bool?
    var gym: Bool?
    var parking: String?

}



