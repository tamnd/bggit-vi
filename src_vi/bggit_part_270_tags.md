# Tag (Thẻ)

[i[Tag]<]

Tag là cách để chú thích một commit cụ thể. Bạn có thể nghĩ chúng như là các nhánh không di chuyển.

Trường hợp rất phổ biến là gắn một commit cụ thể với số phiên bản như `1.2.3`.

Tôi không tìm thấy bất kỳ quy tắc nào về ký tự có thể dùng trong tên tag, nhưng có vẻ an toàn khi dùng chữ cái ASCII hoa và thường, số, và dấu câu như `.`, `-`, và `_`, v.v.

Có hai loại tag:

* ***Lightweight (Nhẹ)***: Chỉ là một tag, ví dụ `v3.14`.
* ***Annotated (Có chú thích)***: Cũng là một tag, ví dụ `v3.14`, nhưng bao gồm message và tác giả, giống như commit.

Bạn thường có thể dùng tag theo cùng cách bạn dùng nhánh (bạn có thể diff chúng, switch đến chúng, v.v.) ngoại trừ chúng không di chuyển.

[i[Tag-->Listing]<]

Và bạn có thể thấy chúng trong log cùng với thông tin nhánh khác.

``` {.default}
commit 4fa1199d17a97990a7721eb8a73a4ee50 (HEAD -> main, tag: v3.14)
Author: User <user@example.com>
Date:   Sat Jan 25 19:04:43 2025 -0800

    Update the stuff

commit c265e0371b3fc11588e4183b35e0b96e3 (tag: v3.10)
Author: User <user@example.com>
Date:   Sat Jan 25 18:59:58 2025 -0800

    Add the stuff
```

Hoặc lấy danh sách tất cả tag chỉ với `git tag`.

[i[Tag-->Listing]>]

## Lightweight Tag

[i[Tag-->Creating]<]
[i[Tag-->Lightweight]<]

Thêm lightweight tag khá đơn giản. Trước tiên, switch đến commit bạn muốn tag, rồi chạy lệnh này, giả sử bạn muốn một tag gọi là `tagname`:

``` {.default}
$ git tag tagname       # Tag HEAD commit with tagname
```

Bạn cũng có thể tag một commit, hoặc bất cứ thứ gì tham chiếu đến một commit (như nhánh hay thậm chí một tag khác):

``` {.default}
$ git tag CPE1704TKS 4fa12    # tag commit 4fa12
$ git tag plover feature99    # tag branch feature99
```

[i[Tag-->Lightweight]>]

## Annotated Tag

[i[Tag-->Annotated]<]

Thêm annotated tag cũng gần như dễ dàng. Thêm `-a` cho switch "annotate".

Vì annotated tag giống commit hơn, nó sẽ hỏi message. Nhưng bạn cũng có thể dùng `-m` để chỉ định trên dòng lệnh.

``` {.default}
$ git tag -a v3490     # tag HEAD commit with v3490
```

Hoặc nếu bạn muốn chỉ định message trên dòng lệnh:

``` {.default}
$ git tag -a v3490 -m "tag message"
```

[i[Tag-->Annotated]>]
[i[Tag-->Creating]>]

## Push Tag

[i[Tag-->Pushing]<]

Theo mặc định, tag chỉ tồn tại trên repo cục bộ của bạn, ngay cả khi bạn push thông thường. Bạn phải bảo nó rõ ràng rằng bạn muốn push tag.

[i[Push-->Tags]]
Nếu bạn muốn push tất cả tag mới, bạn có thể:

``` {.default}
$ git push --tags
$ git push origin --tags  # Or you can specify a remote
```

Nếu bạn chỉ muốn push một tag, bạn phải chỉ định remote:

``` {.default}
$ git push origin tag3.14
```

Sau khi một tag được push, các cộng tác viên khác sẽ tự động nhận được tag khi họ pull.

[i[Tag-->Pushing]>]

## Xóa Tag

[i[Tag-->Deleting]<]

Bạn có thể xóa một tag trên repo của mình như thế này:

``` {.default}
$ git tag -d tagname
```

Và điều đó khá đơn giản. Ngoại trừ nếu bạn đã push lên server. Nếu có, lần pull tiếp theo bạn sẽ lại nhận được tag đó.

Vì vậy bạn cũng phải xóa cái trên remote, cũng phải đặt tên rõ ràng:

[i[Push-->Tags]]

``` {.default}
$ git push origin -d tagname
```

Điều đó sẽ xóa tag trên server, nhưng *nó sẽ không xóa khỏi clone của người khác*. Thực ra, không có cách dễ dàng để làm điều này.

Ý tưởng cơ bản là tag, một khi được tạo ra, không nên bị xóa. Giờ, nếu bạn chưa push, không có vấn đề gì. Thêm, xóa, và thay đổi thoải mái. Nhưng một khi bạn đã push (và ai đó đã pull), nếu bạn cần thay đổi một tag, hãy tạo một tag mới.

Đó không phải là luật; đó chỉ là hướng dẫn được đề nghị.

[i[Tag-->Deleting]>]
[i[Tag]>]
