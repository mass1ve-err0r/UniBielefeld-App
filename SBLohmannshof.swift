//
//  SBLohmannshof.swift
//  Meine UniBi
//
//  Created by Saadat Baig on 14.02.20.
//  Copyright © 2020 Saadat Baig. All rights reserved.
//

import SwiftUI

struct SBLohmannshof: View {
    let documentURL = Bundle.main.url(forResource: "Linie4_Lohmannshof", withExtension: "pdf")!
    var body: some View {
        PDFKitView(url: documentURL)
            .navigationBarTitle("Uni ➡️ Lohmannshof", displayMode: .inline)
    }
}

struct SBLohmannshof_Previews: PreviewProvider {
    static var previews: some View {
        SBLohmannshof()
    }
}
