//
//  MetadataTypes.swift
//  PhoneNumberKit
//
//  Created by Roy Marmelstein on 02/11/2015.
//  Copyright © 2015 Roy Marmelstein. All rights reserved.
//

import Foundation

/**
MetadataTerritory object
- Parameter codeID: ISO 639 compliant region code
- Parameter countryCode: International country code
- Parameter internationalPrefix: International prefix. Optional.
- Parameter mainCountryForCode: Whether the current metadata is the main country for its country code.
- Parameter nationalPrefix: National prefix
- Parameter nationalPrefixFormattingRule: National prefix formatting rule
- Parameter nationalPrefixForParsing: National prefix for parsing
- Parameter nationalPrefixTransformRule: National prefix transform rule
- Parameter emergency: MetadataPhoneNumberDesc for emergency numbers
- Parameter fixedLine: MetadataPhoneNumberDesc for fixed line numbers
- Parameter generalDesc: MetadataPhoneNumberDesc for general numbers
- Parameter mobile: MetadataPhoneNumberDesc for mobile numbers
- Parameter pager: MetadataPhoneNumberDesc for pager numbers
- Parameter personalNumber: MetadataPhoneNumberDesc for personal number numbers
- Parameter premiumRate: MetadataPhoneNumberDesc for premium rate numbers
- Parameter sharedCost: MetadataPhoneNumberDesc for shared cost numbers
- Parameter tollFree: MetadataPhoneNumberDesc for toll free numbers
- Parameter voicemail: MetadataPhoneNumberDesc for voice mail numbers
- Parameter voip: MetadataPhoneNumberDesc for voip numbers
- Parameter uan: MetadataPhoneNumberDesc for uan numbers
- Parameter leadingDigits: Optional leading digits for the territory
*/
struct MetadataTerritory {
    let codeID: String
    let countryCode: UInt64
    let internationalPrefix: String?
    let mainCountryForCode: Bool
    let nationalPrefix: String?
    let nationalPrefixFormattingRule: String?
    let nationalPrefixForParsing: String?
    let nationalPrefixTransformRule: String?
    let preferredExtnPrefix: String?
    let emergency: MetadataPhoneNumberDesc?
    let fixedLine: MetadataPhoneNumberDesc?
    let generalDesc: MetadataPhoneNumberDesc?
    let mobile: MetadataPhoneNumberDesc?
    let pager: MetadataPhoneNumberDesc?
    let personalNumber: MetadataPhoneNumberDesc?
    let premiumRate: MetadataPhoneNumberDesc?
    let sharedCost: MetadataPhoneNumberDesc?
    let tollFree: MetadataPhoneNumberDesc?
    let voicemail: MetadataPhoneNumberDesc?
    let voip: MetadataPhoneNumberDesc?
    let uan: MetadataPhoneNumberDesc?
    let numberFormats: [MetadataPhoneNumberFormat]
    let leadingDigits: String?
}

extension MetadataTerritory {
    /**
    Parse a json dictionary into a MetadataTerritory.
    - Parameter jsondDict: json dictionary from attached json metadata file.
    */
    init(jsondDict: [String: Any]) {
        self.generalDesc = MetadataPhoneNumberDesc(jsondDict: jsondDict["generalDesc"] as? [String: Any])
        self.fixedLine = MetadataPhoneNumberDesc(jsondDict: (jsondDict["fixedLine"] as? [String: Any]))
        self.mobile = MetadataPhoneNumberDesc(jsondDict: (jsondDict["mobile"] as? [String: Any]))
        self.tollFree = MetadataPhoneNumberDesc(jsondDict: (jsondDict["tollFree"] as? [String: Any]))
        self.premiumRate = MetadataPhoneNumberDesc(jsondDict: (jsondDict["premiumRate"] as? [String: Any]))
        self.sharedCost = MetadataPhoneNumberDesc(jsondDict: (jsondDict["sharedCost"] as? [String: Any]))
        self.personalNumber = MetadataPhoneNumberDesc(jsondDict: (jsondDict["personalNumber"] as? [String: Any]))
        self.voip = MetadataPhoneNumberDesc(jsondDict: (jsondDict["voip"] as? [String: Any]))
        self.pager = MetadataPhoneNumberDesc(jsondDict: (jsondDict["pager"] as? [String: Any]))
        self.uan = MetadataPhoneNumberDesc(jsondDict: (jsondDict["uan"] as? [String: Any]))
        self.emergency = MetadataPhoneNumberDesc(jsondDict: (jsondDict["emergency"] as? [String: Any]))
        self.voicemail = MetadataPhoneNumberDesc(jsondDict: (jsondDict["voicemail"] as? [String: Any]))
        self.codeID = jsondDict["id"] as! String
        self.countryCode = UInt64(jsondDict["countryCode"] as! String)!
        self.internationalPrefix = jsondDict["internationalPrefix"] as? String
        self.nationalPrefixTransformRule = jsondDict["nationalPrefixTransformRule"] as? String
        let possibleNationalPrefixForParsing = jsondDict["nationalPrefixForParsing"] as? String
        let possibleNationalPrefix = jsondDict["nationalPrefix"] as? String
        self.nationalPrefix = possibleNationalPrefix
        if (possibleNationalPrefixForParsing == nil && possibleNationalPrefix != nil) {
            self.nationalPrefixForParsing = self.nationalPrefix
        }
        else {
            self.nationalPrefixForParsing = possibleNationalPrefixForParsing
        }
        self.preferredExtnPrefix = jsondDict["preferredExtnPrefix"] as? String
        self.nationalPrefixFormattingRule = jsondDict["nationalPrefixFormattingRule"] as? String
        if let mainCountryForCode = jsondDict["mainCountryForCode"] as? NSString {
            self.mainCountryForCode = mainCountryForCode.boolValue
        } else {
            self.mainCountryForCode = false
        }
        var numberFormats = [MetadataPhoneNumberFormat]()
        
        if let availableFormats = (jsondDict["availableFormats"] as? [String: Any])?["numberFormat"] {
            if let formatsArray = availableFormats as? NSArray {
                for format in formatsArray {
                    var processedFormat = MetadataPhoneNumberFormat(jsondDict: format as? [String: Any])
                    if processedFormat.nationalPrefixFormattingRule == nil {
                        processedFormat.nationalPrefixFormattingRule = self.nationalPrefixFormattingRule
                    }
                    numberFormats.append(processedFormat)
                }
            }
            if let format = availableFormats as? [String: Any] {
                let processedFormat = MetadataPhoneNumberFormat(jsondDict: format)
                numberFormats.append(processedFormat)
            }
        }
        self.numberFormats = numberFormats
        self.leadingDigits = jsondDict["leadingDigits"] as? String
    }
}

/**
MetadataPhoneNumberDesc object
- Parameter exampleNumber: An example phone number for the given type. Optional.
- Parameter nationalNumberPattern:  National number regex pattern. Optional.
- Parameter possibleNumberPattern:  Possible number regex pattern. Optional.
*/
struct MetadataPhoneNumberDesc {
    let exampleNumber: String?
    let nationalNumberPattern: String?
    let possibleNumberPattern: String?
}

extension MetadataPhoneNumberDesc {
    /**
    Parse a json dictionary into a MetadataPhoneNumberDesc.
    - Parameter jsondDict: json dictionary from attached json metadata file.
    */
    init(jsondDict: [String: Any]?) {
        self.nationalNumberPattern = jsondDict?["nationalNumberPattern"] as? String
        self.possibleNumberPattern = jsondDict?["possibleNumberPattern"] as? String
        self.exampleNumber = jsondDict?["exampleNumber"] as? String
    }
}

/**
 MetadataPhoneNumberFormat object
 - Parameter pattern: Regex pattern. Optional.
 - Parameter format: Formatting template. Optional.
 - Parameter intlFormat: International formatting template. Optional.

 - Parameter leadingDigitsPatterns: Leading digits regex pattern. Optional.
 - Parameter nationalPrefixFormattingRule: National prefix formatting rule. Optional.
 - Parameter nationalPrefixOptionalWhenFormatting: National prefix optional bool. Optional.
 - Parameter domesticCarrierCodeFormattingRule: Domestic carrier code formatting rule. Optional.
 */
struct MetadataPhoneNumberFormat {
    let pattern: String?
    let format: String?
    let intlFormat: String?
    let leadingDigitsPatterns: [String]?
    var nationalPrefixFormattingRule: String?
    let nationalPrefixOptionalWhenFormatting: Bool?
    let domesticCarrierCodeFormattingRule: String?
}

extension MetadataPhoneNumberFormat {
    /**
     Parse a json dictionary into a MetadataPhoneNumberFormat.
     - Parameter jsondDict: json dictionary from attached json metadata file.
     */
    init(jsondDict: [String: Any]?) {
        self.pattern = jsondDict?["pattern"] as? String
        self.format = jsondDict?["format"] as? String
        self.intlFormat = jsondDict?["intlFormat"] as? String
        var leadingDigits = [String]()
        if let leadingDigitsPatterns = jsondDict?["leadingDigits"] {
            if let leadingDigitArray = leadingDigitsPatterns as? [String] {
                for leadingDigit in leadingDigitArray {
                    leadingDigits.append(leadingDigit)
                }
            }

            if let leadingDigit = leadingDigitsPatterns as? String {
                leadingDigits.append(leadingDigit)
            }
        }
        self.leadingDigitsPatterns = leadingDigits
        self.nationalPrefixFormattingRule = jsondDict?["nationalPrefixFormattingRule"] as? String
        if let _nationalPrefixOptionalWhenFormatting = jsondDict?["nationalPrefixOptionalWhenFormatting"] as? NSString {
            self.nationalPrefixOptionalWhenFormatting = _nationalPrefixOptionalWhenFormatting.boolValue
        } else {
            self.nationalPrefixOptionalWhenFormatting = false
        }
        self.domesticCarrierCodeFormattingRule = jsondDict?["carrierCodeFormattingRule"] as? String
    }
}
