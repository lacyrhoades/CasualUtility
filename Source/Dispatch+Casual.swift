import Foundation

extension DispatchQueue {
    public func asyncAfter(_ seconds: TimeInterval, _ execute: @escaping () -> Void) {
        self.asyncAfter(deadline: DispatchTime(seconds)) {
            execute()
        }
    }
    
    public func asyncAfter(_ seconds: TimeInterval, _ execute: DispatchWorkItem) {
        self.asyncAfter(deadline: DispatchTime(seconds), execute: execute)
    }
}

extension DispatchGroup {
    public func waitOrElse(_ timeout: TimeInterval) -> Bool {
        let result = self.wait(timeout)
        
        switch result {
        case .timedOut:
            return false
        case .success:
            return true
        }
    }
    
    public func wait(_ timeout: TimeInterval) -> DispatchTimeoutResult {
        return self.wait(timeout: DispatchTime(timeout))
    }
}

extension DispatchTime {
    public static func seconds(_ secs: TimeInterval) -> DispatchTime {
        return DispatchTime.now() + secs
    }
    
    public init(_ seconds: TimeInterval) {
        self = DispatchTime.now() + seconds
    }
}
