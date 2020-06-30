private struct PriorityQueue<T: Comparable> {
    private var data: [T]
    private var ordered: (T, T) -> Bool
    
    public var isEmpty: Bool {
        return data.isEmpty
    }
    
    public var count: Int {
        return data.count
    }

    init(_ order: @escaping (T, T) -> Bool) {
        self.data = []
        self.ordered = order
    }

    init<Seq: Sequence>(_ seq: Seq, _ order: @escaping (T, T) -> Bool) where Seq.Element == T {
        self.data = []
        self.ordered = order
        
        for x in seq {
            push(x)
        }
    }
    
    public mutating func pop() -> T? {
        return data.popLast().map { item in
            var item = item
            if !isEmpty {
                swap(&item, &data[0])
                siftDown()
            }
            return item
        }
    }
    
    public mutating func push(_ item: T) {
        let oldLen = count
        data.append(item)
        siftUp(oldLen)
    }
    
    private mutating func siftDown() {
        var pos = 0
        let end = count
        
        data.withUnsafeMutableBufferPointer { bufferPointer in
            let _data = bufferPointer.baseAddress!
            swap(&_data[0], &_data[end])
            
            var child = 2 * pos + 1
            while child < end {
                let right = child + 1
                if right < end && ordered(_data[child], _data[right]) {
                    child = right
                }
                swap(&_data[pos], &_data[child])
                pos = child
                child = 2 * pos + 1
            }
        }
        siftUp(pos)
    }
    
    private mutating func siftUp(_ pos: Int) {
        var pos = pos
        while pos > 0 {
            let parent = (pos - 1) / 2;
            if ordered(data[pos], data[parent]) {
                break
            }
            data.swapAt(pos, parent)
            pos = parent
        }
    }
}

extension PriorityQueue: Sequence, IteratorProtocol {
    mutating func next() -> T? {
        return pop()
    }
}