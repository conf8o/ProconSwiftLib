extension String {
    func wordsMap<T>(_ f: (Substring) -> T?) -> [T] {
        return self.split(separator: " ").compactMap(f)
    }
}

private func readWords<T>(_ f: (Substring) -> T?) -> [T] {
    return readLine()!.wordsMap(f)
}

prefix operator *
private prefix func *<T>(a: inout IndexingIterator<[T]>) -> T {
    return a.next()!
}

extension Optional {
    func pleaseAC(){
        print(self!)
    }
}

// 使用例
// readLine().map { line -> Any in 
//     var nm = line.wordsMap { Int($0) }
    
//     let A = readWords { Int($0) }
//     let B = readWords { Int($0) }

//     return 0
// }
// .pleaseAC()

/// chmaxやchminの汎用化
/// 二つの値を比較し、比較結果がtrueならbをaに入れ、比較結果を返す。
/// chmax(a, b) は ch(&a, b, <)
/// chmin(a, b) は ch(&a, b, >)
///
/// クロージャを使って任意の比較ができる
/// ch(a, b) { abs($0) < abs($1) }
@inlinable func ch<T>(_ a: inout T, _ b: T, _ compare: (T, T) -> Bool) -> Bool {
    if compare(a, b) {
        a = b
        return true
    } else {
        return false
    }
}

class Words<T>: Sequence, IteratorProtocol {
    let f: (Substring) -> T?
    init (_ f: @escaping (Substring) -> T?) {
        self.f = f
    }

    func next() -> [T]? {
        return readLine()?.split(separator: " ").map { s in 
            guard let s = f(s) else { 
                preconditionFailure("Reader init failed.")
            }
            return s
        }
    }
}

extension Words where T == Int {
    convenience init() {
        self.init { Int($0) } 
    }
}

extension Words where T == String {
    convenience init() {
        self.init(String.init)
    }
}

extension Words {
    func get() -> (T, T) {
        let line = self.next()!
        return (line[0], line[1])
    }

    func get() -> (T, T, T) {
        let line = self.next()!
        return (line[0], line[1], line[2])
    }
     
    func get() -> (T, T, T, T) {
        let line = self.next()!
        return (line[0], line[1], line[2], line[3])
    }
}


let intReader = Words<Int>()

