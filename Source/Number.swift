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
        if n % 2 == 1 {
            x = x * b % p
        }
        b = b * b % p
        n >>= 1
    }
    return x
}

private struct Prime: Sequence, IteratorProtocol {
    var isPrime: [Bool]
    var p: Int
    let n : Int

    init(n: Int) {
        self.isPrime = [Bool](repeating: true, count: n+1)
        self.n = n

        isPrime[0] = false
        isPrime[1] = false
        p = 2
    }

    mutating func next() -> Int? {
        let res = p
        var i = p
        while i <= n {
            isPrime[i] = false
            i += p
        }

        p += p == 2 ? 1 : 2
        while !isPrime[p] {
            p += 2
            if p > n {
                return nil
            }
        }

        return res
    }
}

private extension Int {
    func divisors() -> [Int] {
        var buf = [Int]()
        let r = Int(sqrt(Double(self)))
        for i in 1...r {
            if self % i == 0 {
                buf.append(i)
                if self / i != i {
                    buf.append(self/i)
                }
            }
        }
        return buf.sorted()
    }
}

private extension Int {
    func primeFactorized() -> [(p:Int, e:Int)] {
        var res = [(p: Int, e:Int)]()
        var n = self
        var a = 2
        while a * a <= n {
            guard n % a == 0 else { continue }

            var e = 0
            while n % a == 0 {
                e += 1
                n /= a
            }
            res.append((p: a, e: e))
            a += 1
        } 

        if n != 1  {
            res.append((p: n, e: 1))
        }
        
        return res
    }
}
