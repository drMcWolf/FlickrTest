import Foundation

public class AsyncOperation: Operation {

    private var _executing = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }

    private var _finished = false {
        willSet { willChangeValue(forKey: "isFinished") }
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }

    override public var isAsynchronous: Bool {
        true
    }

    override public var isExecuting: Bool {
        _executing
    }

    override public var isFinished: Bool {
        _finished
    }

    override public func start() {
        if isCancelled {
            _finished = true
            return
        }

        _executing = true
        main()
    }

    // MARK: - Public

    public final func markFinished() {
        _executing = false
        _finished = true
    }

    public var classDescription: String {
        String(describing: type(of: self))
    }
}
