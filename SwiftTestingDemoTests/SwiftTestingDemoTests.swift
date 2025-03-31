import Testing

// Migrating guide https://developer.apple.com/documentation/testing/migratingfromxctest

@Suite("Demo Tests")
struct SwiftTestingDemoTests {
    @Test func succes() {
        #expect(1 == 1)
    }

    @Test func testFail() {
        Issue.record("This fails")
        #expect(1 == 2)
        #expect(1 > 2)
    }

    @Test func unwrapOptional() throws {
        let optional: String? = "1"
        let unwrapped = try #require(optional)
        #expect(unwrapped == "1")
    }

    @Test func diff() {
        let foo = Stub(foo: "foo", bar: 0, baz: 0)
        let bar = Stub(foo: "bar", bar: 0, baz: 0)

        #expect(foo == bar,  "This is message")
    }

    @Suite("Traits tests")
    struct Traits {
        @Test(.enabled(if: true))
        func enabled() {}

        @Test(.disabled())
        func disabled() {
            Issue.record()
        }

        @Test(.tags(.myTag))
        func withTag() {}

        @Test("Named test")
        func withName() {}
    }

    struct Arguments {
        @Test(arguments: [1,2,3])
        func withArguments(argument: Int) {
            #expect(argument == 1)
        }

        @Test(.serialized, arguments: [1: "1", 2: "2"])
        func testWithDict(number: Int, string: String) {
            #expect(String(number) == string)
        }

        @Test(arguments: zip([1 ,2, 3], ["1", "2", "3"]))
        func testWithZip(number: Int, string: String) {
            #expect(String(number) == string)
        }

        @Test(arguments: [1, 2, 3], ["1", "2", "3"])
        func testWithCartesianProduct(number: Int, string: String) {
            #expect(String(number) == string)
        }
    }

    struct Advanced {
        @Test func withIssue() {
            withKnownIssue("flaky test", isIntermittent: true) {
                if Bool.random() {
                    Issue.record()
                }
            }
        }

        @Test func confirmationExample() async {
            await confirmation() { confirm in
                try? await Task.sleep(for: .seconds(1))
                confirm()
            }
        }
    }
}

extension SwiftTestingDemoTests {
    struct Extension {
        @Test func extensionTest()  {}
    }
}

struct Stub: Equatable {
    let foo: String
    let bar: Int
    let baz: Int
}

extension Tag {
    @Tag static var myTag: Self
}
