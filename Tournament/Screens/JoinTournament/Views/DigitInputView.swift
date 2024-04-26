//
//  DigitInputView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import SwiftUI

struct DigitInputView: View {
    
    @State var digit1: String = ""
    
    var body: some View {
        
        HStack {
            
            TextField("", text: $digit1)
                .textFieldStyle(RoundedTextFieldStyle())
            
            TextField("", text: $digit1)
                .textFieldStyle(RoundedTextFieldStyle())
            
            TextField("", text: $digit1)
                .textFieldStyle(RoundedTextFieldStyle())
            
            TextField("", text: $digit1)
                .textFieldStyle(RoundedTextFieldStyle())
            
            TextField("", text: $digit1)
                .textFieldStyle(RoundedTextFieldStyle())
            
            TextField("", text: $digit1)
                .textFieldStyle(RoundedTextFieldStyle())
        }
    }
}

struct RoundedTextFieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.all)
            .font(Font.system(size: 20, weight: .heavy, design: .rounded))
            .multilineTextAlignment(.center)
            .background(Color(UIColor.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .frame(alignment: .center)
            .keyboardType(.numberPad)
    }
}
