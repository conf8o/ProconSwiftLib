private struct Deque<T> {
    public var buffer: [T?]
    private var head: Int
    private var tail: Int

    init() {
        buffer = [T?](repeating: nil, count: 8)
        head = 0
        tail = 0
    }

    public var isEmpty: Bool {
        return tail == head
    }

    public var capacity: Int {
        return buffer.count
    }
    
    public var count: Int {
        return (head &- tail) & (capacity - 1)
    }
    
    public var isFull: Bool {
        return capacity - count == 1
    }
    
    
    private func wrapIndex(index: Int, size: Int) -> Int {
        return index & (size - 1)
    }
    
    private func wrapAdd(index: Int, append: Int) -> Int {
        return wrapIndex(index: index &+ append, size: capacity)
    }
    
    private func wrapSub(index: Int, subtrahend: Int) -> Int {
        return wrapIndex(index: index &- subtrahend, size: capacity)
    }

    mutating func growIfNecessary() {
        if isFull {
            let oldCap = capacity
            buffer.append(contentsOf: Array(repeating: nil, count: oldCap))
            handleCapacityIncrease(oldCap: oldCap)
        }
    }
    
    private mutating func handleCapacityIncrease(oldCap: Int) {
        let newCap = capacity
        
        //  T      H
        // [ooooooo.]
        //  T      H
        // [ooooooo.........]
        if tail <= head {
            // nop
        }
        //    HT
        // [oo.ooooo]
        //     T      H
        // [...ooooooo......]
        else if head < oldCap - tail {
            buffer.withUnsafeMutableBufferPointer { buf in
                let base = buf.baseAddress!
                for i in 0...head {
                    swap(&base[i], &base[i+oldCap])
                }
            }
            head += oldCap
        }
        //       HT
        // [ooooo.oo]
        //       H        T
        // [ooooo.........oo]
        else {
            let newTail = newCap - (oldCap - tail)
            buffer.withUnsafeMutableBufferPointer { buf in
                let base = buf.baseAddress!
                for i in tail..<oldCap {
                    swap(&base[i], &base[i-tail+newTail])
                }
            }
            tail = newTail
        }
    }

    public mutating func pushBack(_ element: T) {
        growIfNecessary()

        let head = self.head
        self.head = wrapAdd(index: self.head, append: 1)
        buffer[head] = element
    }

    public mutating func pushFront(_ element: T) {
        growIfNecessary()

        self.tail = wrapSub(index: self.tail, subtrahend: 1)
        let tail = self.tail
        buffer[tail] = element
    }

    mutating func popBack() -> T? {
        if isEmpty {
            return nil
        } else {
            self.head = wrapSub(index: self.head, subtrahend: 1)
            let head = self.head
            return buffer[head]
        }
    }
    
    mutating func popFront() -> T? {
        if isEmpty {
            return nil
        } else {
            let tail = self.tail
            self.tail = wrapAdd(index: self.tail, append: 1)
            return buffer[tail]
        }
    }

    func peekFront() -> T? {
        if isEmpty {
            return nil
        } else {
            return buffer[head]
        }
    }

    func peekBack() -> T? {
        if isEmpty {
            return nil
        } else {
            return buffer[tail]
        }
    }
}
