class DoubleEndedNode<T> {
    let value: T
    var head: DoubleEndedNode<T>? = nil
    var foot: DoubleEndedNode<T>? = nil

    init(_ value: T) {
        self.value = value
    }
}

struct DoubleEndedLinkedList<T> {
    var front: DoubleEndedNode<T>?
    var back: DoubleEndedNode<T>?
    var count: Int { self._count }

    private var _count: Int

    init() {
        self.front = nil
        self.back = nil
        self._count = 0
    }

    public mutating func pushFront(_ node: DoubleEndedNode<T>) {
        // ☺node👣? :: ☺front👣
        front?.head = node
        node.foot = front
        front = node
        if back == nil {
            back = node
        }
        _count += 1
    } 

    public mutating func pushBack(_ node: DoubleEndedNode<T>) {
        // ☺back👣? :: ☺node👣
        back?.foot = node
        node.head = back
        back = node
        if front == nil {
            front = node
        }
        _count += 1
    }

    public mutating func popFront() -> DoubleEndedNode<T>? {
        guard let x = front else { return nil }

        front = x.foot
        _count -= 1

        return x
    }

    public mutating func popBack() -> DoubleEndedNode<T>? {
        guard let x = back else { return nil }

        back = x.head
        _count -= 1
        return x
    }
}

struct Deque<T> {
    var buffer: DoubleEndedLinkedList<T>

    var count: Int { buffer.count }

    init() {
        buffer = DoubleEndedLinkedList<T>()
    }

    public mutating func pushFront(_ value: T) {
        buffer.pushFront(DoubleEndedNode<T>(value))
    } 

    public mutating func pushBack(_ value: T) {
        buffer.pushBack(DoubleEndedNode<T>(value))
    }

    public mutating func popFront() -> T? {
        return buffer.popFront().map{ $0.value }
    }

    public mutating func popBack() -> T? {
        return buffer.popBack().map{ $0.value }
    }
}

struct Queue<T> {
    var buffer: Deque<T>

    var count: Int { buffer.count }

    init() {
        buffer =  Deque<T>()
    }

    public mutating func enqueue(_ value: T) {
        buffer.pushFront(value)
    }

    public mutating func dequeue(_ value: T) -> T? {
        return buffer.popBack()
    }
}