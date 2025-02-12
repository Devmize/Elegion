//
//  UserCell.swift
//  Elegion
//
//  Created by Mizyuk Evgeny on 10.02.2025.
//

import SwiftUI
import CoreLocation

struct UserCell: View {

    let user: User
    let distance: Double

    var body: some View {
        GeometryReader { geo in
            HStack {
                Image(user.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.height, height: geo.size.height)
                    .clipShape(.circle)
                    .padding(.horizontal, 8)

                Text(user.name)

                Spacer()

                HStack {
                    Text("\(Int(distance))")
                    Text("Метров")
                }
                    .padding(.trailing, 16)
            }
            .contentShape(Rectangle())
        }
    }
}

#Preview {
    UserCell(user: User(id: 0, name: "Eugene", coordinates: CLLocation(latitude: 55.751244, longitude: 37.618423)), distance: 0)
}
