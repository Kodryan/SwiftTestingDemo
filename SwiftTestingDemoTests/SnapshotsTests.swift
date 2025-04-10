
import Testing
import SnapshotTesting
import SwiftUI

@MainActor
@Suite(.snapshots(record: .never), .tags(.snapshot))
struct SnapshotsTests {
    @Test func snapshot() {
        let view = Text("Text")
            .padding()
            .background(.blue)
            .fixedSize()

        assertSnapshot(of: view, as: .image)
    }
}
