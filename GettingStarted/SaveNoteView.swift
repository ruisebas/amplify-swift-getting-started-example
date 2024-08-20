//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import SwiftUI

struct SaveNoteView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var notesService: NotesService
    @EnvironmentObject private var storageService: StorageService
    @State private var name = ""
    @State private var description = ""
    @State private var image: Data? = nil

    var body: some View {
        Form {
            Section("Details") {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }

            Section("Picture") {
                PicturePicker(selectedData: $image)
            }

            Button("Save Note") {
                let imageName = image != nil ? UUID().uuidString : nil
                let note = Note(
                    name: name,
                    description: description.isEmpty ? nil : description,
                    image: imageName
                )

                Task {
                    if let image, let imageName {
                        await storageService.upload(image, name: imageName)
                    }
                    await notesService.save(note)

                    dismiss()
                }
            }
        }
    }
}
