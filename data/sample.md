---
title: "ドキュメント生成機能 検証テスト"
---

# 🚀 ドキュメント生成機能 検証テスト

> このドキュメントは、Pandoc変換機能（日本語対応、目次生成、GitHubスタイル、PlantUML/Mermaid対応）の動作検証のために作成されました。

---

## 1. 見出しレベルの検証

### 1.1. Level 3

#### 1.1.1. Level 4

##### 1.1.1.1. Level 5

###### 1.1.1.1.1. Level 6

###### 1.1.1.1.1.1. Level 7 (HTML変換後に正しく表示されるか確認)

---

## 2. 日本語とテキスト装飾の検証

標準的な日本語テキストと、各種Markdown記法が正しく処理されるか確認します。

これは**太字**のテキストです。
これは*斜体*のテキストです。
これは~~打ち消し線~~のテキストです。

リストも検証します:
* アイテム1 (日本語)
* アイテム2 (PlantUMLの次)
    * サブアイテム (Mermaidの前)

---

## 3. コードサンプル

コードのサンプルです。  

```java
public class Sample {
  public stati void main(String[] args) {
    System.out.println("sample code.");
  }
}
```

```http
POST http://localhost:8001/api/post HTTP/1.1
content-type: application/json
Accept: application/json

{
    "user_id": "1",
    "title": "title",
    "body": "body",
    "status": "2"
}
```

コードスパン`sample` のサンプルです。  
