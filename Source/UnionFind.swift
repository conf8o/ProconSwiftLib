import Foundation

private struct UnionFind {
    var parent: [Int]
    var rank: [Int]
    
    init(_ n: Int) {
        parent = Array(0..<n)
        rank = Array(repeating: 0, count: n)
    }
    
    public mutating func root(_ x: Int) -> Int {
        var x = x
        while parent[x] != x {
            parent[x] = parent[parent[x]]
            x = parent[x]
        }
        
        return parent[x]
    }
    
    public mutating func unite(_ x: Int, _ y: Int) {
        let x = root(x)
        let y = root(y)
        guard x != y else { return }
        
        if rank[x] < rank[y] {
            parent[x] = y
        } else {
            parent[y] = x
            if rank[x] == rank[y] {
                rank[x] += 1
            }
        }
    }
    
    public mutating func same(_ x: Int, _ y: Int) -> Bool {
        return root(x) == root(y)
    }
}
