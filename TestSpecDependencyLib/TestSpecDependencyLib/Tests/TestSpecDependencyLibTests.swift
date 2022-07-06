import XCTest
@testable import TestSpecDependencyLib
import TestSpecDependencyBase

final class TestSpecDependencyLibTests: XCTestCase {
    func testExample() {
        XCTAssertNotNil(TestSpecDependencyLib.example)
    }

    func testExtension() throws {
        let example = UIWindow(rootViewController: UIViewController())
        XCTAssertNotNil(example.rootViewController)
    }
}
