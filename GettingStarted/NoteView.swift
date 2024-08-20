//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct NoteView: View {
    @State var note: Note

    var body: some View {
        HStack(alignment: .center, spacing: 5.0) {
            VStack(alignment: .leading, spacing: 5.0) {
                Text(note.name)
                    .bold()
                if let description = note.description {
                    Text(description)
                }
            }

            if let image = note.image {
                Spacer()
                RemoteImage(name: image)
                    .frame(width: 30, height: 30)
            }
        }
    }
}
