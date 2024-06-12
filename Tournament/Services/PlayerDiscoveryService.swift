//
//  BluetoothService.swift
//  Tournament
//
//  Created by Øyvind Hauge on 28/04/2024.
//

import Foundation
import CoreBluetooth

protocol PlayerDiscoveryServiceInjectable {
    var bluetoothService: PlayerDiscoveryService { get }
}

extension PlayerDiscoveryServiceInjectable {
    var bluetoothService: PlayerDiscoveryService { LiveServiceFactory.instance.playerDiscoveryService }
}

protocol PlayerDiscoveryService {
    
    func startScanningForPlayer(_ playerId: UUID)
}

final class LivePlayerDiscoveryService: NSObject, PlayerDiscoveryService {
    
    static let shared = LivePlayerDiscoveryService()
    
    private var centralManager: CBCentralManager!
    private var peripheralManager: CBPeripheralManager!
    
    private var discoveredPeripheral: CBPeripheral?
    
    private let tempGUID = UUID(uuidString: "e42d2c6f-913f-4b69-a415-2f305a533b2d")!
    private var data = Data()
    
    func startScanningForPlayer(_ playerId: UUID) {
        centralManager.scanForPeripherals(withServices: [CBUUID(nsuuid: tempGUID)])
    }
    
    override init() {
        super.init()
        initialSetup()
    }
    
    private func initialSetup() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    private func cleanup() {
        
        guard let discoveredPeripheral = discoveredPeripheral, case .connected = discoveredPeripheral.state else {
            return
        }
        
        let charactUuid = CBUUID(nsuuid: UUID()) // FIXME: ...
        
        for service in (discoveredPeripheral.services ?? [] as [CBService]) {
            for characteristic in (service.characteristics ?? [] as [CBCharacteristic]) {
                if characteristic.uuid == charactUuid && characteristic.isNotifying {
                    // It is notifying, so unsubscribe
                    self.discoveredPeripheral?.setNotifyValue(false, for: characteristic)
                }
            }
        }
        
        // If we've gotten this far, we're connected, but we're not subscribed, so we just disconnect
        centralManager.cancelPeripheralConnection(discoveredPeripheral)
    }
}

// MARK: - Central manager delegate

extension LivePlayerDiscoveryService: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOff:
            print("Is Powered Off.")
        case .poweredOn:
            print("Is Powered On. Start scanning.")
            startScanningForPlayer(UUID())
        case .unsupported:
            print("Is Unsupported.")
        case .unauthorized:
            print("Is Unauthorized.")
        case .unknown:
            print("Unknown")
        case .resetting:
            print("Resetting")
        @unknown default:
            print("Error")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: (any Error)?) {
        
        // Deal with errors (if any)
        if let error = error {
            print("Error discovering characteristics: %s", error.localizedDescription)
            cleanup()
            return
        }
        
        guard let characteristicData = characteristic.value,
              let stringFromData = String(data: characteristicData, encoding: .utf8) else { return }
        
        print("Received %d bytes: %s", characteristicData.count, stringFromData)
        
        // Have we received the end-of-message token?
        if stringFromData == "EOM" {
            // End-of-message case: show the data.
            // Dispatch the text view update to the main queue for updating the UI, because
            // we don't know which thread this method will be called back on.
            DispatchQueue.main.async() {
                //self.textView.text = String(data: self.data, encoding: .utf8)
            }
            
            // Write test data
            //writeData()
        } else {
            // Otherwise, just append the data to what we have previously received.
            data.append(characteristicData)
        }
    }
}

// MARK: - Peripheral delegate

extension LivePlayerDiscoveryService: CBPeripheralDelegate {
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        // do work
        
        //central.stopScan()
        
        // RSSI value of -50 or greater is OK to connect
        let signalThreshold: Int = -50
        guard RSSI.intValue >= signalThreshold else {
            print("Discovered peripheral does not have a strong enough signal!")
            return
        }
        
        print("Discovered %s at %d", String(describing: peripheral.name), RSSI.intValue)
        
        if discoveredPeripheral != peripheral {
            
            discoveredPeripheral = peripheral
            
            print("connecting to peripheral \(peripheral)")
            
            centralManager.connect(peripheral, options: nil)
        }
    }
}
