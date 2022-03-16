//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Gabriel Pereira on 15/03/22.
//

import SwiftUI

struct FlagImage: View {
    let image: String
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(image: "england")
    }
}
