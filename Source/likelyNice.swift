/// 空白区切りの文字列を取得する。クロージャや関数を渡して、それぞれの単語を変換できる。
/// Swiftは区切った文字列がSubstring型なので、Stringにしたいときにも使えそう。
///
/// 例: Intにしたい場合
/// let X = readWords { Int($0)! }
private func readWords<T>(_ f: (Substring) -> T) -> [T] {
    return readLine()!.split(separator: " ").map(f)
}

prefix operator *
private prefix func *<T>(a: inout IndexingIterator<[T]>) -> T {
    return a.next()!
}

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
