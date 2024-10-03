//
//  ClinicLocationTitleView.swift
//  JSUHealth
//
//  Created by Asaad Jaber on 27/09/2024.
//

import SwiftUI

struct ClinicLocationTitleView: View {
    
    var location: String
    
    var body: some View {
        Label {
            Text("\(location), Turkey")
                
                .foregroundColor(.white)
                .font(.system(size: 12.0))
                .fontWeight(.bold)
        } icon: {
            Image(systemName: "location.north.circle").foregroundStyle(.white)
        }.padding(EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10))
            .background(.teal)
            .cornerRadius(8.0)
    }
}

#Preview {
    ClinicLocationTitleView(location: "Istanbul")
}
