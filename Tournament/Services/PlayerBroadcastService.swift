//
//  BluetoothPeripheralService.swift
//  Tournament
//
//  Created by Øyvind Hauge on 12/06/2024.
//

import Foundation
import Combine
import CoreBluetooth

enum BroadcastingState {
    case unknown, unauthorized, enabled, disabled, resetting
}

protocol PlayerBroadcastServiceInjectable {
    var playerBroadcastService: PlayerBroadcastService { get }
}

extension PlayerBroadcastServiceInjectable {
    var playerBroadcastService: PlayerBroadcastService { LiveServiceFactory.instance.playerBroadcastService }
}

protocol PlayerBroadcastService {
    
    var broadcastingSubject: CurrentValueSubject<BroadcastingState, Never> { get }
    
    func setup(with playerId: UUID?)
    
    func toggleBroadcasting(_ enabled: Bool)
}

final class LivePlayerBroadcastService: NSObject, PlayerBroadcastService {

    static let shared = LivePlayerBroadcastService()
    
    var broadcastingSubject = CurrentValueSubject<BroadcastingState, Never>(.unknown)
    
    private var peripheralManager: CBPeripheralManager!
    private var transferCharacteristic: CBMutableCharacteristic?
    private var serviceUuid: CBUUID!
    
    override init() {
        super.init()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        let uuid = UUID(uuidString: "e42d2c6f-913f-4b69-a415-2f305a533b2d")!
        self.serviceUuid = CBUUID(nsuuid: uuid)
    }
    
    func setup(with playerId: UUID?) {
        guard let playerId = playerId else {
            print("Player ID doesn't exist. Will not setup BT peripheral at this time.")
            return
        }
        
        // Start with the CBMutableCharacteristic.
        let transferCharacteristic = CBMutableCharacteristic(
            type: CBUUID(nsuuid: playerId),
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
    
    func toggleBroadcasting(_ enabled: Bool) {
        guard enabled else {
            peripheralManager.stopAdvertising()
            return
        }
        // we advertise our services' UUID
        peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [serviceUuid]])
        
        broadcastingSubject.send(.enabled)
    }
}

// MARK: - Peripheral manager delegate

extension LivePlayerBroadcastService: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
            
        case .unknown, .poweredOff, .unsupported:
            broadcastingSubject.send(.unknown)
        case .resetting:
            print("RESETTING")
            broadcastingSubject.send(.resetting)
        case .unauthorized:
            broadcastingSubject.send(.unauthorized)
        case .poweredOn:
            print("POWERED ON")
            toggleBroadcasting(true)
        @unknown default:
            broadcastingSubject.send(.unknown)
        }
    }
}
