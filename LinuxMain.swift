@testable import PhoneNumberKitTests
import XCTest

XCTMain([
    testCase(PhoneNumberKitTests.__allTests),
    testCase(PhoneNumberKitParsingTests.__allTests),
    testCase(PartialFormatterTests.__allTests),
])
