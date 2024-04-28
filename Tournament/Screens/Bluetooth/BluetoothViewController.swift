//
//  BluetoothViewController.swift
//  Tournament
//
//  Created by Øyvind Hauge on 28/04/2024.
//

import UIKit
import CoreBluetooth

final class BluetoothViewController: UIViewController {
    
    private var manager: CBCentralManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        manager = CBCentralManager(delegate: self, queue: nil)
    }
}

// MARK: - Bluetooth Central Manager Delegate

extension BluetoothViewController: CBCentralManagerDelegate {
    
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
        manager.scanForPeripherals(withServices: services)
    }
}

extension BluetoothViewController: CBPeripheralDelegate {
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        // do work
        
        central.stopScan()
    }
}

extension BluetoothViewController: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
    }
}
