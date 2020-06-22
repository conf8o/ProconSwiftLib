# 競技プログラミング用のSwiftライブラリ

Released under the MIT license. Please see LICENSE.txt

---

- Combinatorics.swift
  - 組み合わせ論ライブラリです(順列、組み合わせ)
- Deque.swift
  - Dequeです。改善の余地ありまくりです。バッファにArrayを利用しているため、動的に領域を確保する際に大きなオーバーヘッドがあります。UnsafeMutablePointerで実装したいです。
- Number.swift
  - 整数論ライブラリです(GCD, LCMなど)
- PriorityQueue.swift
  - 優先度付きキューです(シーケンスから初期化できるように実装していません。逐次appendする必要があります)
- UnionFind.swift
  - Union Find木です。
