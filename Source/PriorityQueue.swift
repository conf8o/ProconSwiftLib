private struct PriorityQueue<T: Comparable> {
    private var data: [T] = []
    
    public var isEmpty: Bool {
        return data.isEmpty
    }
    
    public var count: Int {
        return data.count
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
    
    public mutating func append(_ item: T) {
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
                if right < end && _data[child] <= _data[right] {
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
            if data[pos] <= data[parent] {
                break
            }
            data.swapAt(pos, parent)
            pos = parent
        }
    }
}
