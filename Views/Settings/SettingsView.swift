import SwiftUI

struct SettingsView: View {
    // Same key as in PebbleApp, so changing it here updates the whole app instantly.
    @AppStorage("appearance") private var appearance: AppearanceMode = .system

    private var versionText: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Appearance") {
                    Picker("Theme", selection: $appearance) {
                        ForEach(AppearanceMode.allCases) { mode in
                            Text(mode.title).tag(mode)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("About") {
                    LabeledContent("App", value: "Pebble")
                    LabeledContent("Version", value: versionText)
                    LabeledContent("Built with", value: "SwiftUI + SwiftData")
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
