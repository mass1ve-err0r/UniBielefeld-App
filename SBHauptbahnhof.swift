//
//  StadtBahnView.swift
//  Meine UniBi
//
//  Created by Saadat Baig on 14.02.20.
//  Copyright © 2020 Saadat Baig. All rights reserved.
//

import SwiftUI

struct SBHauptbahnhof: View {
    let documentURL = Bundle.main.url(forResource: "Linie4_DürkoppTor6", withExtension: "pdf")!
    var body: some View {
        PDFKitView(url: documentURL)
            .navigationBarTitle("Uni ➡️ Dürkopp Tor 6", displayMode: .inline)
    }
}

struct SBHauptbahnhof_Previews: PreviewProvider {
    static var previews: some View {
        SBHauptbahnhof()
    }
}
