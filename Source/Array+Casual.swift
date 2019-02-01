extension Array where Element: Hashable {
    public func after(where elementQuery: (Element) -> (Bool)) -> Element? {
        if let index = self.index(where: elementQuery), index + 1 < self.count {
            return self[index + 1]
        }
        return nil
    }

    public func after(_ item: Element) -> Element? {
        if let index = self.index(of: item) , index + 1 < self.count {
            return self[index + 1]
        }
        return nil
    }

    public func before(_ item: Element) -> Element? {
        if let index = self.index(of: item) , index > 0 {
            return self[index - 1]
        }
        return nil
    }
}

extension Array {
    /// Returns an array containing this sequence shuffled
    var shuffled: Array {
        var elements = self
        return elements.shuffle()
    }

    /// Shuffles this sequence in place
    @discardableResult
    mutating func shuffle() -> Array {
        indices.dropLast().forEach {
            guard case let index = Int(arc4random_uniform(UInt32(count - $0))) + $0, index != $0 else { return }
            self.swapAt($0, index)
        }
        return self
    }

    var chooseOne: Element { return self[Int(arc4random_uniform(UInt32(count)))] }
    func choose(_ n: Int) -> Array { return Array(shuffled.prefix(n)) }

    public func appending(_ suffix: Array) -> Array {
        var contents = self
        for piece in suffix {
            contents.append(piece)
        }
        return contents
    }

}

extension Array {
    public func appending(_ suffix: Element) -> Array<Element> {
        var contents = self
        contents.append(suffix)
        return contents
    }
}

extension Set {
    public func setmap<U>(_ transform: (Element) -> U) -> Set<U> {
        return Set<U>(self.lazy.map(transform))
    }
}

extension Array {
    public func pickSelects(count: Int) -> Array {
        if self.count < count {
            return self
        }

        let idealStep: Int = self.count / count

        if self.count < idealStep * count {
            return Array(self.prefix(count))
        }

        var results: [Element] = []

        for i in 0...(count - 1) {
            results.append(self[i * idealStep])
        }

        return results
    }
}

extension Array {
    public func stretched(to length: Int) -> Array {
        if self.isEmpty {
            return []
        }

        if length <= self.count {
            return self
        }

        var results: [Element] = []

        for index in 0...(length - 1) {
            results.append(self[(index / self.count) % self.count])
        }

        return results
    }

    public func limit(_ maxLength: Int?) -> ArraySlice<Element> {
        guard let maxLength = maxLength else {
            return ArraySlice(self)
        }

        if maxLength >= self.count {
            return ArraySlice(self)
        }

        return self.prefix(maxLength)
    }
}
