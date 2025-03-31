import Testing
import SnapshotTesting
import SwiftUI


@Suite(.snapshots(record: .never), .tags(.snapshot))
struct SnapshotsTestsSecond {

    @Test
    @MainActor
    func snapshotSecond() {
        let view = Text("Text")
            .padding()
            .background(.red)
            .fixedSize()

        assertSnapshot(of: view, as: .image)
    }
}
