//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AuthenticationServices
import SwiftUI

struct LandingView: View {
    @EnvironmentObject private var authenticationService: AuthenticationService
    @State private var isLoading = true

    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
            }
            Group {
                if authenticationService.isSignedIn {
                    NotesView()
                } else {
                    Button("Sign in") {
                        Task {
                            await authenticationService.signIn(presentationAnchor: window)
                        }
                    }
                }
            }
            .opacity(isLoading ? 0.5 : 1)
            .disabled(isLoading)
        }
        .task {
            isLoading = true
            await authenticationService.fetchSession()
            if !authenticationService.isSignedIn {
                await authenticationService.signIn(presentationAnchor: window)
            }
            isLoading = false
        }
    }

    private var window: ASPresentationAnchor {
        if let delegate = UIApplication.shared.connectedScenes.first?.delegate as? UIWindowSceneDelegate,
           let window = delegate.window as? UIWindow {
            return window
        }
        return ASPresentationAnchor()
    }
}
