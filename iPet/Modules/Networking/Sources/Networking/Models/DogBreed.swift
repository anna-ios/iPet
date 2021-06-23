//
// DogBreed.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct DogBreed: Codable {

    public var id: Double
    public var name: String
    public var temperament: String?
    public var lifeSpan: String?
    public var altNames: String?
    public var wikipediaUrl: String?
    public var origin: String?
    public var weight: Dimensions?
    public var countryCode: String?
    public var cfaUrl: String?
    public var vetstreetUrl: String?
    public var vcahospitalsUrl: String?
    public var height: Dimensions?

    public init(id: Double, name: String, temperament: String? = nil, lifeSpan: String? = nil, altNames: String? = nil, wikipediaUrl: String? = nil, origin: String? = nil, weight: Dimensions? = nil, countryCode: String? = nil, cfaUrl: String? = nil, vetstreetUrl: String? = nil, vcahospitalsUrl: String? = nil, height: Dimensions? = nil) {
        self.id = id
        self.name = name
        self.temperament = temperament
        self.lifeSpan = lifeSpan
        self.altNames = altNames
        self.wikipediaUrl = wikipediaUrl
        self.origin = origin
        self.weight = weight
        self.countryCode = countryCode
        self.cfaUrl = cfaUrl
        self.vetstreetUrl = vetstreetUrl
        self.vcahospitalsUrl = vcahospitalsUrl
        self.height = height
    }

    public enum CodingKeys: String, CodingKey, CaseIterable { 
        case id
        case name
        case temperament
        case lifeSpan = "life_span"
        case altNames = "alt_names"
        case wikipediaUrl = "wikipedia_url"
        case origin
        case weight
        case countryCode = "country_code"
        case cfaUrl = "cfa_url"
        case vetstreetUrl = "vetstreet_url"
        case vcahospitalsUrl = "vcahospitals_url"
        case height
    }

}
