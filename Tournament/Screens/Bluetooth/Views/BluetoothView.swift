//
//  BluetoothView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 28/04/2024.
//

import SwiftUI

struct BluetoothView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return BluetoothViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // do nothing
    }
}
