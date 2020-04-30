import Foundation

private func gcd(_ a: Int, _ b: Int) -> Int {
    var (a, b) = a <= b ? (a, b) : (b, a)
    while b != 0 {
        (a, b) = (b, a % b)
    }
    return a
}

private func lcm(_ a: Int, _ b: Int) -> Int {
    return a * b / gcd(a, b)
}

private func pow(_ b: Int, _ n: Int, _ p: Int) -> Int {
    var (b, n) = (b, n)
    var x = 1
    while n > 0 {
        if n % 2 == 0 {
            b *= b
            n /= 2
        } else {
            x *= b
            n -= 1
        }
    }
    return x
}
