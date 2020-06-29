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


private extension Int {
    func divisors() -> [Int] {
        var res = [Int]()
        var i = 1
        while i * i <= self {
            if self % i == 0 {
                res.append(i)
                if self / i != i {
                    res.append(self/i)
                }
            }
            i += 1
        }
        return res.sorted()
    }
}

private struct Prime: Sequence, IteratorProtocol {
    var isPrime: [Bool]
    var p: Int
    let n : Int

    init(_ n: Int) {
        self.isPrime = [Bool](repeating: true, count: n+1)
        self.n = n

        isPrime[0] = false
        isPrime[1] = false
        p = 2
    }

    mutating func next() -> Int? {
        let res = p
        var i = p + p
        while i <= n {
            isPrime[i] = false
            i += p
        }

        guard p > 2 else {
            p += 1
            return res
        }

        repeat {
            p += 2
            if p > n {
                return nil
            }
        } while !isPrime[p]

        return res
    }

    static func primeFactorize(_ n: Int) -> [(p:Int, e:Int)] {
        let rtn = Int(sqrt(Double(n)))
        var n = n
        var res = [(p:Int, e:Int)]()
        for p in Prime(rtn) {
            guard n % p == 0 else { continue }

            var e = 0
            while n % p == 0 {
                n /= p
                e += 1
            }

            res.append((p: p, e: e))
        }

        if n > 1 {
            res.append((p: n, e: 1))
        }

        return res
    }
}

private extension Int {
    func primeFactorized() -> [(p:Int, e:Int)] {
        var res = [(p: Int, e:Int)]()
        var n = self
        var a = 2

        while a * a <= n {
            guard n % a == 0 else {
                a += 1
                continue 
            }

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
