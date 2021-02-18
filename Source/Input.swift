@inlinable func read<T>(_ f: (Substring) -> T) -> [T] { readLine()!.split(separator: " ").map(f) }
@inlinable func int<S: StringProtocol>(_ s: S) -> Int { Int(s)! }

prefix operator *
extension Array {
    typealias T = Element
    static prefix func *(a: Array) -> (T, T) { (a[0], a[1]) }
    static prefix func *(a: Array) -> (T, T, T) { (a[0], a[1], a[2]) }
    static prefix func *(a: Array) -> (T, T, T, T) { (a[0], a[1], a[2], a[3]) }
    static prefix func *(a: Array) -> (T, T, T, T, T) { (a[0], a[1], a[2], a[3], a[4]) }
}
