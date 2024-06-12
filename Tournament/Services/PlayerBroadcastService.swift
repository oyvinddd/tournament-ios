//
//  BluetoothPeripheralService.swift
//  Tournament
//
//  Created by Øyvind Hauge on 12/06/2024.
//

import Foundation
import CoreBluetooth

protocol PlayerBroadcastServiceInjectable {
    var playerBroadcastService: PlayerBroadcastService { get }
}

extension PlayerBroadcastServiceInjectable {
    var playerBroadcastService: PlayerBroadcastService { LiveServiceFactory.instance.playerBroadcastService }
}

protocol PlayerBroadcastService {
    
    func toggleBroadcasting(_ enabled: Bool)
}

final class LivePlayerBroadcastService: NSObject, PlayerBroadcastService {
    
    private var peripheralManager: CBPeripheralManager!
    private var transferCharacteristic: CBMutableCharacteristic?
    private var serviceUuid: CBUUID!
    
    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        let uuid = UUID(uuidString: "e42d2c6f-913f-4b69-a415-2f305a533b2d")!
        self.serviceUuid = CBUUID(nsuuid: uuid)
        initialSetup(UUID())
    }
    
    func toggleBroadcasting(_ enabled: Bool) {
        guard enabled else {
            peripheralManager.stopAdvertising()
            return
        }
        // we advertise aour services' UUID
        peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [serviceUuid]])
    }
    
    private func initialSetup(_ playerId: UUID) {
        
        let guid = CBUUID(nsuuid: playerId)
        
        // Start with the CBMutableCharacteristic.
        let transferCharacteristic = CBMutableCharacteristic(
            type: guid,
            properties: [.notify, .writeWithoutResponse],
            value: nil,
            permissions: [.readable, .writeable]
        )
        
        // Create a service from the characteristic.
        let transferService = CBMutableService(type: serviceUuid, primary: true)
        
        // Add the characteristic to the service.
        transferService.characteristics = [transferCharacteristic]
        
        // And add it to the peripheral manager.
        peripheralManager.add(transferService)
        
        // Save the characteristic for later.
        self.transferCharacteristic = transferCharacteristic
    }
}

// MARK: - Peripheral manager delegate

extension LivePlayerBroadcastService: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
            
        case .unknown:
            print("UNKNNOWN")
        case .resetting:
            print("RESETTING")
        case .unsupported:
            print("UNSUPPORTED")
        case .unauthorized:
            print("UNAUTHORIZED")
        case .poweredOff:
            print("POWERED OFF")
        case .poweredOn:
            print("POWERED ON")
        @unknown default:
            print("UNKNNOWN (DEF.)")
        }
    }
}
