# Amend Commit (Sửa Commit) {#amend}

[i[Commit-->Amending]<]

Git cho bạn khả năng sửa commit cuối cùng một cách tương đối dễ dàng.

> **Cẩn thận!** Phần này nói về việc thay đổi lịch sử, và đừng quên Quy Tắc Số Một Khi Thay Đổi Lịch Sử: ngươi không được thay đổi lịch sử của bất cứ thứ gì đã push, kẻo người khác đã pull thay đổi trước đó của ngươi, khiến lịch sử commit của ngươi trở nên hoàn toàn lệch lạc và gây ra nhiều tiếng la hét.
>
> Nói ngắn gọn, nếu bạn đã push một thay đổi, hãy giả định rằng người khác đã pull nó và việc amend commit (thay đổi lịch sử) sẽ gây ra nhiều phiền toái.
> 
> Ngắn hơn nữa, nếu bạn đã push, đã muộn rồi. Không amend commit nữa.

Vậy một số trường hợp dùng là gì?

* Có thể bạn viết nhầm commit message và muốn viết lại.
* Có thể bạn quên thêm vài file.

Những điều mà không ai trong chúng ta từng làm, phải không nào?

## Sửa Commit Message

[i[Commit-->Amending commit messages]<]

Cái này khá dễ. Hãy lấy ví dụ về một commit tôi đã làm sai. Lưu ý rằng lúc này đã commit hoàn toàn---tôi đã chạy `git commit`. Nhưng, quan trọng là, tôi chưa push.

Hãy xem trạng thái và log:

``` {.default}
$ git status
  On branch main
  nothing to commit, working tree clean
$ git log
  commit d7fba6838a689c3de15a27e272e8e4123d7c2460 (HEAD -> main)
  Author: User <user@example.com>
  Date:   Thu Nov 21 20:39:04 2024 -0800

    addded
```

Có một chữ "d" thừa trong commit message. Sửa lại chỉ đơn giản như thế này:

``` {.default}
$ git commit --amend
```

Và ngay lập tức tôi được đưa vào editor để thay đổi message.

Nếu không muốn dùng editor, tôi có thể làm trực tiếp trên dòng lệnh:

``` {.default}
$ git commit --amend -m "the new commit message"
```

Lưu ý rằng cách này giữ nguyên tác giả của commit. (Điều này hầu như bạn luôn muốn vì bạn vốn là tác giả rồi.) Nếu muốn thay đổi identity, bạn phải cấu hình lại identity bằng `git config` rồi chạy:

``` {.default}
$ git commit --amend --reset-author
```

[i[Commit-->Amending commit messages]>]

## Thêm Một Số File Vào Commit

[i[Commit-->Amending files]<]

Ugh! Bạn vừa tạo commit nhưng quên thêm một trong các file vào! Bạn đã có `foo.c` và `bar.c` trong đó, nhưng bỏ sót `baz.h`!

Hãy xem nào.

``` {.default}
$ ls
  bar.c  baz.h  foo.c
$ git log --name-only
  commit b307686933dca3db718e6a3e3f8226be11e7e278 (HEAD -> main)
  Author: User <user@example.com>
  Date:   Thu Nov 21 20:47:08 2024 -0800

      added

  bar.c
  foo.c
```

OK, vậy làm thế nào để đưa `baz.h` vào? Như thế này:

1. `git add baz.h` để thêm nó vào stage.
2. `git commit --amend` để đưa nó vào commit.

Lệnh này sẽ mở editor để chỉnh sửa commit message. Bạn có thể lưu như cũ. Hoặc bạn có thể dùng tùy chọn `-m` trên dòng lệnh để đặt message mới.

Ngoài ra, nếu bạn chỉ thêm file, bạn có thể không cần thay đổi commit message. Trong trường hợp đó bạn có thể chạy:

``` {.default}
$ git commit --amend --no-edit
```

Lệnh đó sẽ thực hiện amend mà không chỉnh sửa commit message.

Và thế là xong---bạn có thể dễ dàng amend commit cuối cùng. Chỉ cần chắc chắn bạn chưa push trước khi làm.

[i[Commit-->Amending files]>]

[i[Commit-->Amending]>]
