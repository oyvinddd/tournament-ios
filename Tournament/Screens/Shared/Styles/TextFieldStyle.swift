//
//  TextFieldStyle.swift
//  Tournament
//
//  Created by Øyvind Hauge on 07/06/2024.
//

import SwiftUI

struct RoundedTextFieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(Font.system(size: 17, weight: .medium))
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .background(Color(UIColor.systemGray6))
            .foregroundStyle(Color.Text.normal)
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct OutlinedTextFieldStyle_Previews: PreviewProvider {
    
    static var previews: some View {
        TextField("Type something...", text: .constant(""))
            .textFieldStyle(RoundedTextFieldStyle())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
