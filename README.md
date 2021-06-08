# 競技プログラミング用のSwiftライブラリ

- Combinatorics.swift
  - 組み合わせ論ライブラリです。(順列、組み合わせなど)
- Deque.swift
  - Dequeです。改善の余地ありまくりです。バッファにArrayを利用しているため、動的に領域を確保する際に大きなオーバーヘッドがあります。UnsafeMutablePointerで実装できるみたいです。
  - 使用例: https://atcoder.jp/contests/abc158/submissions/14605181
- Number.swift
  - 整数論ライブラリです。(GCD, LCMなど)
- PriorityQueue.swift
  - 優先度付きキューです。
- UnionFind.swift
  - Union Find木です。
