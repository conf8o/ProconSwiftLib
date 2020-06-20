import Foundation

private struct Combinations<Seq: Sequence>: Sequence, IteratorProtocol {
    let pool: [Seq.Element]
    let r: Int

    var indecies: [Int]
    var first = true

    init(_ seq: Seq, _ r: Int) {
        self.pool = [Seq.Element](seq)
        self.r = r
        self.indecies = [Int](0..<r)
    }

    mutating func next() -> [Seq.Element]? {
        let n = pool.count
        guard r <= n else { return nil }
        guard !first else {
            first = false
            return indecies.map { pool[$0] }
        }

        var i = r - 1
        while indecies[i] == i + n - r {
            if i > 0 {
                i -= 1
            } else {
                return nil
            }
        }

        indecies[i] += 1
        for j in i+1..<r {
            indecies[j] = indecies[j - 1] + 1
        }

        return indecies.map { pool[$0] }
    }
}

private struct Permutations<Seq: Sequence>: Sequence, IteratorProtocol {
    let pool: [Seq.Element]
    let r: Int
    
    var indecies: [Int]
    var cycles: [Int]
    var first = true

    init(_ seq: Seq, _ r: Int? = nil) {
        self.pool = [Seq.Element](seq)
        let n = pool.count
        self.r = r ?? n
        self.indecies = [Int](0..<n)
        self.cycles = [Int](((n-self.r+1)...n).reversed())
    }

    mutating func next() -> [Seq.Element]? {
        let n = pool.count
        guard r <= n else { return nil }
        guard !first else {
            first = false
            return indecies[..<r].map { pool[$0] }
        }

        for i in (0..<r).reversed() {
            cycles[i] -= 1
            
            if cycles[i] == 0 {
                indecies[i...] = indecies[(i+1)...] + indecies[i..<i+1]
                cycles[i] = n - i
            } else {
                let j = cycles[i]
                (indecies[i], indecies[n-j]) = (indecies[n-j], indecies[i])
                return indecies[..<r].map { pool[$0] }
            }
        }
        return nil
    }
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

private struct FastCombination {
    var mod: Int
    var fac: [Int]
    var finv: [Int]
    var inv: [Int]
    
    init(max: Int, mod: Int) {
        self.mod = mod
        self.fac = [Int](repeating: 0, count: max)
        self.finv = [Int](repeating: 0, count: max)
        self.inv = [Int](repeating: 0, count: max)
        
        fac[0] = 1
        fac[1] = 1
        finv[0] = 1
        finv[1] = 1
        inv[1] = 1
        
        for i in 2..<max {
            fac[i] = fac[i-1] * i % mod
            inv[i] = mod - inv[mod%i] * (mod / i) % mod
            finv[i] = finv[i-1] * inv[i] % mod
        }
    }
    
    func C(_ n: Int, _ r: Int) -> Int {
        guard n >= r || n < 0 || r < 0 else { return 0 }
        return fac[n] * (finv[r] * finv[n-r] % mod) % mod
    }
}
