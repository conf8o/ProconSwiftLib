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
