//
//  Metadata.swift
//  PhoneNumberKit
//
//  Created by Roy Marmelstein on 03/10/2015.
//  Copyright © 2015 Roy Marmelstein. All rights reserved.
//

import Foundation

final class MetadataManager {
    var territories = [MetadataTerritory]()
    var territoriesByCode = [UInt64: [MetadataTerritory]]()
    var mainTerritoryByCode = [UInt64: MetadataTerritory]()
    var territoriesByCountry = [String: MetadataTerritory]()

    // MARK: Lifecycle

    /**
     Private init populates metadata territories and the two hashed dictionaries for faster lookup.
     */
    public init (JSONCallback: JSONCallback? = nil) {
        territories = populateTerritories(getJSON: JSONCallback)
        for item in territories {
            var currentTerritories: [MetadataTerritory] = territoriesByCode[item.countryCode] ?? [MetadataTerritory]()
            currentTerritories.append(item)
            territoriesByCode[item.countryCode] = currentTerritories
            if mainTerritoryByCode[item.countryCode] == nil || item.mainCountryForCode == true {
                mainTerritoryByCode[item.countryCode] = item
            }
            territoriesByCountry[item.codeID] = item
        }
    }

    deinit {
        territories.removeAll()
        territoriesByCode.removeAll()
        territoriesByCountry.removeAll()
    }

    /// Populates the metadata from the included json file resource.
    ///
    /// - returns: array of MetadataTerritory objects
    fileprivate func populateTerritories(getJSON: JSONCallback? = nil) -> [MetadataTerritory] {
        var territoryArray = [MetadataTerritory]()

        do {
            var jsonData: Data?
            var jsonObjects: [String: Any]?
            
            if let getJSON = getJSON {
                jsonObjects = getJSON()
           } else {
                let frameworkBundle = Bundle(for: PhoneNumberKit.self)

                if let jsonPath = frameworkBundle.path(forResource: "PhoneNumberMetadata", ofType: "json"),
                    let data = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) {
                    jsonData = data
                    jsonObjects = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                }
            }

            if let jsonObjects = jsonObjects,
               let metadataDict = jsonObjects["phoneNumberMetadata"] as? [String: Any],
               let metadataTerritories = metadataDict["territories"] as? [String: Any] ,
               let metadataTerritoryArray = metadataTerritories["territory"] as? [Any] {
                    metadataTerritoryArray.forEach({
                        if let territoryDict = $0 as? [String: Any] {
                            let parsedTerritory = MetadataTerritory(jsondDict: territoryDict)
                            territoryArray.append(parsedTerritory)
                        }
                    })
            } else {
                print("Error loading no metadataTerritoryArray")
            }
        }
        catch let e {
            print("Error loading Territories: \(e)")
        }
        return territoryArray
    }

    // MARK: Filters

    /// Get an array of MetadataTerritory objects corresponding to a given country code.
    ///
    /// - parameter code:  international country code (e.g 44 for the UK).
    ///
    /// - returns: optional array of MetadataTerritory objects.
    internal func filterTerritories(byCode code: UInt64) -> [MetadataTerritory]? {
        return territoriesByCode[code]
    }

    /// Get the MetadataTerritory objects for an ISO 639 compliant region code.
    ///
    /// - parameter country: ISO 639 compliant region code (e.g "GB" for the UK).
    ///
    /// - returns: A MetadataTerritory object.
    internal func filterTerritories(byCountry country: String) -> MetadataTerritory? {
        return territoriesByCountry[country.uppercased()]
    }

    /// Get the main MetadataTerritory objects for a given country code.
    ///
    /// - parameter code: An international country code (e.g 1 for the US).
    ///
    /// - returns: A MetadataTerritory object.
    internal func mainTerritory(forCode code: UInt64) -> MetadataTerritory? {
        return mainTerritoryByCode[code]
    }


}
