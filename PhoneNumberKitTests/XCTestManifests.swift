import XCTest

extension PartialFormatterTests {
    static let __allTests = [
        ("testAntiguaNumber", testAntiguaNumber),
        ("testConvenienceInitializerAllowsFormatting", testConvenienceInitializerAllowsFormatting),
        ("testFrenchNumberFromAmericanRegion", testFrenchNumberFromAmericanRegion),
        ("testFrenchNumberFromFrenchRegion", testFrenchNumberFromFrenchRegion),
        ("testFrenchNumberIDDFromAmericanRegion", testFrenchNumberIDDFromAmericanRegion),
        ("testFrenchNumberIDDFromFrenchRegion", testFrenchNumberIDDFromFrenchRegion),
        ("testFrenchNumberLocal", testFrenchNumberLocal),
        ("testInvalidNumberNotANumber", testInvalidNumberNotANumber),
        ("testItalianLeadingZeroFromUS", testItalianLeadingZeroFromUS),
        ("testMinimalFrenchNumber", testMinimalFrenchNumber),
        ("testMinimalUSNumberFromFrance", testMinimalUSNumberFromFrance),
        ("testRegionResetsWithEachCallToFormatPartial", testRegionResetsWithEachCallToFormatPartial),
        ("testUKMobileNumber", testUKMobileNumber),
        ("testUSTollFreeNumber", testUSTollFreeNumber),
    ]
}

extension PhoneNumberKitParsingTests {
    static let __allTests = [
        ("testAllExampleNumbers", testAllExampleNumbers),
        ("testAntiguaPagerNumberType", testAntiguaPagerNumberType),
        ("testARNumber", testARNumber),
        ("testAUNumber", testAUNumber),
        ("testBelizeTollFreeType", testBelizeTollFreeType),
        ("testBSNumber", testBSNumber),
        ("testDENumber", testDENumber),
        ("testFailingNumber", testFailingNumber),
        ("testFranceMobileNumberType", testFranceMobileNumberType),
        ("testGBNumber", testGBNumber),
        ("testItalyFixedLineType", testItalyFixedLineType),
        ("testITNumber", testITNumber),
        ("testMaldivesMobileNumber", testMaldivesMobileNumber),
        ("testMultipleMutated", testMultipleMutated),
        ("testPerformanceSimple", testPerformanceSimple),
        ("testRegexMatchesEntirely", testRegexMatchesEntirely),
        ("testUANumber", testUANumber),
        ("testUSNumber", testUSNumber),
        ("testUSNumberNoPrefix", testUSNumberNoPrefix),
        ("testUSTollFreeNumberType", testUSTollFreeNumberType),
        ("testZimbabweVoipType", testZimbabweVoipType),
    ]
}

extension PhoneNumberKitTests {
    static let __allTests = [
        ("testAllCountries", testAllCountries),
        ("testAlternativeNumberWithExtension", testAlternativeNumberWithExtension),
        ("testAmbiguousFixedOrMobileNumber", testAmbiguousFixedOrMobileNumber),
        ("testCodeForCountryInvalid", testCodeForCountryInvalid),
        ("testCodeForCountryValid", testCodeForCountryValid),
        ("testCountriesForCodeInvalid", testCountriesForCodeInvalid),
        ("testCountriesForCodeValid", testCountriesForCodeValid),
        ("testGetRegionCode", testGetRegionCode),
        ("testInvalidBENumbers", testInvalidBENumbers),
        ("testInvalidCNNumbers", testInvalidCNNumbers),
        ("testInvalidDZNumbers", testInvalidDZNumbers),
        ("testInvalidESNumbers", testInvalidESNumbers),
        ("testInvalidGBNumbers", testInvalidGBNumbers),
        ("testInvalidITNumbers", testInvalidITNumbers),
        ("testInvalidNumberE", testInvalidNumberE),
        ("testInvalidNumberNotANumber", testInvalidNumberNotANumber),
        ("testInvalidNumberNotANumberInvalidFormat", testInvalidNumberNotANumberInvalidFormat),
        ("testInvalidNumberTooLong", testInvalidNumberTooLong),
        ("testInvalidNumberTooShort", testInvalidNumberTooShort),
        ("testItalianLeadingZero", testItalianLeadingZero),
        ("testMetadataMainCountryFetch", testMetadataMainCountryFetch),
        ("testMetadataMainCountryFunction", testMetadataMainCountryFunction),
        ("testNumberWithExtension", testNumberWithExtension),
        ("testValidLocalNumberWithNoPrefixNoWhiteSpace", testValidLocalNumberWithNoPrefixNoWhiteSpace),
        ("testValidLocalNumberWithNoPrefixWhiteSpace", testValidLocalNumberWithNoPrefixWhiteSpace),
        ("testValidNumber6", testValidNumber6),
        ("testValidNumberWithAmericanIDDNoWhiteSpace", testValidNumberWithAmericanIDDNoWhiteSpace),
        ("testValidNumberWithAmericanIDDWhiteSpace", testValidNumberWithAmericanIDDWhiteSpace),
        ("testValidNumberWithPlusNoWhiteSpace", testValidNumberWithPlusNoWhiteSpace),
        ("testValidNumberWithPlusWhiteSpace", testValidNumberWithPlusWhiteSpace),
    ]
}

#if !os(macOS)
    public func __allTests() -> [XCTestCaseEntry] {
        return [
            testCase(PartialFormatterTests.__allTests),
            testCase(PhoneNumberKitParsingTests.__allTests),
            testCase(PhoneNumberKitTests.__allTests),
        ]
    }
#endif
