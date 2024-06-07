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
            .font(Font.system(size: 18, weight: .medium))
            .padding(.vertical)
            .padding(.horizontal, 24)
            .background(
                Color(UIColor.systemGray6)
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))
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
