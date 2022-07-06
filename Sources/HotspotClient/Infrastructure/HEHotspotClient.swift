//
//  HEHotspotClient.swift
//  HotspotClient
//
//  Created by Marko Engelman on 13/08/2021.
//

import Foundation
import NetworkExtension

@available(iOS 11.0, *)
public class NEHotspotClient {
  let hotspotManager: NEHotspotConfigurationManager
  
  public init(hotspotManager: NEHotspotConfigurationManager) {
    self.hotspotManager = hotspotManager
  }
  
  static func mapError(error: NSError) -> HotspotClientError {
    switch error.code {
    case NEHotspotConfigurationError.alreadyAssociated.rawValue: return .alreadyConnected
    case NEHotspotConfigurationError.userDenied.rawValue: return .userDeniedConnection
    default: return .other(error: error)
    }
  }
}

// MARK: - HotspotClient
@available(iOS 11.0, *)
extension NEHotspotClient: HotspotClient {
  public func connect(with configuration: HotspotConfiguration, completion: @escaping (HotspotClient.Result) -> Void) throws {
    let hotspotConfiguration = NEHotspotConfiguration(ssid: configuration.ssid, passphrase: configuration.password, isWEP: configuration.isWEP)
    hotspotConfiguration.joinOnce = configuration.joinOnce
    hotspotManager.apply(hotspotConfiguration) { error in
      completion(Result { if let error = error { throw Self.mapError(error: error as NSError) } })
    }
  }
  
  public func disconnect(from SSID: String) {
    hotspotManager.removeConfiguration(forSSID: SSID)
  }
}
