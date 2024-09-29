//
//  ProcedureLabelsView.swift
//  JSUHealth
//
//  Created by Asaad Jaber on 25/09/2024.
//

import SwiftUI

struct ProcedureLabelsView: View {
    
    var procedures: [String]
    var size: CGSize
    var title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 3, content: {
            Text(title.capitalized)
                .padding(EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10))
                .font(.system(size: 12.0))
                .fontWeight(.bold)
                .background(.teal)
                .cornerRadius(8.0)
                .foregroundStyle(.white)
            Text(procedures.joined(separator: " • ").capitalized)
                .padding(EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10))
                .font(.system(size: 12.0))
                .fontWeight(.regular)
                .background(.teal)
                .cornerRadius(8.0)
                .foregroundStyle(.white)
                .frame(maxWidth: size.width - 20,
                       alignment: .leading)
        })
    }
    
    func someAction() { }
}

#Preview {
    ProcedureLabelsView(procedures: ["FUE hair transplant", "Beard transplant", "DHI hair transplant"], size: CGSize(width: 250, height: 250), title: "Hair transplant")
}
