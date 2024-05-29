//
//  BluetoothService.swift
//  Tournament
//
//  Created by Øyvind Hauge on 28/04/2024.
//

import Foundation
import CoreBluetooth

protocol BluetoothServiceInjectable {
    var bluetoothService: BluetoothService { get }
}

extension BluetoothServiceInjectable {
    var bluetoothService: BluetoothService { LiveServiceFactory.instance.bluetoothService }
}

protocol BluetoothService {
}

final class LiveBluetoothService: NSObject, BluetoothService {
    
    static let shared = LiveBluetoothService()
    
    private var centralManager: CBCentralManager!
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
}

extension LiveBluetoothService: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOff:
            print("Is Powered Off.")
        case .poweredOn:
            print("Is Powered On. Start scanning.")
            startScanning()
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
    
    private func startScanning() {
        let services = [CBUUID(string: "6e400001-b5a3-f393-e0a9-e50e24dcca9e")]
        centralManager.scanForPeripherals(withServices: services)
    }
}

extension LiveBluetoothService: CBPeripheralDelegate {
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        // do work
        
        central.stopScan()
    }
}

extension LiveBluetoothService: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
    }
}
