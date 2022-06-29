//
//  XCTest+Helpers.swift
//  XCTest+Helpers
//
//  Created by Marko Engelman on 15/08/2021.
//

import XCTest
@testable import HotspotClient

@available(iOS 11, *)
extension XCTest {
  var anyConfiguration: HotspotConfiguration {
    HotspotConfiguration(ssid: "anySSID", password: "anyPassword", isWEP: false, joinOnce: true)
  }
}
