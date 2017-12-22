//
//  DateFormatterAdditionsTests.swift
//  SwiftNetworkMockingTests
//
//  Created by Diomidis Papas on 22/12/2017.
//  Copyright © 2017 Diomidis Papas. All rights reserved.
//

import XCTest
@testable import SwiftNetworkMocking

final class DateFormatterAdditionsTests: XCTestCase {
    
    func testyyyyMMddFormatted_withValidInput_isNotNil() {
        let formatter = DateFormatter.yyyyMMdd
        let dateString = "2017-12-15"
        let date = formatter.date(from: dateString)
        XCTAssertNotNil(date)
    }
    
    func testyyyyMMddFormatted_withInValidInput_isNil() {
        let formatter = DateFormatter.yyyyMMdd
        let dateString = "2017-12-15-15"
        let date = formatter.date(from: dateString)
        XCTAssertNil(date)
    }
    
    func testyyyyMMddFormatted_withValidInput_hasValidOutputDate() {
        let formatter = DateFormatter.yyyyMMdd
        let dateString = "2018-01-01"
        let date = formatter.date(from: dateString)
        
        // https://www.unixtimestamp.com/index.php
        // 1513296000 = 12/15/2017 @ 12:00am (UTC)
        let expectedDate = Date(timeIntervalSince1970: 1514764800)
        XCTAssertEqual(date, expectedDate)
    }
    
    func testiso8601FullFormatted_withValidInput_isNotNil() {
        let formatter = DateFormatter.iso8601Full
        let dateString = "2017-12-20T01:57:47.000-08:00"
        let date = formatter.date(from: dateString)
        XCTAssertNotNil(date)
    }
    
    func testiso8601FullFormatted_withInValidInput_isNil() {
        let formatter = DateFormatter.iso8601Full
        let dateString = "2017-12-20T01:57:47.000-08:00:AA"
        let date = formatter.date(from: dateString)
        XCTAssertNil(date)
    }
    
    func testiso8601FullFormatted_withValidInput_hasValidOutputDate() {
        let formatter = DateFormatter.iso8601Full
        let dateString = "2017-12-20T01:57:47.000-08:00"
        let date = formatter.date(from: dateString)
        
        // https://www.unixtimestamp.com/index.php
        // 1513763867 = 12/20/2017 @ 9:57am (UTC)
        let expectedDate = Date(timeIntervalSince1970: 1513763867)
        XCTAssertEqual(date, expectedDate)
    }
}

